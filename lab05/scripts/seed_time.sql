WITH Hours AS (
    SELECT RIGHT('0' + CAST(Number AS nvarchar(2)), 2) AS Godzina
    FROM (VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), 
                 (13), (14), (15), (16), (17), (18), (19), (20), (21), (22), (23)) AS H(Number)
),
Minutes AS (
    SELECT RIGHT('0' + CAST(Number AS nvarchar(2)), 2) AS Minuty
    FROM (VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), 
                 (13), (14), (15), (16), (17), (18), (19), (20), (21), (22), (23), 
                 (24), (25), (26), (27), (28), (29), (30), (31), (32), (33), (34), 
                 (35), (36), (37), (38), (39), (40), (41), (42), (43), (44), (45), 
                 (46), (47), (48), (49), (50), (51), (52), (53), (54), (55), (56), 
                 (57), (58), (59)) AS M(Number)
)
INSERT INTO [dbo].[Czas](Godzina, Minuty)
SELECT H.Godzina, M.Minuty
FROM Hours H
CROSS JOIN Minutes M