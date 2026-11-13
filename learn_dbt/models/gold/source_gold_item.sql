with deduped as (
select *,
row_number() over (partition by id order by updated_time desc) as deduped_rank
from {{ source('source', 'items') }}
)
select id,name,deduped_rank,category,updated_time
from deduped
where deduped_rank = 1