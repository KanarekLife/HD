import pandas as pd
from pathlib import Path

from itertools import islice

def chunk(it, size):
    it = iter(it)
    return iter(lambda: tuple(islice(it, size)), ())

first_dump = Path('data/first_dump')
second_dump = Path('data/second_dump')

result_file = str(second_dump / '{}_apply_{}.sql')

csv_by_table = {
    'Egzaminatorzy': 'egzaminatorzy.csv',
    'Kandydaci': 'kandydaci.csv',
    'EgzaminyTeoretyczne': 'egzaminy_teoretyczne.csv',
    'PrzebiegiEgzaminowKandydata': 'przebiegi_egzaminow_kandydata.csv',
    'ZaplanowanePytania': 'zaplanowane_pytania.csv',
}


for i, (table, csv) in enumerate(csv_by_table.items()):
    first = pd.read_csv(first_dump / csv, encoding='utf-16')
    second = pd.read_csv(second_dump / csv, encoding='utf-16')

    print(f'Processing {table}...')

    # create updates
    if 'Id' in first.columns and table != 'ZaplanowanePytania':
        diff = first.merge(second, on='Id', suffixes=('_first', '_second'))
        diff = diff[~diff.eq(diff.shift(-1, axis=1)).all(axis=1)]
        prompt = f'UPDATE {table} SET\n'
        updates = ''
        for _, row in diff.iterrows():
            for col, dt in zip(first.columns, first.dtypes):
                if col == 'Id':
                    continue
                if not pd.isna(row[f'{col}_second']) and row[f'{col}_first'] != row[f'{col}_second']:
                    formatted_val = f"{int(row[f'{col}_second'])}" if str(dt) in ('int64', 'float64') else f"'{row[f'{col}_second']}'"
                    updates += f'UPDATE {table} SET {col} = {formatted_val} WHERE Id = \'{row["Id"]}\';\n'

    # create inserts
    diff = second[~second.isin(first)].dropna()
    prompt = f'INSERT INTO {table}({", ".join(first.columns)}) VALUES\n'
    inserts = [prompt + ',\n'.join(['(' + ', '.join([f"{int(v)}" if str(dt) in ('int64', 'float64') else f"'{v}'" for v, dt in zip(row, first.dtypes)]) + ')' for _, row in chunk]) for chunk in chunk(diff.iterrows(), 1000)]
    inserts = ';\n'.join(inserts)

    with open(result_file.format(i+1, table), 'w', encoding='utf-16') as f:
        f.write(updates)
        if inserts and updates:
            f.write('\n')
        f.write(inserts)
        f.write('GO\n\n')
