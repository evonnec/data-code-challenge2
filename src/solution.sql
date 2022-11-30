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
WHERE
a.formulary_id <> b.formulary_id

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
a.rxcui = b.rxcui 
WHERE a.formulary_id <> b.formulary_id) c
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
a.formulary_id <> b.formulary_id
AND
a.tier_level_value - b.tier_level_value <> 0) c 
GROUP BY c.formulary_id;

-- Part 3:
--- table 2:
--  Execution Time: 732.191 ms
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
a.rxcui = b.rxcui
WHERE b.formulary_id = '00022170'
AND 
b.formulary_id <> a.formulary_id;
--  Execution Time: 732.191 ms
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
--  Hash Join  (cost=62256.92..115871.38 rows=1171649 width=33) (actual time=477.769..690.523 rows=1168816 loops=1)
--    Hash Cond: (formulary_1.rxcui = formulary.rxcui)
--    Join Filter: (formulary_1.formulary_id <> formulary.formulary_id)
--    Rows Removed by Join Filter: 2730
--    ->  Gather  (cost=1000.00..25934.70 rows=3375 width=20) (actual time=32.479..32.795 rows=2730 loops=1)
--          Workers Planned: 2
--          Workers Launched: 2
--          ->  Parallel Seq Scan on formulary formulary_1  (cost=0.00..24597.20 rows=1406 width=20) (actual time=12.090..69.375 rows=910 loops=3)
--                Filter: (formulary_id = '00022170'::text)
--                Rows Removed by Filter: 526911
--    ->  Hash  (cost=32184.63..32184.63 rows=1583463 width=20) (actual time=442.372..442.373 rows=1583463 loops=1)
--          Buckets: 131072  Batches: 16  Memory Usage: 6610kB
--          ->  Seq Scan on formulary  (cost=0.00..32184.63 rows=1583463 width=20) (actual time=0.017..179.450 rows=1583463 loops=1)
--  Planning Time: 1.590 ms
--  JIT:
--    Functions: 22
--    Options: Inlining false, Optimization false, Expressions true, Deforming true
--    Timing: Generation 13.238 ms, Inlining 0.000 ms, Optimization 2.981 ms, Emission 19.912 ms, Total 36.131 ms
--  Execution Time: 732.191 ms


--- table 3A:
--  Execution Time: 501.229 ms
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
a.rxcui = b.rxcui
WHERE 
a.formulary_id <> b.formulary_id) c
GROUP BY c.formulary_id;

--  formulary_id |     tier_difference     
-- --------------+-------------------------
--  00022170     | -0.86675490410808886942
--
--                                                                            QUERY PLAN                                                                           
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Finalize GroupAggregate  (cost=36060.96..72674.15 rows=458 width=41) (actual time=470.000..500.899 rows=1 loops=1)
--    Group Key: formulary_1.formulary_id
--    ->  Gather  (cost=36060.96..72663.84 rows=916 width=41) (actual time=464.251..500.880 rows=3 loops=1)
--          Workers Planned: 2
--          Workers Launched: 2
--          ->  Partial GroupAggregate  (cost=35060.96..71572.24 rows=458 width=41) (actual time=412.362..412.691 rows=1 loops=3)
--                Group Key: formulary_1.formulary_id
--                ->  Parallel Hash Join  (cost=35060.96..67924.57 rows=485746 width=17) (actual time=277.908..389.151 rows=211889 loops=3)
--                      Hash Cond: (formulary_1.rxcui = formulary.rxcui)
--                      Join Filter: ((formulary_1.formulary_id <> formulary.formulary_id) AND ((formulary.tier_level_value - formulary_1.tier_level_value) <> 0))
--                      Rows Removed by Join Filter: 178626
--                      ->  Parallel Seq Scan on formulary formulary_1  (cost=0.00..24597.20 rows=1406 width=20) (actual time=16.868..36.390 rows=910 loops=3)
--                            Filter: (formulary_id = '00022170'::text)
--                            Rows Removed by Filter: 526911
--                      ->  Parallel Hash  (cost=22947.76..22947.76 rows=659776 width=20) (actual time=227.706..227.706 rows=527821 loops=3)
--                            Buckets: 131072  Batches: 16  Memory Usage: 7104kB
--                            ->  Parallel Seq Scan on formulary  (cost=0.00..22947.76 rows=659776 width=20) (actual time=0.037..92.209 rows=527821 loops=3)
--  Planning Time: 0.962 ms
--  Execution Time: 501.229 ms



--- table 3B:
-- Execution Time: 592.743 ms
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
a.rxcui = b.rxcui
WHERE
b.formulary_id <> a.formulary_id
AND
a.tier_level_value - b.tier_level_value <> 0) c 
GROUP BY c.formulary_id;

--  formulary_id |   tier_difference   
-- --------------+---------------------
--  00022170     | -1.5937203068268341
--                                                                            QUERY PLAN                                                                           
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Finalize GroupAggregate  (cost=36060.96..72674.15 rows=458 width=41) (actual time=560.316..592.169 rows=1 loops=1)
--    Group Key: formulary_1.formulary_id
--    ->  Gather  (cost=36060.96..72663.84 rows=916 width=41) (actual time=560.281..592.137 rows=3 loops=1)
--          Workers Planned: 2
--          Workers Launched: 2
--          ->  Partial GroupAggregate  (cost=35060.96..71572.24 rows=458 width=41) (actual time=487.175..487.177 rows=1 loops=3)
--                Group Key: formulary_1.formulary_id
--                ->  Parallel Hash Join  (cost=35060.96..67924.57 rows=485746 width=17) (actual time=342.238..469.578 rows=211889 loops=3)
--                      Hash Cond: (formulary_1.rxcui = formulary.rxcui)
--                      Join Filter: ((formulary_1.formulary_id <> formulary.formulary_id) AND ((formulary.tier_level_value - formulary_1.tier_level_value) <> 0))
--                      Rows Removed by Join Filter: 178626
--                      ->  Parallel Seq Scan on formulary formulary_1  (cost=0.00..24597.20 rows=1406 width=20) (actual time=18.008..49.977 rows=910 loops=3)
--                            Filter: (formulary_id = '00022170'::text)
--                            Rows Removed by Filter: 526911
--                      ->  Parallel Hash  (cost=22947.76..22947.76 rows=659776 width=20) (actual time=270.026..270.026 rows=527821 loops=3)
--                            Buckets: 131072  Batches: 16  Memory Usage: 7104kB
--                            ->  Parallel Seq Scan on formulary  (cost=0.00..22947.76 rows=659776 width=20) (actual time=0.071..152.287 rows=527821 loops=3)
--  Planning Time: 1.748 ms
--  Execution Time: 592.743 ms
-- (19 rows)
