-- Part 2:
--- table 1:
SELECT formulary_id, rxcui, tier_level_value FROM test_formulary;

--- table 2:
SELECT a.formulary_id AS formulary_target_id, 
a.tier_level_value AS tier_level_value_target,
a.rxcui AS rxcui,
b.formulary_id AS formulary_id,
b.tier_level_value AS tier_level_value
FROM 
(SELECT formulary_id, rxcui, tier_level_value FROM test_formulary) a
LEFT JOIN
(SELECT formulary_id, rxcui, tier_level_value FROM test_formulary) b
ON
a.rxcui = b.rxcui

--- table 3A:
SELECT c.formulary_id AS formulary_id, 
avg(c.tier_level_value_target - c.tier_level_value) AS tier_difference 
FROM
(SELECT a.formulary_id AS formulary_target_id, 
a.tier_level_value AS tier_level_value_target,
a.rxcui AS rxcui,
b.formulary_id AS formulary_id,
b.tier_level_value AS tier_level_value 
FROM 
(SELECT formulary_id, rxcui, tier_level_value FROM test_formulary) a
LEFT JOIN
(SELECT formulary_id, rxcui, tier_level_value FROM test_formulary) b
ON
a.rxcui = b.rxcui) c
GROUP BY c.formulary_id;

--- table 3B:
SELECT c.formulary_id AS formulary_id, 
avg(c.tier_level_value_target - c.tier_level_value) AS tier_difference 
FROM
(SELECT a.formulary_id AS formulary_target_id, 
a.tier_level_value AS tier_level_value_target,
a.rxcui AS rxcui,
b.formulary_id AS formulary_id,
b.tier_level_value AS tier_level_value 
FROM 
(SELECT formulary_id, rxcui, tier_level_value FROM test_formulary) a
LEFT JOIN
(SELECT formulary_id, rxcui, tier_level_value FROM test_formulary) b
ON
a.rxcui = b.rxcui 
WHERE
a.tier_level_value - b.tier_level_value <> 0) c 
GROUP BY c.formulary_id;

-- Part 3:
--- table 2:
--  Execution Time: 719.343 ms

