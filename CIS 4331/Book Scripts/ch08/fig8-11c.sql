SELECT SUBSTR(name, 1, (INSTR(name, ' ') - 1)) AS first_name,
       SUBSTR(name, (INSTR(name, ' ') + 1)) AS last_name
FROM string_sample






