use smart_manufacturing;

## KPI QUERY
CREATE VIEW production_kpi AS
SELECT
    production_id,
    production_date,
    shift,
    machine_id,
    product,
    target_qty,
    actual_qty,
    reject_qty,
    downtime_min,

    ROUND(
        (planned_time_min - downtime_min)
        * 100.0 / planned_time_min,
        2
    ) AS availability,

    ROUND(
        actual_qty * 100.0 /
        (
            (planned_time_min - downtime_min)
            * 60.0 / ideal_cycle_time_sec
        ),
        2
    ) AS performance,

    ROUND(
        (actual_qty - reject_qty)
        * 100.0 / actual_qty,
        2
    ) AS quality,

    ROUND(
        (
            (planned_time_min - downtime_min)
            / planned_time_min
        )
        *
        (
            actual_qty /
            (
                (planned_time_min - downtime_min)
                * 60.0 / ideal_cycle_time_sec
            )
        )
        *
        (
            (actual_qty - reject_qty)
            / actual_qty
        )
        * 100,
        2
    ) AS oee

FROM production;

SELECT *
FROM production_kpi;

SELECT
    machine_id,
    ROUND(AVG(availability), 2) AS avg_availability,
    ROUND(AVG(performance), 2) AS avg_performance,
    ROUND(AVG(quality), 2) AS avg_quality,
    ROUND(AVG(oee), 2) AS avg_oee
FROM production_kpi
GROUP BY machine_id
ORDER BY avg_oee DESC;


######################################################

##     OEE BY MACHINE
SELECT
    ROUND(AVG(oee), 2) AS overall_oee,
    ROUND(AVG(availability), 2) AS overall_availability,
    ROUND(AVG(performance), 2) AS overall_performance,
    ROUND(AVG(quality), 2) AS overall_quality
FROM production_kpi;

##     DOWNTIME BY REASON
SELECT
    reason,
    SUM(minutes) AS total_downtime
FROM downtime
GROUP BY reason
ORDER BY total_downtime DESC;

##     TARGET VS ACTUAL SHIFT
SELECT
    shift,
    SUM(target_qty) AS total_target,
    SUM(actual_qty) AS total_actual,
    ROUND(
        SUM(actual_qty) * 100.0 /
        SUM(target_qty),
        2
    ) AS achievement
FROM production
GROUP BY shift
ORDER BY achievement DESC;

##     OEE trendSELECT
SELECT production_date,
    ROUND(AVG(oee), 2) AS oee
FROM production_kpi
GROUP BY production_date
ORDER BY production_date;

###########################################
# importing the tables to power bi 

SELECT * FROM production_kpi;

SELECT * FROM downtime;