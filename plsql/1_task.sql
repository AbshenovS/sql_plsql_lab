-- 1-option
create table cal_new as
select calendar_date, calendar_day_name 
from calendar
where 0=1;

DECLARE
  type cal_rec is record(
   new_date date,
   new_day varchar2(100)
  );
  data_record cal_rec;
BEGIN
  for r in (select calendar_date, calendar_day_name from calendar)
  loop
   data_record.new_date := r.calendar_date;
   data_record.new_day := r.calendar_day_name;
   insert into cal_new values data_record;
  end loop;
END;

-- 2-option
DECLARE
  type cal_rec is record(
   new_date calendar.calendar_date%TYPE,
   new_day calendar.calendar_day_name%TYPE
  );
  data_record cal_rec;
BEGIN
  for r in (select calendar_date, calendar_day_name from calendar)
  loop
   data_record.new_date := r.calendar_date;
   data_record.new_day := r.calendar_day_name;
   insert into cal_new values data_record;
  end loop;
END;