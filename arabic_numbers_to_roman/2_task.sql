CREATE TABLE status_table_roman(
   member_id NUMBER(38, 0),
   activity_year_month NUMBER(38, 0),
   member_lifecycle_status VARCHAR(26),
   lapsed_month VARCHAR2(50)
);

CREATE OR REPLACE PROCEDURE status_converter IS
   arab_inp INTEGER;
   roman_out VARCHAR2(50);
   member_id_in NUMBER(38, 0);
   activity_ym_in NUMBER(38, 0);
   member_in VARCHAR(26);
BEGIN
   FOR r IN (
       SELECT 
           member_id, activity_year_month, member_lifecycle_status,
           row_number() 
             OVER(PARTITION BY 
               member_id,
               member_lifecycle_status, 
               lapsed_month - rownum_add 
               ORDER BY activity_year_month) *
           decode(member_lifecycle_status, 
                  'Active', 0, 1) AS lapsed_month
       FROM
           (SELECT * FROM intermediate_result)
       ORDER BY 1, 2)
   LOOP
   member_id_in := r.member_id;
   activity_ym_in := r.activity_year_month;
   member_in := r.member_lifecycle_status;
   arab_inp := r.lapsed_month;
   hw6(arab_inp, roman_out);
   INSERT INTO status_table_roman 
        VALUES(member_id_in, 
               activity_ym_in,
               member_in,
               decode(roman_out, NULL, 'No lapsed month', roman_out)
               );
   END LOOP;
END;

EXECUTE status_converter;

SELECT * FROM status_table_roman;