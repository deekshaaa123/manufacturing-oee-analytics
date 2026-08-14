create database smart_manufacturing;
use smart_manufacturing;

create table machines(
MACHINE_ID VARCHAR(10) PRIMARY KEY,
MACHINE_NAME VARCHAR(50),
MACHINE_TYPE VARCHAR(50),
DEPARTMENT VARCHAR(50)
);

insert into machines values
('M001', 'Mixer-01', 'Mixer', 'Mixing'),
('M002', 'Oven-01', 'Oven', 'Baking'),
('M003', 'Packaging-01', 'Packaging Machine', 'Packaging');

select * from machines;

create table production (
PRODUCTION_ID INT PRIMARY KEY,
PRODUCTION_DATE DATE,
SHIFT VARCHAR(20),
MACHINE_ID VARCHAR(10),
PRODUCT VARCHAR(50),
TARGET_QTY INT,
ACTUAL_QTY INT,
REJECT_QTY INT,
PLANNED_TIME_MIN INT,
DOWNTIME_MIN INT,
IDEAL_CYCLE_TIME_SEC DECIMAL(10,2),

FOREIGN KEY (MACHINE_ID) REFERENCES MACHINES (MACHINE_ID));

insert into production values
(1, '2026-08-01', 'Morning', 'M003', 'Biscuit-A', 8000, 6000, 80, 480, 40, 4.00);
INSERT INTO production VALUES
(2, '2026-08-01', 'Evening', 'M002', 'Biscuit-A', 6500, 5000, 100, 480, 60, 5.00);

#first KPI
#availability
select PRODUCTION_ID,PLANNED_TIME_MIN,PLANNED_TIME_MIN-DOWNTIME_MIN AS OPERATING_TIME,
ROUND((PLANNED_TIME_MIN-DOWNTIME_MIN)*100/PLANNED_TIME_MIN,2) AS AVAILABILITY from production;

#performance
select PRODUCTION_ID,ACTUAL_QTY,PLANNED_TIME_MIN,DOWNTIME_MIN,IDEAL_CYCLE_TIME_SEC,(PLANNED_TIME_MIN-DOWNTIME_MIN) as OPERATING_TIME,
round(ACTUAL_QTY/((PLANNED_TIME_MIN-DOWNTIME_MIN)*60/IDEAL_CYCLE_TIME_SEC)*100,2) as PERFORMANCE from production;

#quality
select PRODUCTION_ID,ACTUAL_QTY,REJECT_QTY,(ACTUAL_QTY-REJECT_QTY) as GOOD_QTY,
round(((ACTUAL_QTY-REJECT_QTY)/ACTUAL_QTY)*100,2) as QUALITY from PRODUCTION;

#OEE
select PRODUCTION_ID,PLANNED_TIME_MIN,DOWNTIME_MIN,REJECT_QTY,IDEAL_CYCLE_TIME_SEC,
PLANNED_TIME_MIN-DOWNTIME_MIN AS OPERATING_TIME,(ACTUAL_QTY-REJECT_QTY) as GOOD_QTY,
round((PLANNED_TIME_MIN-DOWNTIME_MIN)*100/PLANNED_TIME_MIN,2) AS AVAILABILITY,
round(ACTUAL_QTY/((PLANNED_TIME_MIN-DOWNTIME_MIN)*60/IDEAL_CYCLE_TIME_SEC)*100,2) as PERFORMANCE,
round(((ACTUAL_QTY-REJECT_QTY)/ACTUAL_QTY)*100,2) as QUALITY,
round(
((PLANNED_TIME_MIN-DOWNTIME_MIN)*100/PLANNED_TIME_MIN)*
(ACTUAL_QTY/((PLANNED_TIME_MIN-DOWNTIME_MIN)*60/IDEAL_CYCLE_TIME_SEC)*100)*((ACTUAL_QTY-REJECT_QTY)/ACTUAL_QTY)*100,2) 
from PRODUCTION
;

#production achievement
select PRODUCTION_ID,ACTUAL_QTY,TARGET_QTY,
round((ACTUAL_QTY/TARGET_QTY)*100,2) as PRODUCT_ACHIEVEMENT from PRODUCTION;

#reject rate
select PRODUCTION_ID,REJECT_QTY,
round((REJECT_QTY/ACTUAL_QTY)*100,2) as REJECT_RATE from Production;

#### DOWNTIME TABLE
create table DOWNTIME(
DOWNTIME_ID INT PRIMARY KEY,
PRODUCTION_ID INT,
REASON VARCHAR(100),
MINUTES INT,
FOREIGN KEY (PRODUCTION_ID) references PRODUCTION (PRODUCTION_ID));

