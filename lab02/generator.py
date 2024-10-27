import faker
import faker.generator
import faker.providers
import faker.providers.automotive
import faker.providers.automotive.pl_PL
import faker.providers.person.pl_PL
import numpy as np
import pandas as pd
import sqlite3
import time
import json
import math
import re
from pathlib import Path
import sys
from typing import Literal, TypeAlias

SEED = 2137

START_DATE = '2021-01-01'
INT_DATE = '2021-12-31'
END_DATE = '2022-03-31'
NUMBER_OF_EGZAMINATORS = 10
NUMBER_OF_ROOMS = 5
NUMBER_OF_CANDIDATES = 20000
NUMBER_OF_CONCURRENT_EXAMS = min(NUMBER_OF_ROOMS, NUMBER_OF_EGZAMINATORS)
NUMBER_OF_INCIDENTS = 100
NUMBER_OF_COMPLAINTS = 100

ROOM_NUMBER_MIN = 100
ROOM_NUMBER_MAX = 999
NUMBER_OF_STANDS_PER_ROOM_MIN = 10
NUMBER_OF_STANDS_PER_ROOM_MAX = 20
QUESTIONS_PER_TEST = 30

EXAM_DURATION = 30  # minutes
EXAM_DURATION_MAX_OFFSET = 10  # minutes

EXAM_HOURS = np.array([8, 10.5, 12, 14, 16, 18]) * pd.Timedelta(hours=1)
EXAM_START_MAX_DELAY = 5  # minutes
EXAM_REPETITION_COOLDOWN = 12 # days

STANDS_OCCUPANCY_PERCENTAGE_MIN = 0.8
STANDS_OCCUPANCY_PERCENTAGE_MAX = 1.0

RESERVATION_DELTATIME_MIN = 10  # days
RESERVATION_DELTATIME_MAX = 30  # days

QUESTIONS_COUNT = 30

QUESTIONS_CSV = 'data/pytania.csv'

FIRST_BATCH_RATIO = (pd.to_datetime(INT_DATE) - pd.to_datetime(START_DATE)) / (pd.to_datetime(END_DATE) - pd.to_datetime(START_DATE))

print(FIRST_BATCH_RATIO)

TIME_FORMAT = '%Y-%m-%d %H:%M:%S'

Sex: TypeAlias = Literal['M', 'F']

fake = faker.Faker('pl_PL')


def generate_pesel(sex: Sex):
    provider = faker.providers.person.pl_PL.Provider(fake)
    return provider.pesel(sex=sex)


def generate_pkk():
    return ''.join([str(fake.random_digit()) for _ in range(20)])


def generate_name(sex: Sex):
    if sex == 'M':
        return fake.first_name_male() + ' ' + fake.last_name_male()
    else:
        return fake.first_name_female() + ' ' + fake.last_name_female()


def random_locally_unique_blocks(a: np.ndarray, block_size: int, size: int):
    a = np.apply_along_axis(np.random.choice, axis=1, arr=np.broadcast_to(np.reshape(a, (1, -1)), (math.ceil(size/block_size), a.size)), size=block_size)
    return np.reshape(a, (1, -1))[0, :size]


def setup_database():
    # conn = sqlite3.connect('lab02.db')
    conn = sqlite3.connect(':memory:')
    c = conn.cursor()

    with open('initialize_database_schema.sql') as f:
        query_lines = f.readlines()
    query_lines = [line.strip() for line in query_lines if line.startswith('CREATE TABLE')]
    query = ';'.join(query_lines)
    query = query.replace('max', '256')
    query = query.replace('uniqueidentifier', 'INTEGER')

    c.executescript(query)

    return conn, c


def generate_egzaminators(c: sqlite3.Cursor, number_of_egzaminators: int):
    for _ in range(number_of_egzaminators):
        sex = fake.random_element(['M', 'F'])
        pesel = generate_pesel(sex)
        name = generate_name(sex)
        c.execute('INSERT INTO Egzaminatorzy (Pesel, Nazwa) VALUES (?, ?)', (pesel, name))


