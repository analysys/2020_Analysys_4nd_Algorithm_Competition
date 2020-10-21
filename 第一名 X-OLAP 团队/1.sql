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
        os as key1,
        city as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.21', default.data_part_id)
    group by ds, os, city
    union all
    select
        toString(ds) as key,
        os as key1,
        city as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.43', default.data_part_id)
    group by ds, os, city
    union all
    select
        toString(ds) as key,
        os as key1,
        city as key2,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.44', default.data_part_id)
    group by ds, os, city
)
group by key, key1, key2
order by key, key1, key2;
