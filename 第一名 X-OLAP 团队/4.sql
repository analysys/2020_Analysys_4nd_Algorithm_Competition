select
    key,
    key1,
    key2,
    sum(uv),
    sum(pv),
    sum(sum_price)
from (
    select
        toString(ds) as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.21', default.data_part_id)
    where fq9 > 0
    group by ds, vip_level, total_visit_days
    union all
    select
        toString(ds) as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.43', default.data_part_id)
    where fq9 > 0
    group by ds, vip_level, total_visit_days
    union all
    select
        toString(ds) as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.44', default.data_part_id)
    where fq9 > 0
    group by ds, vip_level, total_visit_days
    union all
    select
        '小计' as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.21', default.data_part_id)
    where fq9 > 0
    group by vip_level, total_visit_days
    union all
    select
        '小计' as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.43', default.data_part_id)
    where fq9 > 0
    group by vip_level, total_visit_days
    union all
    select
        '小计' as key,
        if(vip_level = '', '未知', vip_level) as key1,
        total_visit_days as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.44', default.data_part_id)
    where fq9 > 0
    group by vip_level, total_visit_days
)
group by key, key1, key2
order by key = '小计', key, key1, key2;
