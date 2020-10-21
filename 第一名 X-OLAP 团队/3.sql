select
    key,
    key1,
    key2,
    key3,
    sum(uv),
    sum(pv),
    sum(sum_price)
from (
    select
        toString(ds) as key,
        firstcommodity as key1,
        secondcommodity as key2,
        commodityname as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.21', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by ds, firstcommodity, secondcommodity, commodityname
    union all
    select
        toString(ds) as key,
        firstcommodity as key1,
        secondcommodity as key2,
        commodityname as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.43', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by ds, firstcommodity, secondcommodity, commodityname
    union all
    select
        toString(ds) as key,
        firstcommodity as key1,
        secondcommodity as key2,
        commodityname as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.44', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by ds, firstcommodity, secondcommodity, commodityname
    union all
    select
        '小计' as key,
        firstcommodity as key1,
        secondcommodity as key2,
        commodityname as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.21', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by firstcommodity, secondcommodity, commodityname
    union all
    select
        '小计' as key,
        firstcommodity as key1,
        secondcommodity as key2,
        commodityname as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.43', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by firstcommodity, secondcommodity, commodityname
    union all
    select
        '小计' as key,
        firstcommodity as key1,
        secondcommodity as key2,
        commodityname as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.44', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by firstcommodity, secondcommodity, commodityname
    union all
    select
        toString(ds) as key,
        firstcommodity as key1,
        '合计' as key2,
        '' as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.21', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by ds, firstcommodity
    union all
    select
        toString(ds) as key,
        firstcommodity as key1,
        '合计' as key2,
        '' as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.43', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by ds, firstcommodity
    union all
    select
        toString(ds) as key,
        firstcommodity as key1,
        '合计' as key2,
        '' as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.44', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by ds, firstcommodity
    union all
    select
        '合计' as key,
        firstcommodity as key1,
        '' as key2,
        '' as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.21', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by firstcommodity
    union all
    select
        '合计' as key,
        firstcommodity as key1,
        '' as key2,
        '' as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.43', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by firstcommodity
    union all
    select
        '合计' as key,
        firstcommodity as key1,
        '' as key2,
        '' as key3,
        uniqExact(id) as uv,
        count() as pv,
        sum(price) as sum_price
    from remote('172.21.100.44', default.data_part_id)
    where xwhat in ('addtoshoppingcart', 'payorderdetail')
    group by firstcommodity
)
group by key, key1, key2, key3
order by key = '合计', key2 = '合计', key = '小计', key, key1, key2, key3;
