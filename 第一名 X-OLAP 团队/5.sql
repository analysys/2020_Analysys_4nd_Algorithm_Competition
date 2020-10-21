with
    arrayJoin([1, 2, 3, 4]) as fq
select
    [3, 7, 8, 10][fq],
    key,
    key1,
    key2,
    sumIf(uv, [fq3, fq7, fq8, fq10][fq] > 0),
    sumIf(pv, [fq3, fq7, fq8, fq10][fq] > 0),
    sumIf(sum_price, [fq3, fq7, fq8, fq10][fq] > 0)
from (
    select
        fq3,
        fq7,
        fq8,
        fq10,
        toString(ds) as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.21', default.data_part_id)
    where fq3 + fq7 + fq8 + fq10 > -4
    group by fq3, fq7, fq8, fq10, ds, vip_level, total_visit_days
    union all
    select
        fq3,
        fq7,
        fq8,
        fq10,
        toString(ds) as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.43', default.data_part_id)
    where fq3 +fq7+fq8+fq10>-4
    group by fq3, fq7, fq8, fq10, ds, vip_level, total_visit_days
    union all
    select
        fq3,
        fq7,
        fq8,
        fq10,
        toString(ds) as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.44', default.data_part_id)
    where fq3 +fq7+fq8+fq10>-4
    group by fq3, fq7, fq8, fq10, ds, vip_level, total_visit_days
    union all
    select
        fq3,
        fq7,
        fq8,
        fq10,
        '小计' as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.21', default.data_part_id)
    where fq3 +fq7+fq8+fq10>-4
    group by fq3, fq7, fq8, fq10, vip_level, total_visit_days
    union all
    select
        fq3,
        fq7,
        fq8,
        fq10,
        '小计' as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.43', default.data_part_id)
    where fq3 +fq7+fq8+fq10>-4
    group by fq3, fq7, fq8, fq10, vip_level, total_visit_days
    union all
    select
        fq3,
        fq7,
        fq8,
        fq10,
        '小计' as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.44', default.data_part_id)
    where fq3 +fq7+fq8+fq10>-4
    group by fq3, fq7, fq8, fq10, vip_level, total_visit_days
)
group by fq, key, key1, key2
order by fq, key = '小计', key, key1, key2;
