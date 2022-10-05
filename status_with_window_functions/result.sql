select 
    distinct m_id1, calendar_year_month, member_lifecycle_status,
    row_number() 
        over(partition by m_id1,
             member_lifecycle_status, 
             f_c-s_c order by calendar_year_month) *
             decode(member_lifecycle_status, 'Active', 0, 1) as "lapsed_month"
from
    (select * from prepared_dataset)
order by 1, 2;