def generate_rooms_and_stands(c: sqlite3.Cursor, number_of_rooms: int):
    for _ in range(number_of_rooms):
        room_number = fake.random_int(ROOM_NUMBER_MIN, ROOM_NUMBER_MAX)
        number_of_stands = fake.random_int(NUMBER_OF_STANDS_PER_ROOM_MIN, NUMBER_OF_STANDS_PER_ROOM_MAX)
        c.execute('INSERT INTO SaleEgzaminacyjne VALUES (?)', (room_number,))
        c.executemany('INSERT INTO StanowiskaEgzaminacyjne (NumerSali) VALUES (?)', [(room_number,)]*number_of_stands)


def generate_candidates(c: sqlite3.Cursor, number_of_candidates: int):
    for _ in range(number_of_candidates):
        pkk = generate_pkk()
        name = generate_name(fake.random_element(['M', 'F']))
        c.execute('INSERT INTO Kandydaci (PKK, Nazwa) VALUES (?, ?)', (pkk, name))


def load_questions(conn: sqlite3.Connection):
    questions = pd.read_csv(QUESTIONS_CSV, encoding='utf-16')
    questions.to_sql('Pytania', conn, if_exists='replace')


def generate_exams(c: sqlite3.Cursor, conn: sqlite3.Connection, date_from: str, date_to: str):
    all_rooms = np.array(c.execute('SELECT NumerSali FROM SaleEgzaminacyjne').fetchall())[:, 0]
    all_egzaminators = np.array(c.execute('SELECT Id FROM Egzaminatorzy').fetchall())[:, 0]
    stands_by_room = {room: np.array(c.execute('SELECT Id FROM StanowiskaEgzaminacyjne WHERE NumerSali = ?', (int(room),)).fetchall())[:, 0] for room in all_rooms}
    all_candidates = np.array(c.execute('SELECT PKK FROM Kandydaci').fetchall())[:, 0]

    previous_exams_count = c.execute('SELECT MAX(Id) FROM EgzaminyTeoretyczne').fetchone()[0]
    if previous_exams_count is None:
        previous_exams_count = 0

    dates = pd.bdate_range(date_from, date_to).to_numpy()

    exam_planned_times = np.repeat(dates, len(EXAM_HOURS)) + np.tile(EXAM_HOURS, len(dates))
    exam_planned_times = np.repeat(exam_planned_times, NUMBER_OF_CONCURRENT_EXAMS)
    exam_count = len(exam_planned_times)
    exam_rooms = random_locally_unique_blocks(all_rooms, NUMBER_OF_CONCURRENT_EXAMS, exam_count)
    exam_egzaminators = random_locally_unique_blocks(all_egzaminators, NUMBER_OF_CONCURRENT_EXAMS, exam_count)

    df = pd.DataFrame({
        'Id': np.arange(previous_exams_count + 1, previous_exams_count + exam_count+1),
        'ZaplanowanyTermin': exam_planned_times,
        'NumerSaliEgzaminacyjnej': exam_rooms,
        'IdEgzaminatora': exam_egzaminators
    })
    df.set_index('Id', inplace=True)
    df.to_sql('EgzaminyTeoretyczne', conn, if_exists='append')

    all_stand_counts = np.array([len(stands_by_room[room]) for room in all_rooms])
    exam_room_indexes = exam_rooms.copy()
    for i, room in enumerate(all_rooms):
        exam_room_indexes[exam_rooms == room] = i
    
    exam_stand_counts = all_stand_counts[exam_room_indexes]
    exam_stand_occupancy = np.random.uniform(STANDS_OCCUPANCY_PERCENTAGE_MIN, STANDS_OCCUPANCY_PERCENTAGE_MAX, exam_count)
    exam_stand_counts = np.round(exam_stand_counts*exam_stand_occupancy).astype(int)

    exam_process_exam_ids = np.repeat(np.arange(exam_count) + 1, exam_stand_counts)
    exam_process_count = len(exam_process_exam_ids)
    exam_process_confirmed_readyness_times = np.repeat(exam_planned_times, exam_stand_counts)
    exam_process_start_times = exam_process_confirmed_readyness_times + pd.to_timedelta(np.random.randint(0, EXAM_START_MAX_DELAY*60, len(exam_process_confirmed_readyness_times)), unit='s')
    durations = np.random.randint((EXAM_DURATION - EXAM_DURATION_MAX_OFFSET)*60, (EXAM_DURATION + EXAM_DURATION_MAX_OFFSET)*60, len(exam_process_start_times))
    exam_process_end_times = exam_process_start_times + pd.to_timedelta(durations, unit='s')

    reservation_deltatimes = pd.to_timedelta(np.random.randint(RESERVATION_DELTATIME_MIN*24*60*60, RESERVATION_DELTATIME_MAX*24*60*60, len(exam_process_start_times)), unit='s')
    exam_process_reservation_times = exam_process_start_times - reservation_deltatimes

    exam_process_stand_ids = np.zeros(exam_process_count, dtype=int)
    i = 0
    for room, stand_count in zip(exam_rooms, exam_stand_counts):
        stands = stands_by_room[room]
        stand_indexes = np.random.choice(stand_count, stand_count, replace=False)
        exam_process_stand_ids[i:i+stand_count] = stands[stand_indexes]
        i += stand_count

    MAX_CLOSE_DISTANCE = NUMBER_OF_STANDS_PER_ROOM_MAX * NUMBER_OF_CONCURRENT_EXAMS * len(EXAM_HOURS) * EXAM_REPETITION_COOLDOWN

    exam_process_candidates = random_locally_unique_blocks(all_candidates, MAX_CLOSE_DISTANCE, exam_process_count)

    previous_processes_count = c.execute('SELECT MAX(Id) FROM PrzebiegiEgzaminowKandydata').fetchone()[0]
    if previous_processes_count is None:
        previous_processes_count = 0

    df = pd.DataFrame({
        'Id': np.arange(previous_processes_count + 1, previous_processes_count + exam_process_count+1),
        'IdEgzaminuTeoretycznego': exam_process_exam_ids,
        'IdStanowiskaEgzaminacyjnego': exam_process_stand_ids,
        'PKKKandydata': exam_process_candidates,
        'CzasRezerwacjiTerminu': exam_process_reservation_times,
        'CzasPotwierdzeniaGotowosciPrzezKandydata': exam_process_confirmed_readyness_times,
        'CzasRozpoczeciaEgzaminu': exam_process_start_times,
        'CzasZakonczeniaEgzaminu': exam_process_end_times,
    })
    df.set_index('Id', inplace=True)
    df.to_sql('PrzebiegiEgzaminowKandydata', conn, if_exists='append')