EXPLAIN ANALYZE
SELECT a.formulary_id AS formulary_target_id, 
a.tier_level_value AS tier_level_value_target,
a.rxcui AS rxcui,
b.formulary_id AS formulary_id,
b.tier_level_value AS tier_level_value
FROM 
(SELECT formulary_id, rxcui, tier_level_value FROM formulary) a
INNER JOIN
(SELECT formulary_id, rxcui, tier_level_value FROM formulary WHERE formulary_id = '00022170') b
ON
b.rxcui = a.rxcui
WHERE b.formulary_id = '00022170';
--  Execution Time: 719.343 ms
--  formulary_target_id | tier_level_value_target |  rxcui  | formulary_id | tier_level_value 
-- ---------------------+-------------------------+---------+--------------+------------------
--  00022169            |                       3 | 1307421 | 00022170     |                3
--  00022167            |                       4 | 1307421 | 00022170     |                3
--  00022166            |                       3 | 1307421 | 00022170     |                3
--  00022163            |                       3 | 1307421 | 00022170     |                3
--  00022162            |                       3 | 1307421 | 00022170     |                3
--  00022160            |                       3 | 1307421 | 00022170     |                3
--  00022159            |                       3 | 1307421 | 00022170     |                3
--  00022157            |                       3 | 1307421 | 00022170     |                3
--  00022156            |                       1 | 1307421 | 00022170     |                3
--  00022155            |                       3 | 1307421 | 00022170     |                3
--  00022153            |                       3 | 1307421 | 00022170     |                3
--  00022149            |                       3 | 1307421 | 00022170     |                3
--  00022148            |                       3 | 1307421 | 00022170     |                3
--  00022147            |                       3 | 1307421 | 00022170     |                3
--  00022146            |                       3 | 1307421 | 00022170     |                3
--  00022144            |                       3 | 1307421 | 00022170     |                3
--  00022141            |                       1 | 1307421 | 00022170     |                3
--  00022138            |                       3 | 1307421 | 00022170     |                3
--  00022136            |                       3 | 1307421 | 00022170     |                3
--  00022131            |                       3 | 1307421 | 00022170     |                3
--  00022128            |                       3 | 1307421 | 00022170     |                3
--  00022125            |                       3 | 1307421 | 00022170     |                3
--  00022120            |                       3 | 1307421 | 00022170     |                3
--  00022119            |                       4 | 1307421 | 00022170     |                3
--  00022116            |                       1 | 1307421 | 00022170     |                3
--  00022114            |                       2 | 1307421 | 00022170     |                3
--  00022111            |                       3 | 1307421 | 00022170     |                3
--  00022110            |                       4 | 1307421 | 00022170     |                3
--  00022104            |                       4 | 1307421 | 00022170     |                3
--  00022102            |                       3 | 1307421 | 00022170     |                3
--  00022100            |                       3 | 1307421 | 00022170     |                3
--  00022099            |                       4 | 1307421 | 00022170     |                3
--  00022098            |                       3 | 1307421 | 00022170     |                3
--  00022097            |                       4 | 1307421 | 00022170     |                3
--  00022096            |                       3 | 1307421 | 00022170     |                3
--  00022095            |                       4 | 1307421 | 00022170     |                3
--  00022094            |                       1 | 1307421 | 00022170     |                3
--  00022093            |                       3 | 1307421 | 00022170     |                3
--  00022092            |                       1 | 1307421 | 00022170     |                3
--  00022091            |                       3 | 1307421 | 00022170     |                3
--  00022090            |                       1 | 1307421 | 00022170     |                3
--  00022089            |                       3 | 1307421 | 00022170     |                3
--  00022088            |                       3 | 1307421 | 00022170     |                3
--  00022087            |                       3 | 1307421 | 00022170     |                3
--  00022086            |                       1 | 1307421 | 00022170     |                3
--                                                                    QUERY PLAN                                                                   
-- ------------------------------------------------------------------------------------------------------------------------------------------------
--  Hash Join  (cost=62256.92..113151.98 rows=1191243 width=33) (actual time=410.662..583.181 rows=1171546 loops=1)
--    Hash Cond: (formulary_1.rxcui = formulary.rxcui)
--    ->  Gather  (cost=1000.00..25937.80 rows=3406 width=20) (actual time=44.496..44.814 rows=2730 loops=1)
--          Workers Planned: 2
--          Workers Launched: 2
--          ->  Parallel Seq Scan on formulary formulary_1  (cost=0.00..24597.20 rows=1419 width=20) (actual time=22.544..49.173 rows=910 loops=3)
--                Filter: (formulary_id = '00022170'::text)
--                Rows Removed by Filter: 526911
--    ->  Hash  (cost=32184.63..32184.63 rows=1583463 width=20) (actual time=365.612..365.612 rows=1583463 loops=1)
--          Buckets: 131072  Batches: 16  Memory Usage: 6610kB
--          ->  Seq Scan on formulary  (cost=0.00..32184.63 rows=1583463 width=20) (actual time=0.005..156.495 rows=1583463 loops=1)
--  Planning Time: 0.573 ms
--  JIT:
--    Functions: 20
--    Options: Inlining false, Optimization false, Expressions true, Deforming true
--    Timing: Generation 1.255 ms, Inlining 0.000 ms, Optimization 6.051 ms, Emission 18.740 ms, Total 26.046 ms
--  Execution Time: 719.343 ms
-- (17 rows)


--- table 3A:
--  Execution Time: 487.861 ms

EXPLAIN ANALYZE
SELECT c.formulary_id AS formulary_id, 
avg(c.tier_level_value_target - c.tier_level_value) AS tier_difference 
FROM
(SELECT a.formulary_id AS formulary_target_id, 
a.tier_level_value AS tier_level_value_target,
a.rxcui AS rxcui,
b.formulary_id AS formulary_id,
b.tier_level_value AS tier_level_value 
from 
(SELECT formulary_id, rxcui, tier_level_value FROM formulary) a
INNER JOIN
(SELECT formulary_id, rxcui, tier_level_value FROM formulary WHERE formulary_id = '00022170') b
ON
b.rxcui = a.rxcui) c
GROUP BY c.formulary_id;

