-- Part 2:
--- table 1:
select formulary_id, rxcui, tier_level_value from test_formulary;
--- table 2:
select a.formulary_id as formulary_target_id, 
a.tier_level_value as tier_level_value_target,
a.rxcui as rxcui,
b.formulary_id as formulary_id,
b.tier_level_value as tier_level_value
from 
(select formulary_id, rxcui, tier_level_value from test_formulary) a
left JOIN
(select formulary_id, rxcui, tier_level_value from test_formulary) b
ON
a.rxcui = b.rxcui

--- table 3A:
select c.formulary_id as formulary_id, 
avg(c.tier_level_value_target - c.tier_level_value) as tier_difference 
from
(select a.formulary_id as formulary_target_id, 
a.tier_level_value as tier_level_value_target,
a.rxcui as rxcui,
b.formulary_id as formulary_id,
b.tier_level_value as tier_level_value 
from 
(select formulary_id, rxcui, tier_level_value from test_formulary) a
left JOIN
(select formulary_id, rxcui, tier_level_value from test_formulary) b
ON
a.rxcui = b.rxcui) c
group by c.formulary_id

--- table 3B:
select c.formulary_id as formulary_id, 
avg(c.tier_level_value_target - c.tier_level_value) as tier_difference 
from
(select a.formulary_id as formulary_target_id, 
a.tier_level_value as tier_level_value_target,
a.rxcui as rxcui,
b.formulary_id as formulary_id,
b.tier_level_value as tier_level_value 
from 
(select formulary_id, rxcui, tier_level_value from test_formulary) a
left JOIN
(select formulary_id, rxcui, tier_level_value from test_formulary) b
ON
a.rxcui = b.rxcui) c 
where
c.tier_level_value_target - c.tier_level_value <> 0
group by c.formulary_id

-- Part 3:
--- table 2:
EXPLAIN ANALYZE
select a.formulary_id as formulary_target_id, 
a.tier_level_value as tier_level_value_target,
a.rxcui as rxcui,
b.formulary_id as formulary_id,
b.tier_level_value as tier_level_value
from 
(select formulary_id, rxcui, tier_level_value from formulary) a
INNER JOIN
(select formulary_id, rxcui, tier_level_value from formulary where formulary_id = '00022170') b
ON
a.rxcui = b.rxcui
where b.formulary_id = '00022170';
-- Execution Time: 629.604 ms
-- formulary_target_id | tier_level_value_target |  rxcui  | formulary_id | tier_level_value 
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
--  00022085            |                       4 | 1307421 | 00022170     |                3
--  00022084            |                       3 | 1307421 | 00022170     |                3
--  00022083            |                       3 | 1307421 | 00022170     |                3
--  00022082            |                       3 | 1307421 | 00022170     |                3
--                                                                   QUERY PLAN                                                                   
-- -----------------------------------------------------------------------------------------------------------------------------------------------
--  Hash Join  (cost=62256.92..112935.79 rows=1174236 width=33) (actual time=423.332..597.300 rows=1171546 loops=1)
--    Hash Cond: (formulary_1.rxcui = formulary.rxcui)
--    ->  Gather  (cost=1000.00..25934.70 rows=3375 width=20) (actual time=16.351..16.652 rows=2730 loops=1)
--          Workers Planned: 2
--          Workers Launched: 2
--          ->  Parallel Seq Scan on formulary formulary_1  (cost=0.00..24597.20 rows=1406 width=20) (actual time=6.841..46.694 rows=910 loops=3)
--                Filter: (formulary_id = '00022170'::text)
--                Rows Removed by Filter: 526911
--    ->  Hash  (cost=32184.63..32184.63 rows=1583463 width=20) (actual time=406.507..406.507 rows=1583463 loops=1)
--          Buckets: 131072  Batches: 16  Memory Usage: 6610kB
--          ->  Seq Scan on formulary  (cost=0.00..32184.63 rows=1583463 width=20) (actual time=0.022..172.324 rows=1583463 loops=1)
--  Planning Time: 0.680 ms
--  JIT:
--    Functions: 20
--    Options: Inlining false, Optimization false, Expressions true, Deforming true
--    Timing: Generation 3.727 ms, Inlining 0.000 ms, Optimization 1.577 ms, Emission 18.060 ms, Total 23.364 ms
--  Execution Time: 629.604 ms
-- (17 rows)


--- table 3A:
-- Execution Time: 270.169 ms
EXPLAIN ANALYZE
select c.formulary_id as formulary_id, 
avg(c.tier_level_value_target - c.tier_level_value) as tier_difference 
from
(select a.formulary_id as formulary_target_id, 
a.tier_level_value as tier_level_value_target,
a.rxcui as rxcui,
b.formulary_id as formulary_id,
b.tier_level_value as tier_level_value 
from 
(select formulary_id, rxcui, tier_level_value from formulary) a
INNER JOIN
(select formulary_id, rxcui, tier_level_value from formulary where formulary_id = '00022170') b
ON
a.rxcui = b.rxcui
WHERE b.formulary_id = '00022170') c
group by c.formulary_id

--  formulary_id |     tier_difference     
-- --------------+-------------------------
--  00022170     | -0.86473514484279746591

