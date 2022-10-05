## Task:
The calendar table is given (structure and dataset for download, see in /status_with_window_functions/)
1) you need to create a table cal_new(calendar_date, calendar_day_name). Write a PL/SQL block that will insert calendar values ​​from these fields. Use the RECORD structure. Make 2 options: via a specific data type and via %TYPE
2) you need to create another_calendar table with the structure as CALENDAR and insert records there, provided: the year is less than 2017 and insert only every second Friday in the dataset.

Implementation as a PL/SQL block. Develop implementation:
- via %ROWTYPE
- through nested tables (TABLE OF)
- through associative arrays (elements 2, 6, 12).

3) in the header, create a variable length array with a varchar structure. <br>

In the execution section, populate the array with the values ​​of the names of the months and days of the week from the clendar table (12 names of the months and 12 days of the week). Print array elements via
DBMS_OUTPUT.PUT_LINE (Oracle) / RAISE NOTICE (PostgreSQL)
