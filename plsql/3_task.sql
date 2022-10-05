DECLARE
   type month_day_array is varray(20) of varchar2(50);
   month_day month_day_array := month_day_array();
   procedure print_all (heading varchar2) is
       BEGIN
       DBMS_OUTPUT.PUT_LINE(heading);
       for i in 1..19 loop
           DBMS_OUTPUT.PUT_LINE(month_day(i));
           end loop;
       DBMS_OUTPUT.PUT_LINE('Number of recordings: '||month_day.count);
       END;
BEGIN
   select * bulk collect into month_day 
       from(
           select calendar_month_name month_day_names
           from calendar
           union
           select calendar_day_name
           from calendar);
   print_all('3-task answer:');
END;
