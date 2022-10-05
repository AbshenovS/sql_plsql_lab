CREATE TABLE num_to_roman(
   arab_num INTEGER,
   roman VARCHAR2(10)
);
INSERT INTO num_to_roman VALUES (1, 'I');
INSERT INTO num_to_roman VALUES (4, 'IV');
INSERT INTO num_to_roman VALUES (5, 'V');
INSERT INTO num_to_roman VALUES (9, 'IX');
INSERT INTO num_to_roman VALUES (10, 'X');
INSERT INTO num_to_roman VALUES (40, 'XL');
INSERT INTO num_to_roman VALUES (50, 'L');
INSERT INTO num_to_roman VALUES (90, 'XC');
INSERT INTO num_to_roman VALUES (100, 'C');
INSERT INTO num_to_roman VALUES (400, 'CD');
INSERT INTO num_to_roman VALUES (500, 'D');
INSERT INTO num_to_roman VALUES (900, 'CM');
INSERT INTO num_to_roman VALUES (1000, 'M');


CREATE OR REPLACE PROCEDURE converter(arabic_number IN INTEGER,
                               rom_out OUT VARCHAR2) 
IS
   roman_num num_to_roman.roman%TYPE;
   input_num INTEGER := arabic_number;
   cnt INTEGER;
BEGIN
   FOR n IN(
           SELECT arab_num, roman
           FROM num_to_roman
           ORDER BY 1 DESC)
   LOOP
       cnt := floor(input_num / n.arab_num);
       IF cnt>0 THEN
           FOR i IN 1..cnt
           LOOP
               roman_num := roman_num || n.roman;
           END LOOP;
           input_num := MOD(input_num, n.arab_num);
       END IF;
   END LOOP;
   rom_out := roman_num;  -- for second task
   dbms_output.put_line(roman_num);  -- for first task
END;

-- Test
DECLARE
   output VARCHAR2(20);
BEGIN
   converter(1, output); converter(2, output); converter(3, output); 
   converter(42, output); converter(57, output); converter(63, output); 
   converter(74, output); converter(8, output); converter(905, output);
   converter(1413, output);
END;