-- A medical center employs several doctors
-- A doctors can see many patients (M:M)
-- A patient can be seen by many doctors (1:M)
-- During a visit, a patient may be diagnosed to have one or more diseases. (1:M)

DROP DATABASE IF EXISTS medical_center_db;

CREATE DATABASE medical_center_db;

\c medical_center_db;

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    accepts_new_patients BOOLEAN NOT NULL,
    contact_number INTEGER,
    contact_email TEXT,
    specialization TEXT UNIQUE NOT NULL
);

INSERT INTO doctors (name, accepts_new_patients, contact_number, specialization)
VALUES('Richard Sanchez', false, 415949, 'Intergalactic medicine'),
('Jonas Salk', false, 619352, 'Virologist'),
('Elma Rodriguez-Wong', true, 415826, 'Medical Oncology');

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    medical_record_id INTEGER,
    patient_id INTEGER UNIQUE NOT NULL,
    has_copay BOOLEAN,
    covered_by_uhc BOOLEAN,
    patient_number INTEGER,
    patient_email TEXT
);

INSERT INTO patients (patient_id, has_copay, covered_by_uhc, patient_email)
VALUES(23324, false, true, 'starbright@gmail.com'),
(98754, true, false, NULL),
(72635, NULL, false, NULL);


CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    illness_found BOOLEAN NOT NULL,
    visit_date DATE,
    referred_by INT REFERENCES doctors(id)
);  

-- INSERT INTO visits (patient_id, illness_found, visit_date)
-- VALUES(23324, true, '2020-06-25');

-- UPDATE visits (patient_id, illness_found, visit_date)
-- VALUES(23324, true, '2020-06-25');

-- CREATE TABLE diagnosis (
--     id SERIAL PRIMARY KEY,
--     disease_id TEXT,
--     FOREIGN KEY (visit_id, doctor_id)
--     patients_id REFERENCES visit_id,
--     referred_by_doc REFERENCES doctor_id,
--     treatable BOOLEAN DEFAULT TRUE
-- );

-- CREATE TABLE diagnosis (
--     id SERIAL PRIMARY KEY,
--     disease_id TEXT,
--     CONSTRAINT fk_diagnosis_visit_id
--     FOREIGN KEY (visit_id, doctors_id)
--     REFERENCES visit (visit_id, doctors_id)
-- );

CREATE TABLE diagnosis (
    id SERIAL PRIMARY KEY,
    disease_id TEXT,
    visit_id INTEGER REFERENCES visits(id),
    treatable BOOLEAN
);


CREATE TABLE diseases (
    id SERIAL PRIMARY KEY,
    successfully_treated BOOLEAN DEFAULT TRUE 
);


*********************************************************************************

medical_center_db=# CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    accepts_new_patients BOOLEAN NOT NULL,
    contact_number INTEGER,
    contact_email TEXT,
    specialization TEXT UNIQUE NOT NULL
);
CREATE TABLE
medical_center_db=# \d
                  List of relations
 Schema |      Name      |   Type   |      Owner      
--------+----------------+----------+-----------------
 public | doctors        | table    |  XuXaO415
 public | doctors_id_seq | sequence |  XuXaO415
(2 rows)

medical_center_db=# 
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    medical_record_id INTEGER UNIQUE NOT NULL,
    has_copay BOOLEAN NOT NULL,
    covered_by_uhc BOOLEAN NOT NULL,
    patient_number INTEGER UNIQUE NOT NULL,
    patient_email TEXT UNIQUE NOT NULL
);
CREATE TABLE
medical_center_db=# \d
                   List of relations
 Schema |      Name       |   Type   |      Owner      
--------+-----------------+----------+-----------------
 public | doctors         | table    | XuXaO415
 public | doctors_id_seq  | sequence | XuXaO415
 public | patients        | table    | XuXaO415
 public | patients_id_seq | sequence | XuXaO415
(4 rows)

medical_center_db=# INSERT INTO doctors (name, accepts_new_patients, contact_number, specialization)
VALUES('Richard Sanchez', false, 415949, 'Intergalactic medicine'),
('Jonas Salk', false, 619352, 'Virologist'),
('Elma Rodriguez-Wong', true, 415826, 'Medical Oncology');
INSERT 0 3
medical_center_db=# SELECT * FROM doctors;
 id |        name         | accepts_new_patients | contact_number | contact_email |     specialization     
----+---------------------+----------------------+----------------+---------------+------------------------
  1 | Richard Sanchez     | f                    |         415949 |               | Intergalactic medicine
  2 | Jonas Salk          | f                    |         619352 |               | Virologist
  3 | Elma Rodriguez-Wong | t                    |         415826 |               | Medical Oncology


medical_center_db=# SELECT * FROM patients;
 id | medical_record_id | patient_id | has_copay | covered_by_uhc | patient_number |    patient_email     
----+-------------------+------------+-----------+----------------+----------------+----------------------
  1 |                   |      23324 | f         | t              |                | starbright@gmail.com
  2 |                   |      98754 | t         | f              |                | 
  3 |                   |      72635 |           | f              |                | 
(3 rows)

medical_center_db=# SELECT * FROM visits;
 id | patient_id | illness_found | visit_date | referred_by 
----+------------+---------------+------------+-------------
(0 rows)

medical_center_db=# SELECT * FROM diseases;
 id | successfully_treated 
----+----------------------
(0 rows)

CREATE TABLE
medical_center_db=# SELECT * FROM diagnosis;
 id | disease_id | visit_id | treatable 
----+------------+----------+-----------
(0 rows)

medical_center_db=# \d
                   List of relations
 Schema |       Name       |   Type   |      Owner      
--------+------------------+----------+-----------------
 public | diagnosis        | table    | XuXaO415
 public | diagnosis_id_seq | sequence | XuXaO415
 public | diseases         | table    | XuXaO415
 public | diseases_id_seq  | sequence | XuXaO415
 public | doctors          | table    | XuXaO415
 public | doctors_id_seq   | sequence | XuXaO415
 public | patients         | table    | XuXaO415
 public | patients_id_seq  | sequence | XuXaO415
 public | visits           | table    | XuXaO415
 public | visits_id_seq    | sequence | XuXaO415

-- https://www.techonthenet.com/sql_server/foreign_keys/foreign_keys.php