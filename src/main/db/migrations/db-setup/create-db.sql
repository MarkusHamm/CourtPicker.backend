-- ----- DB SETUP -----

-- fill in correct password
CREATE ROLE cpuser LOGIN ENCRYPTED PASSWORD 'TODO';

CREATE DATABASE courtpicker
  WITH OWNER = cpuser
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'German_Austria.1252'
       LC_CTYPE = 'German_Austria.1252'
       CONNECTION LIMIT = -1;