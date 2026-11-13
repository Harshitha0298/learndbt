with sales as (
    select
        sales_id,
        product_sk,
        {{ multiply('unit_price', 'quantity') }} as calculated_amount,
        customer_sk,
        gross_amount,
        payment_method
    from {{ ref('bronze_sales') }}
),

product as (
    select
        product_sk,
        category
    from {{ ref('bronze_products') }}
),

customer as (
    select
        customer_sk,
        gender
    from {{ ref('bronze_customer') }}
),

joining as(
select
    s.sales_id,
    p.category,
    c.gender,
    s.calculated_amount,
    s.gross_amount,
    s.payment_method
from sales s
left join product p on s.product_sk = p.product_sk
left join customer c on s.customer_sk = c.customer_sk
)

select 
category,
gender,
sum(calculated_amount) as total_calculated_amount
from joining
group by category, gender
order by total_calculated_amount desc