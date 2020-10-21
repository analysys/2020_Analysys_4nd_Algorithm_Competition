select
    *
from (
    select
        toString(ds) as key,
        firstcommodity as key1,
        os_version as key2,
        uniqExact(id) as uv,
        count() as pv,
        uniqExact(app_version) as u_app_version,
        uniqExact(price) as u_price
    from remote('172.21.100.21', default.data_part_ds)
    where xwhat in ('addtoshoppingcart', 'submitorderdetail', 'share', 'payorderdetail')
    group by ds, firstcommodity, os_version
    union all
    select
        toString(ds) as key,
        firstcommodity as key1,
        os_version as key2,
        uniqExact(id) as uv,
        count() as pv,
        uniqExact(app_version) as u_app_version,
        uniqExact(price) as u_price
    from remote('172.21.100.43', default.data_part_ds)
    where xwhat in ('addtoshoppingcart', 'submitorderdetail', 'share', 'payorderdetail')
    group by ds, firstcommodity, os_version
    union all
    select
        toString(ds) as key,
        firstcommodity as key1,
        os_version as key2,
        uniqExact(id) as uv,
        count() as pv,
        uniqExact(app_version) as u_app_version,
        uniqExact(price) as u_price
    from remote('172.21.100.44', default.data_part_ds)
    where xwhat in ('addtoshoppingcart', 'submitorderdetail', 'share', 'payorderdetail')
    group by ds, firstcommodity, os_version
)
order by key, key1, key2;