INSERT INTO downtime VALUES
(1, 1, 'Mechanical Failure', 25),
(2, 1, 'Material Shortage', 10),
(3, 1, 'Operator Delay', 5);

select * from DOWNTIME;

INSERT INTO downtime 
(downtime_id, production_id, reason, minutes) VALUES
(4, 2, 'Mechanical Failure', 15),
(5, 2, 'Material Shortage', 20);

select REASON,SUM(MINUTES) as TOTAL_DOWNTIME 
FROM DOWNTIME
GROUP BY REASON;

###############################################################################################

INSERT INTO production
(production_id, production_date, shift, machine_id, product,
 target_qty, actual_qty, reject_qty, planned_time_min,
 downtime_min, ideal_cycle_time_sec)
VALUES
(3, '2026-08-01', 'Morning', 'M001', 'Biscuit-A', 8520, 7920, 79, 480, 30, 3.00),
(4, '2026-08-01', 'Evening', 'M002', 'Biscuit-B', 5340, 4840, 72, 480, 41, 5.00),
(5, '2026-08-01', 'Night', 'M003', 'Biscuit-A', 5970, 5770, 69, 480, 52, 4.00),
(6, '2026-08-02', 'Morning', 'M002', 'Biscuit-B', 5190, 4890, 73, 480, 37, 5.00),
(7, '2026-08-02', 'Evening', 'M003', 'Biscuit-A', 6230, 5830, 69, 480, 48, 4.00),
(8, '2026-08-02', 'Night', 'M001', 'Biscuit-A', 8400, 7800, 117, 480, 59, 3.00),
(9, '2026-08-03', 'Morning', 'M003', 'Biscuit-A', 6460, 5960, 71, 480, 44, 4.00),
(10, '2026-08-03', 'Evening', 'M001', 'Biscuit-A', 8640, 8040, 80, 480, 55, 3.00),
(11, '2026-08-03', 'Night', 'M002', 'Biscuit-B', 5010, 4810, 57, 480, 66, 5.00),
(12, '2026-08-04', 'Morning', 'M001', 'Biscuit-A', 9070, 8470, 84, 480, 51, 3.00),
(13, '2026-08-04', 'Evening', 'M002', 'Biscuit-B', 5120, 4820, 57, 480, 62, 5.00),
(14, '2026-08-04', 'Night', 'M003', 'Biscuit-A', 6140, 5840, 70, 480, 33, 4.00),
(15, '2026-08-05', 'Morning', 'M002', 'Biscuit-B', 5330, 5030, 75, 480, 58, 5.00),
(16, '2026-08-05', 'Evening', 'M003', 'Biscuit-A', 6610, 6110, 73, 480, 39, 4.00),
(17, '2026-08-05', 'Night', 'M001', 'Biscuit-A', 8760, 8060, 64, 480, 50, 3.00),
(18, '2026-08-06', 'Morning', 'M003', 'Biscuit-A', 6040, 5840, 58, 480, 45, 4.00),
(19, '2026-08-06', 'Evening', 'M001', 'Biscuit-A', 8350, 7850, 78, 480, 56, 3.00),
(20, '2026-08-06', 'Night', 'M002', 'Biscuit-B', 5210, 5010, 60, 480, 31, 5.00),
(21, '2026-08-07', 'Morning', 'M001', 'Biscuit-A', 8670, 8170, 98, 480, 60, 3.00),
(22, '2026-08-07', 'Evening', 'M002', 'Biscuit-B', 5480, 4980, 99, 480, 43, 5.00),
(23, '2026-08-07', 'Night', 'M003', 'Biscuit-A', 6320, 5820, 69, 480, 54, 4.00),
(24, '2026-08-08', 'Morning', 'M002', 'Biscuit-B', 5170, 4970, 59, 480, 35, 5.00),
(25, '2026-08-08', 'Evening', 'M003', 'Biscuit-A', 6590, 6090, 73, 480, 47, 4.00),
(26, '2026-08-08', 'Night', 'M001', 'Biscuit-A', 8290, 7790, 77, 480, 58, 3.00),
(27, '2026-08-09', 'Morning', 'M003', 'Biscuit-A', 6420, 6020, 108, 480, 42, 4.00),
(28, '2026-08-09', 'Evening', 'M001', 'Biscuit-A', 8930, 8230, 98, 480, 53, 3.00),
(29, '2026-08-09', 'Night', 'M002', 'Biscuit-B', 5270, 5070, 60, 480, 64, 5.00),
(30, '2026-08-10', 'Morning', 'M001', 'Biscuit-A', 8010, 7610, 60, 480, 57, 3.00),
(31, '2026-08-10', 'Evening', 'M002', 'Biscuit-B', 5800, 5100, 51, 480, 32, 5.00),
(32, '2026-08-10', 'Night', 'M003', 'Biscuit-A', 6000, 5700, 85, 480, 43, 4.00);