def generate_planned_questions(c: sqlite3.Cursor, conn: sqlite3.Connection):
    questions = c.execute('SELECT Id FROM Pytania').fetchall()
    questions = np.array(questions)[:, 0]
    exam_processes = pd.read_sql('SELECT * FROM PrzebiegiEgzaminowKandydata WHERE CzasRozpoczeciaEgzaminu IS NOT NULL AND Id NOT IN (SELECT IdPrzebieguEgzaminu FROM ZaplanowanePytania)', conn)
    exam_process_ids = exam_processes['Id'].to_numpy()
    exam_processes['CzasZakonczeniaEgzaminu'] = pd.to_datetime(exam_processes['CzasZakonczeniaEgzaminu'])
    exam_processes['CzasRozpoczeciaEgzaminu'] = pd.to_datetime(exam_processes['CzasRozpoczeciaEgzaminu'])
    exam_process_durations = exam_processes['CzasZakonczeniaEgzaminu'] - exam_processes['CzasRozpoczeciaEgzaminu']
    exam_process_durations = exam_process_durations.dt.total_seconds().to_numpy()

    planned_questions_exam_process_ids = np.repeat(exam_process_ids, QUESTIONS_COUNT)
    planned_questions_count = len(planned_questions_exam_process_ids)
    planned_questions_priority = np.tile(np.arange(QUESTIONS_COUNT), planned_questions_count//QUESTIONS_COUNT)
    planned_questions_question_ids = random_locally_unique_blocks(questions, QUESTIONS_COUNT, planned_questions_count)

    planned_questions_times = np.zeros((planned_questions_count//QUESTIONS_COUNT, QUESTIONS_COUNT))
    planned_questions_times_i = 0
    for i in range(QUESTIONS_COUNT-10, QUESTIONS_COUNT):
        probability = 1/(QUESTIONS_COUNT-i) * 0.01
        num_to_generate = np.random.uniform(0, probability, 1)[0] * planned_questions_count
        num_to_generate = int(num_to_generate)
        times = np.random.dirichlet(np.ones(i), size=num_to_generate)
        planned_questions_times[planned_questions_times_i:planned_questions_times_i+num_to_generate, :i] = times
        planned_questions_times_i += num_to_generate

    num_to_generate = planned_questions_count//QUESTIONS_COUNT - planned_questions_times_i
    planned_questions_times[planned_questions_times_i:, :] = np.random.dirichlet(np.ones(QUESTIONS_COUNT), size=num_to_generate)
    np.random.shuffle(planned_questions_times)
    planned_questions_times *= exam_process_durations[:, np.newaxis]
    planned_questions_times = np.reshape(planned_questions_times, (1, -1))[0]

    planned_questions_result = np.random.choice([0, 1], planned_questions_count, p=[0.1, 0.9])
    planned_questions_result[planned_questions_times == 0] = -69

    planned_questions_times = np.reshape(planned_questions_times, (-1, QUESTIONS_COUNT))
    planned_questions_times = np.cumsum(planned_questions_times, axis=1)
    planned_questions_times = np.reshape(planned_questions_times, (1, -1))[0]

    planned_questions_times = np.repeat(exam_processes['CzasRozpoczeciaEgzaminu'], QUESTIONS_COUNT) + pd.to_timedelta(planned_questions_times, unit='s')

    previous_planned_questions_count = c.execute('SELECT COUNT(*) FROM ZaplanowanePytania').fetchone()[0]

    df = pd.DataFrame({
        'Id': np.arange(previous_planned_questions_count + 1, previous_planned_questions_count + planned_questions_count+1),
        'IdPrzebieguEgzaminu': planned_questions_exam_process_ids,
        'IdPytania': planned_questions_question_ids,
        'CzyZostalaUdzielonaPoprawnaOdpowiedz': planned_questions_result.astype(int),
        'CzasUdzieleniaOdpowiedzi': planned_questions_times,
        'PriorytetPytania': planned_questions_priority,
    })
    df.set_index('Id', inplace=True)
    df.to_sql('ZaplanowanePytania', conn, if_exists='append')

    c.execute('UPDATE ZaplanowanePytania SET CzasUdzieleniaOdpowiedzi = NULL WHERE CzyZostalaUdzielonaPoprawnaOdpowiedz = -69')


def generate_incidents(c: sqlite3.Cursor, conn: sqlite3.Connection, number_of_incidents: int, start_date: str = START_DATE):
    incidents_source = json.load(open('incydenty.json'))
    all_reasons = np.array([incident['powod'] for incident in incidents_source])
    all_contents = np.array([incident['tresc'] for incident in incidents_source])
    exams = pd.read_sql('SELECT Id FROM PrzebiegiEgzaminowKandydata WHERE CzasRozpoczeciaEgzaminu IS NOT NULL AND CzasRozpoczeciaEgzaminu > ? ORDER BY RANDOM() LIMIT ?', conn, params=(start_date, number_of_incidents,))
    exams = np.array(exams)[:, 0]
    reason_idxs = np.random.choice(len(all_reasons), number_of_incidents, replace=True)

    previous_incidents_count = c.execute('SELECT COUNT(*) FROM Incydenty').fetchone()[0]

    df = pd.DataFrame({
        'Id': np.arange(previous_incidents_count + 1, previous_incidents_count + number_of_incidents+1),
        'IdEgzaminu': exams,
        'Powod': all_reasons[reason_idxs],
        'Tresc': all_contents[reason_idxs]
    })
    df.set_index('Id', inplace=True)
    df.to_sql('Incydenty', conn, if_exists='append')


def replace_guids(filename: str, table: str):
    with open(filename, encoding='utf-16') as f:
        content = f.readlines()
    
    header, content = content[0], content[1:]

    headers = header.split(',')
    ids = [i for i, header in enumerate(headers) if 'Id' in header]

    # insert_prompt = f'INSERT INTO {table}({header.strip()}) VALUES (\''

    for i in ids:
        for j, line in enumerate(content):
            line = line.strip().split(',')
            if not re.match(r'^\d+$', line[i]):
                break
            line[i] = f'28c52b60-a9da-452b-8d86-{line[i]:>012}'
            content[j] = ','.join(line) + '\n'
            # prompt = insert_prompt + "','".join(line) + '\');\n'
            # content[j] = prompt

    content = ''.join(content)

    with open(filename, 'w', encoding='utf-16') as f:
        f.write(content)


def generate_excel(c: sqlite3.Cursor, conn: sqlite3.Connection, number_of_complaints: int, start_date: str = START_DATE):
    complain_contents = json.load(open('skargi.json', encoding='utf-8'))
    contents_df = pd.DataFrame(complain_contents)

    query = ('SELECT * FROM PrzebiegiEgzaminowKandydata '
             'JOIN EgzaminyTeoretyczne ON PrzebiegiEgzaminowKandydata.IdEgzaminuTeoretycznego = EgzaminyTeoretyczne.Id '
             'JOIN Egzaminatorzy ON EgzaminyTeoretyczne.IdEgzaminatora = Egzaminatorzy.Id '
             'LEFT JOIN Incydenty ON EgzaminyTeoretyczne.Id = Incydenty.IdEgzaminu '
             'WHERE CzasRozpoczeciaEgzaminu IS NOT NULL '
             'AND CzasRozpoczeciaEgzaminu > ? ')
    df = pd.read_sql(query, conn, params=(start_date,))

    df['ComplaintDate'] = pd.to_datetime(df['CzasZakonczeniaEgzaminu']) + pd.to_timedelta(np.random.choice([0, 1], len(df), replace=True), unit='d')
    df['ZaplanowanyTermin'] = pd.to_datetime(df['ZaplanowanyTermin'])

    exam_process_with_incident = df[df['IdEgzaminu'].notnull()]
    exam_process_without_incident = df[df['IdEgzaminu'].isnull()]

    COMPLAIN_WITH_INCIDENT_CHANCE = 0.6
    complain_with_incident_count = int(min(len(exam_process_with_incident), number_of_complaints) * COMPLAIN_WITH_INCIDENT_CHANCE)
    complain_without_incident_count = number_of_complaints - complain_with_incident_count

    exam_process_with_incident = exam_process_with_incident.sample(complain_with_incident_count)
    exam_process_without_incident = exam_process_without_incident.sample(complain_without_incident_count)

    complaints_with_incident = ['związana z technicznym przebiegiem egzaminu']
    complaints_without_incident = ['związana z treścią pytań', 'związana z egzaminatorem', 'inne']

    res1 = pd.DataFrame({
        'PKK Kantydanta': exam_process_with_incident['PKKKandydata'],
        'Pesel Egzaminatora': exam_process_with_incident['Pesel'],
        'Termin egzaminu': exam_process_with_incident['ZaplanowanyTermin'].dt.strftime('%d-%m-%Y %H:%M:%S'),
        'Typ egzaminu': 'teoretyczny',
        'Powód skargi': complaints_with_incident[0],
        'Treść skargi': 'Treść skargi',
        'Data złożenia skargi': exam_process_with_incident['ComplaintDate'].dt.strftime('%d-%m-%Y')
    })
    res1['Treść skargi'] = contents_df[contents_df['typ_skargi'] == complaints_with_incident[0]].sample(len(res1), replace=True)['tresc'].to_numpy()


    content_without_incident = contents_df[contents_df['typ_skargi'] != complaints_with_incident[0]]
    content_without_incident = content_without_incident.sample(complain_without_incident_count, replace=True)
    res2 = pd.DataFrame({
        'PKK Kantydanta': exam_process_without_incident['PKKKandydata'],
        'Pesel Egzaminatora': exam_process_without_incident['Pesel'],
        'Termin egzaminu': exam_process_without_incident['ZaplanowanyTermin'].dt.strftime('%d-%m-%Y %H:%M:%S'),
        'Typ egzaminu': 'teoretyczny',
        'Powód skargi': content_without_incident['typ_skargi'].to_numpy(),
        'Treść skargi': content_without_incident['tresc'].to_numpy(),
        'Data złożenia skargi': exam_process_without_incident['ComplaintDate'].dt.strftime('%d-%m-%Y')
    })
    # res2['Treść skargi'] = contents_df.sample(len(res2))['tresc'].to_numpy()

    res = pd.concat([res1, res2])
    res.sort_values('Termin egzaminu', inplace=True)

    examiners_df = pd.read_sql('SELECT * FROM Egzaminatorzy', conn)

    examiners_res = pd.DataFrame({
        'Pesel Egzaminatora': examiners_df['Pesel'],
        'Imię i nazwisko egzaminatora': examiners_df['Nazwa']
    })

    with pd.ExcelWriter('skargi.xlsx') as writer:
        res.to_excel(writer, sheet_name='Skargi', index=False)
        examiners_res.to_excel(writer, sheet_name='Lista egzaminatorów', index=False)


def print_process_with_timer(process_name: str, process: callable, proc_args: tuple = (), proc_kwargs: dict = {}):
    print(process_name, end=' ')
    sys.stdout.flush()
    s = time.time()
    res = process(*proc_args, **proc_kwargs)
    print('took', time.time() - s, 'seconds')
    return res


def dump_data(conn: sqlite3.Connection, target_dir: Path, whole_dump: bool = False):
    columns_to_files = {
        'Kandydaci': 'kandydaci.csv',
        'Egzaminatorzy': 'egzaminatorzy.csv',
        'SaleEgzaminacyjne': 'sale_egzaminacyjne.csv',
        'StanowiskaEgzaminacyjne': 'stanowiska_egzaminacyjne.csv',
        'ZaplanowanePytania': 'zaplanowane_pytania.csv',
        'EgzaminyTeoretyczne': 'egzaminy_teoretyczne.csv',
        'PrzebiegiEgzaminowKandydata': 'przebiegi_egzaminow_kandydata.csv',
        'Incydenty': 'incydenty.csv'
    }

    for table, filename in columns_to_files.items():
        columns_to_files[table] = target_dir / filename

    Path('skargi.xlsx').rename(target_dir / 'skargi.xlsx')

    if whole_dump:
        for table, filename in columns_to_files.items():
            pd.read_sql(f'SELECT * FROM {table}', conn).to_csv(filename, index=False, encoding='utf-16')
    
    for table, filename in columns_to_files.items():
        replace_guids(filename, table)

    with open(target_dir / 'zaplanowane_pytania.csv', encoding='utf-16') as f:
        content = f.read()
    content = content.replace('-69', '')
    with open(target_dir / 'zaplanowane_pytania.csv', 'w', encoding='utf-16') as f:
        f.write(content)
    
    Path(target_dir / 'pytania.csv').write_text(Path(QUESTIONS_CSV).read_text(encoding='utf-16'), encoding='utf-16')
    replace_guids(target_dir / 'pytania.csv', 'Pytania')


def verify_integrity(c: sqlite3.Cursor, conn: sqlite3.Connection):
    # every reservation time should be after the last failed exam by the same candidate
    # reservation time should be not less than EXAM_REPETITION_COOLDOWN days before the exam

    query = ('SELECT PKK, CzasRezerwacjiTerminu, CzasRozpoczeciaEgzaminu '
                'FROM PrzebiegiEgzaminowKandydata '
                'WHERE CzasRozpoczeciaEgzaminu IS NOT NULL '
                'ORDER BY PKK, CzasRozpoczeciaEgzaminu')


def make_some_modifications(c: sqlite3.Cursor, conn: sqlite3.Connection):
    female_egzaminators = pd.read_sql('SELECT * FROM Egzaminatorzy '
                                     'WHERE Pesel LIKE "_________0_" '
                                     'OR Pesel LIKE "_________2_" '
                                     'OR Pesel LIKE "_________4_" '
                                     'OR Pesel LIKE "_________6_" '
                                     'OR Pesel LIKE "_________8_"', conn)
    male_egzaminators = pd.read_sql('SELECT * FROM Egzaminatorzy '
                                    'WHERE Pesel LIKE "_________1_" '
                                    'OR Pesel LIKE "_________3_" '
                                    'OR Pesel LIKE "_________5_" '
                                    'OR Pesel LIKE "_________7_" '
                                    'OR Pesel LIKE "_________9_"', conn)
    to_change = min(len(female_egzaminators), len(male_egzaminators), 3)

    female_egzaminators = female_egzaminators.sample(to_change)
    male_egzaminators = male_egzaminators.sample(to_change)

    for (_, f), (_, m) in zip(female_egzaminators.iterrows(), male_egzaminators.iterrows()):
        f_name, f_surname = f['Nazwa'].split()
        m_name, m_surname = m['Nazwa'].split()
        f_surname = f'{f_surname}-{m_surname}'
        new_f_name = f'{f_name} {f_surname}'
        c.execute('UPDATE Egzaminatorzy SET Nazwa = ? WHERE Pesel = ?', (new_f_name, f['Pesel']))


processes_to_bring_back = None
lowest_process_id_with_null_start = None


def generate_first_dump(start_date: str, interrupt_date: str):
    global processes_to_bring_back, lowest_process_id_with_null_start
    print('Generating first dump')

    target_dir = Path('.') / 'data/first_dump'
    target_dir.mkdir(exist_ok=True, parents=True)

    conn, c = print_process_with_timer('Setting up database', setup_database)
    print_process_with_timer('Generating egzaminators', generate_egzaminators, (c, NUMBER_OF_EGZAMINATORS))
    print_process_with_timer('Generating rooms and stands', generate_rooms_and_stands, (c, NUMBER_OF_ROOMS))
    print_process_with_timer('Generating candidates', generate_candidates, (c, int(NUMBER_OF_CANDIDATES*FIRST_BATCH_RATIO)))
    print_process_with_timer('Loading questions', load_questions, (conn,))

    offseted_end_date = (pd.to_datetime(interrupt_date) + pd.Timedelta(days=40)).strftime(TIME_FORMAT)
    print_process_with_timer('Generating exams', generate_exams, (c, conn, start_date, offseted_end_date))

    # verify_integrity()

    processes_to_bring_back = pd.read_sql('SELECT * FROM PrzebiegiEgzaminowKandydata', conn)
    c.execute('DELETE FROM PrzebiegiEgzaminowKandydata WHERE CzasRezerwacjiTerminu > ?', (interrupt_date,))
    c.execute('UPDATE PrzebiegiEgzaminowKandydata SET CzasPotwierdzeniaGotowosciPrzezKandydata = NULL, CzasRozpoczeciaEgzaminu = NULL, CzasZakonczeniaEgzaminu = NULL WHERE CzasRozpoczeciaEgzaminu > ?', (interrupt_date,))

    lowest_process_id_with_null_start = c.execute('SELECT MIN(Id) FROM PrzebiegiEgzaminowKandydata WHERE CzasRozpoczeciaEgzaminu IS NULL').fetchone()[0]
    if lowest_process_id_with_null_start is None:
        raise Exception('No processes with null start time')

    print_process_with_timer('Generating planned questions', generate_planned_questions, (c, conn))
    print_process_with_timer('Generating incidents', generate_incidents, (c, conn, int(NUMBER_OF_INCIDENTS*FIRST_BATCH_RATIO)))
    print_process_with_timer('Generating excel', generate_excel, (c, conn, int(NUMBER_OF_COMPLAINTS*FIRST_BATCH_RATIO)))

    print_process_with_timer('Exporting to CSV', dump_data, (conn, target_dir, True))

    return c, conn


def refill_exam_processes(c: sqlite3.Cursor, conn: sqlite3.Connection):
    c.execute('DELETE FROM PrzebiegiEgzaminowKandydata')
    processes_to_bring_back.to_sql('PrzebiegiEgzaminowKandydata', conn, if_exists='append', index=False)


def generate_second_dump(interrupt_date: str, end_date: str, c: sqlite3.Cursor, conn: sqlite3.Connection):
    print('Generating second dump')

    target_dir = Path('.') / 'data/second_dump'
    target_dir.mkdir(exist_ok=True, parents=True)
    
    highest_prev_exam_id = c.execute('SELECT MAX(Id) FROM EgzaminyTeoretyczne').fetchone()[0]
    if highest_prev_exam_id is None:
        highest_prev_exam_id = 0

    print_process_with_timer('Making some modifications', make_some_modifications, (c, conn))

    refill_exam_processes(c, conn)

    print_process_with_timer('Generating candidates', generate_candidates, (c, NUMBER_OF_CANDIDATES - int(NUMBER_OF_CANDIDATES*FIRST_BATCH_RATIO)))

    offseted_end_date = (pd.to_datetime(end_date) + pd.Timedelta(days=40)).strftime(TIME_FORMAT)

    last_exam_date = pd.to_datetime(c.execute('SELECT MAX(ZaplanowanyTermin) FROM EgzaminyTeoretyczne').fetchone()[0])
    # set to midnight next day
    last_exam_date = last_exam_date.replace(hour=0, minute=0, second=0) + pd.Timedelta(days=1)
    last_exam_date = last_exam_date.strftime(TIME_FORMAT)

    print_process_with_timer('Generating exams', generate_exams, (c, conn, last_exam_date, offseted_end_date))
    print_process_with_timer('Generating planned questions', generate_planned_questions, (c, conn))
    print_process_with_timer('Generating incidents', generate_incidents, (c, conn, NUMBER_OF_INCIDENTS - int(NUMBER_OF_INCIDENTS*FIRST_BATCH_RATIO), interrupt_date))
    print_process_with_timer('Generating excel', generate_excel, (c, conn, NUMBER_OF_COMPLAINTS - int(NUMBER_OF_COMPLAINTS*FIRST_BATCH_RATIO), interrupt_date))

    print('Exporting to CSV', end=' ')
    sys.stdout.flush()
    s = time.time()

    interrupt_date = pd.to_datetime(interrupt_date).replace(hour=0, minute=0, second=0) + pd.Timedelta(days=1)
    interrupt_date = interrupt_date.strftime(TIME_FORMAT)
    end_date = pd.to_datetime(end_date).replace(hour=0, minute=0, second=0) + pd.Timedelta(days=1)
    end_date = end_date.strftime(TIME_FORMAT)

    dump_data(conn, target_dir, True)
    print('took', time.time() - s, 'seconds')

    c.close()
    conn.commit()
    conn.close()

np.random.seed(SEED)
faker.Faker.seed(SEED)

c, conn = generate_first_dump(START_DATE, INT_DATE)
generate_second_dump(INT_DATE, END_DATE, c, conn)

# TODO
# - incidents - done
# - dumping in the middle - done
# - excel file - done
# - GUIDs - done
# - modification in const data between dumps - done
# - previous exams taken by the same candidate should be failed (and reservation time should be after the last failed exam)
# - remove title rows from csv files