-- 1-subtask
create table another_calendar as
select *
from calendar
where 0=1;

DECLARE
   cal_recs calendar%rowtype;
BEGIN
  for cal_recs in 
       (select * from calendar 
        where calendar_year<2017 and calendar_day_name='Friday'
        and (rowid,1) IN (select rowid, mod(rownum, 2) from calendar))
  loop
   insert into another_calendar values cal_recs;
  end loop;
END;

-- 2-subtask
DECLARE
   type all_data is table of calendar%rowtype;
   cal_recs all_data;
   cursor cur is
        select * from calendar 
        where calendar_year<2017 and calendar_day_name='Friday'
        and (rowid,1) IN (select rowid, mod(rownum, 2) from calendar);
BEGIN
   open cur;
   loop
       fetch cur
       bulk collect into cal_recs limit 10000;
       exit when cal_recs.count=0;
       forall i in 1..cal_recs.count
           insert into another_calendar values cal_recs(i);
   end loop;
   close cur;
END;

-- 3-subtask
DECLARE
   type array_data 
       is table of calendar%rowtype
       index by binary_integer;
   cal_recs array_data;
   i binary_integer := 1;
BEGIN
   for r in (
       select * from calendar 
       where calendar_year<2017 and 
       calendar_day_name='Friday' and
       (rowid,1) IN (select rowid, mod(rownum, 2) from calendar))
   loop
       cal_recs(i) := r;
       i := i + 1;
   end loop;
   insert into another_calendar values cal_recs(2);
   insert into another_calendar values cal_recs(6);
   insert into another_calendar values cal_recs(12);
END;