-- formulary=# EXPLAIN ANALYZE                                      
-- select c.formulary_id as formulary_id, 
-- avg(c.tier_level_value_target - c.tier_level_value) as tier_difference 
-- from
-- (select a.formulary_id as formulary_target_id, 
-- a.tier_level_value as tier_level_value_target,
-- a.rxcui as rxcui,
-- b.formulary_id as formulary_id,
-- b.tier_level_value as tier_level_value 
-- from 
-- (select formulary_id, rxcui, tier_level_value from formulary) a
-- INNER JOIN
-- (select formulary_id, rxcui, tier_level_value from formulary where formulary_id = '00022170') b
-- ON
-- a.rxcui = b.rxcui
-- WHERE b.formulary_id = '00022170') c
-- group by c.formulary_id;
--                                                                            QUERY PLAN                                                                            
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Finalize GroupAggregate  (cost=19318.38..70131.36 rows=200 width=64) (actual time=269.829..270.114 rows=1 loops=1)
--    Group Key: formulary_1.formulary_id
--    ->  Gather  (cost=19318.38..70126.86 rows=400 width=64) (actual time=268.677..270.106 rows=3 loops=1)
--          Workers Planned: 2
--          Workers Launched: 2
--          ->  Partial GroupAggregate  (cost=18318.38..69086.86 rows=200 width=64) (actual time=265.973..265.974 rows=1 loops=3)
--                Group Key: formulary_1.formulary_id
--                ->  Parallel Hash Join  (cost=18318.38..58038.40 rows=1472862 width=40) (actual time=50.063..224.580 rows=390515 loops=3)
--                      Hash Cond: (formulary.rxcui = formulary_1.rxcui)
--                      ->  Parallel Seq Scan on formulary  (cost=0.00..17916.88 rows=156688 width=36) (actual time=0.012..45.450 rows=527821 loops=3)
--                      ->  Parallel Hash  (cost=18308.59..18308.59 rows=783 width=68) (actual time=47.883..47.883 rows=910 loops=3)
--                            Buckets: 4096 (originally 2048)  Batches: 1 (originally 1)  Memory Usage: 240kB
--                            ->  Parallel Seq Scan on formulary formulary_1  (cost=0.00..18308.59 rows=783 width=68) (actual time=24.039..35.873 rows=910 loops=3)
--                                  Filter: (formulary_id = '00022170'::text)
--                                  Rows Removed by Filter: 526911
--  Planning Time: 0.369 ms
--  Execution Time: 270.169 ms
-- (17 rows)


--- table 3B:
-- Execution Time: 447.372 ms
EXPLAIN ANALYZE
select c.formulary_id as formulary_id, 
avg(c.tier_level_value_target - c.tier_level_value) as tier_difference 
from
(select a.formulary_id as formulary_target_id, 
a.tier_level_value as tier_level_value_target,
a.rxcui as rxcui,
b.formulary_id as formulary_id,
b.tier_level_value as tier_level_value 
from 
(select formulary_id, rxcui, tier_level_value from formulary) a
INNER JOIN
(select formulary_id, rxcui, tier_level_value from formulary where formulary_id = '00022170') b
ON
a.rxcui = b.rxcui
WHERE
b.formulary_id = '00022170') c
where
c.tier_level_value_target - c.tier_level_value <> 0
group by c.formulary_id

--  formulary_id |   tier_difference   
-- --------------+---------------------
--  00022170     | -1.5937203068268341
--                                                                          QUERY PLAN                                                                         
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Finalize GroupAggregate  (cost=35416.96..70884.63 rows=458 width=41) (actual time=420.390..447.121 rows=1 loops=1)
--    Group Key: formulary_1.formulary_id
--    ->  Gather  (cost=35416.96..70874.32 rows=916 width=41) (actual time=416.821..447.092 rows=3 loops=1)
--          Workers Planned: 2
--          Workers Launched: 2
--          ->  Partial GroupAggregate  (cost=34416.96..69782.72 rows=458 width=41) (actual time=406.472..406.863 rows=1 loops=3)
--                Group Key: formulary_1.formulary_id
--                ->  Parallel Hash Join  (cost=34416.96..66127.01 rows=486818 width=17) (actual time=276.017..389.634 rows=211889 loops=3)
--                      Hash Cond: (formulary_1.rxcui = formulary.rxcui)
--                      Join Filter: ((formulary.tier_level_value - formulary_1.tier_level_value) <> 0)
--                      Rows Removed by Join Filter: 178626
--                      ->  Parallel Seq Scan on formulary formulary_1  (cost=0.00..24597.20 rows=1406 width=20) (actual time=19.743..37.419 rows=910 loops=3)
--                            Filter: (formulary_id = '00022170'::text)
--                            Rows Removed by Filter: 526911
--                      ->  Parallel Hash  (cost=22947.76..22947.76 rows=659776 width=11) (actual time=225.519..225.519 rows=527821 loops=3)
--                            Buckets: 262144  Batches: 16  Memory Usage: 7392kB
--                            ->  Parallel Seq Scan on formulary  (cost=0.00..22947.76 rows=659776 width=11) (actual time=0.100..114.852 rows=527821 loops=3)
--  Planning Time: 2.185 ms
--  Execution Time: 447.372 ms
-- (19 rows)