--  formulary_id |     tier_difference     
-- --------------+-------------------------
--  00022170     | -0.86675490410808886942
--
--                                                                          QUERY PLAN                                                                         
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Finalize GroupAggregate  (cost=35416.96..69974.19 rows=458 width=41) (actual time=458.925..487.633 rows=1 loops=1)
--    Group Key: formulary_1.formulary_id
--    ->  Gather  (cost=35416.96..69963.89 rows=916 width=41) (actual time=456.148..487.603 rows=3 loops=1)
--          Workers Planned: 2
--          Workers Launched: 2
--          ->  Partial GroupAggregate  (cost=34416.96..68872.29 rows=458 width=41) (actual time=444.930..445.100 rows=1 loops=3)
--                Group Key: formulary_1.formulary_id
--                ->  Parallel Hash Join  (cost=34416.96..65145.08 rows=496351 width=17) (actual time=288.945..408.546 rows=390515 loops=3)
--                      Hash Cond: (formulary_1.rxcui = formulary.rxcui)
--                      ->  Parallel Seq Scan on formulary formulary_1  (cost=0.00..24597.20 rows=1419 width=20) (actual time=11.166..35.608 rows=910 loops=3)
--                            Filter: (formulary_id = '00022170'::text)
--                            Rows Removed by Filter: 526911
--                      ->  Parallel Hash  (cost=22947.76..22947.76 rows=659776 width=11) (actual time=233.229..233.229 rows=527821 loops=3)
--                            Buckets: 262144  Batches: 16  Memory Usage: 7392kB
--                            ->  Parallel Seq Scan on formulary  (cost=0.00..22947.76 rows=659776 width=11) (actual time=0.165..132.981 rows=527821 loops=3)
--  Planning Time: 0.798 ms
--  Execution Time: 487.861 ms
-- (17 rows)



--- table 3B:
--  Execution Time: 373.323 ms

EXPLAIN ANALYZE
SELECT c.formulary_id AS formulary_id, 
avg(c.tier_level_value_target - c.tier_level_value) AS tier_difference 
FROM
(SELECT a.formulary_id AS formulary_target_id, 
a.tier_level_value AS tier_level_value_target,
a.rxcui AS rxcui,
b.formulary_id AS formulary_id,
b.tier_level_value AS tier_level_value 
FROM 
(SELECT formulary_id, rxcui, tier_level_value FROM formulary) a
INNER JOIN
(select formulary_id, rxcui, tier_level_value FROM formulary WHERE formulary_id = '00022170') b
ON
b.rxcui = a.rxcui) c 
WHERE
c.tier_level_value_target - c.tier_level_value <> 0
GROUP BY c.formulary_id;

--  formulary_id |   tier_difference   
-- --------------+---------------------
--  00022170     | -1.5937203068268341
--                                                                          QUERY PLAN                                                                         
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Finalize GroupAggregate  (cost=35416.96..70989.53 rows=458 width=41) (actual time=356.832..373.174 rows=1 loops=1)
--    Group Key: formulary_1.formulary_id
--    ->  Gather  (cost=35416.96..70979.23 rows=916 width=41) (actual time=353.142..373.166 rows=3 loops=1)
--          Workers Planned: 2
--          Workers Launched: 2
--          ->  Partial GroupAggregate  (cost=34416.96..69887.63 rows=458 width=41) (actual time=349.759..349.940 rows=1 loops=3)
--                Group Key: formulary_1.formulary_id
--                ->  Parallel Hash Join  (cost=34416.96..66179.02 rows=493870 width=17) (actual time=257.942..331.563 rows=211889 loops=3)
--                      Hash Cond: (formulary_1.rxcui = formulary.rxcui)
--                      Join Filter: ((formulary.tier_level_value - formulary_1.tier_level_value) <> 0)
--                      Rows Removed by Join Filter: 178626
--                      ->  Parallel Seq Scan on formulary formulary_1  (cost=0.00..24597.20 rows=1419 width=20) (actual time=19.861..37.825 rows=910 loops=3)
--                            Filter: (formulary_id = '00022170'::text)
--                            Rows Removed by Filter: 526911
--                      ->  Parallel Hash  (cost=22947.76..22947.76 rows=659776 width=11) (actual time=211.219..211.220 rows=527821 loops=3)
--                            Buckets: 262144  Batches: 16  Memory Usage: 7392kB
--                            ->  Parallel Seq Scan on formulary  (cost=0.00..22947.76 rows=659776 width=11) (actual time=0.086..93.264 rows=527821 loops=3)
--  Planning Time: 0.386 ms
--  Execution Time: 373.323 ms
-- (19 rows)