select count(*) as TOT_RECORDS from Production;
select * from Production;

INSERT INTO downtime VALUES
(6, 2, 'Operator Delay', 25);
INSERT INTO downtime VALUES
(7, 3, 'Mechanical Failure', 16),
(8, 3, 'Material Shortage', 14),
(9, 4, 'Material Shortage', 25),
(10, 4, 'Operator Delay', 16),
(11, 5, 'Operator Delay', 34),
(12, 5, 'Changeover', 18),
(13, 6, 'Changeover', 26),
(14, 6, 'Mechanical Failure', 11),
(15, 7, 'Mechanical Failure', 29),
(16, 7, 'Material Shortage', 19),
(17, 8, 'Material Shortage', 35),
(18, 8, 'Operator Delay', 24),
(19, 9, 'Operator Delay', 31),
(20, 9, 'Changeover', 13),
(21, 10, 'Changeover', 33),
(22, 10, 'Mechanical Failure', 22),
(23, 11, 'Mechanical Failure', 40),
(24, 11, 'Material Shortage', 26),
(25, 12, 'Material Shortage', 26),
(26, 12, 'Operator Delay', 25),
(27, 13, 'Operator Delay', 40),
(28, 13, 'Changeover', 22),
(29, 14, 'Changeover', 18),
(30, 14, 'Mechanical Failure', 15),
(31, 15, 'Mechanical Failure', 32),
(32, 15, 'Material Shortage', 26),
(33, 16, 'Material Shortage', 22),
(34, 16, 'Operator Delay', 17),
(35, 17, 'Operator Delay', 30),
(36, 17, 'Changeover', 20),
(37, 18, 'Changeover', 27),
(38, 18, 'Mechanical Failure', 18),
(39, 19, 'Mechanical Failure', 34),
(40, 19, 'Material Shortage', 22),
(41, 20, 'Material Shortage', 17),
(42, 20, 'Operator Delay', 14),
(43, 21, 'Operator Delay', 36),
(44, 21, 'Changeover', 24),
(45, 22, 'Changeover', 30),
(46, 22, 'Mechanical Failure', 13),
(47, 23, 'Mechanical Failure', 32),
(48, 23, 'Material Shortage', 22),
(49, 24, 'Material Shortage', 21),
(50, 24, 'Operator Delay', 14),
(51, 25, 'Operator Delay', 28),
(52, 25, 'Changeover', 19),
(53, 26, 'Changeover', 35),
(54, 26, 'Mechanical Failure', 23),
(55, 27, 'Mechanical Failure', 23),
(56, 27, 'Material Shortage', 19),
(57, 28, 'Material Shortage', 37),
(58, 28, 'Operator Delay', 16),
(59, 29, 'Operator Delay', 41),
(60, 29, 'Changeover', 23),
(61, 30, 'Changeover', 32),
(62, 30, 'Mechanical Failure', 25),
(63, 31, 'Mechanical Failure', 18),
(64, 31, 'Material Shortage', 14),
(65, 32, 'Material Shortage', 26),
(66, 32, 'Operator Delay', 17);

select * from DOWNTIME;

select REASON,SUM(MINUTES) as TOTAL_DOWNTIME 
FROM DOWNTIME
GROUP BY REASON;

select p.production_id,p.downtime_min,
coalesce(sum(d.minutes),0) as EVENT_DOWNTIME,
(p.downtime_min-coalesce(sum(d.minutes),0)) as difference
from production p left join downtime d
on p.production_id=d.production_id
group by p.production_id,p.downtime_min
having p.downtime_min <> COALESCE(SUM(d.minutes), 0);

SELECT
    production_id,
    actual_qty,
    planned_time_min,
    downtime_min,
    ideal_cycle_time_sec,

    (planned_time_min - downtime_min) * 60
        / ideal_cycle_time_sec AS ideal_capacity

FROM production
WHERE actual_qty >
    (
        (planned_time_min - downtime_min) * 60
        / ideal_cycle_time_sec
    );
    
UPDATE production
SET actual_qty = 4900
WHERE production_id = 29;