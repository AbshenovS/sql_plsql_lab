with sec_table as (
    select 
    distinct r.member_id, 
             c.calendar_year_month as activity_year_month
    from revenue_analysis r
    cross join calendar c
    where r.activity_year_month <= c.calendar_year_month)
select
    s.member_id, s.activity_year_month,
    decode(
        (select 1 from dual
         where (s.member_id, s.activity_year_month) in 
            (select member_id, activity_year_month
             from revenue_analysis)),
         1, 'Active','Lapsed') as "member_lifecycle_status",
    row_number() over(partition by
        s.member_id, 
        decode(
            (select 1 from dual
             where (s.member_id, s.activity_year_month) in 
                (select member_id, activity_year_month
                 from revenue_analysis)),
        1,'Active','Lapsed') 
        order by s.activity_year_month) as "lapsed_month",  
    row_number() 
        over(partition by s.member_id 
             order by s.activity_year_month) as "rownum_add"
from sec_table s
left join revenue_analysis r
on s.member_id=r.member_id
group by s.member_id, s.activity_year_month
order by 1, 2;
