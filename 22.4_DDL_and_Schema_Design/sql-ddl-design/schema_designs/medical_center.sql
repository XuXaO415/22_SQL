DROP DATABASE IF EXISTS medical_center_db;

CREATE DATABASE medical_center_db;

\c medical_center_db;


CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    doctor_name TEXT UNIQUE NOT NULL,
    accepts_new_patients BOOLEAN NOT NULL,
    contact_number INTEGER,
    contact_email TEXT,
    specialization TEXT UNIQUE NOT NULL
);

INSERT INTO doctors (doctor_name, accepts_new_patients, contact_number,contact_email, specialization)
VALUES('Richard Sanchez', false, 415949, 'rSanchez@medical.com', 'Intergalactic medicine'),
('Jonas Salk', false, 619352, 'jSaulk@medical.com', 'Virologist'),
('Elma Rodriguez-Wong', true, 415826, 'elmaRW@md.com', 'Family Medicine'),
('Dr. Strange', true, 415826, 'dr.strange@med.com',  'Neurosurgery');


CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    medical_record_id INTEGER UNIQUE NOT NULL,
    has_copay BOOLEAN NOT NULL,
    has_insurance BOOLEAN NOT NULL,
    patient_number INTEGER UNIQUE NOT NULL,
    patient_email TEXT UNIQUE NOT NULL
);

INSERT INTO patients (medical_record_id, has_copay, has_insurance, patient_number, patient_email)
VALUES(23324, false, true, 123456, 'test@email.com'),
(98754, true, false, 654321, 'Abbey.kirkland@gmail.com'),
(72635, false, false, 987654, 'RichSanders@yahoo.com'),
(12345, true, true, 456789, 'emmyK@gmail.com');

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    seen_by INTEGER REFERENCES doctors(id),
    patient_concerns TEXT NOT NULL,
    prognosis TEXT NOT NULL,
    -- diagnosis TEXT NOT NULL,
    -- notes TEXT [] NOT NULL,
    notes TEXT[] NOT NULL,
    visit_date DATE NOT NULL
);


INSERT INTO visits (patient_id, seen_by, patient_concerns, prognosis, notes, visit_date)
VALUES(1, 4, 'I have a headache', 'Chronic migraine', '{"Medication perscribed"}', '2022-11-26'),
(3, 1, 'I have a headache', 'You have a headache', '{"You have a headache"}', '2019-01-01'),
(4, 2, 'I have a headache', 'You have a headache', '{"You have a headache"}', '2019-01-01'),
(2, 3, 'Severe chest pain', 'Patient is having a heart attack', '{"Admitted to the ER"}', '2022-11-16');

-- INSERT INTO visits (patient_id, seen_by, patient_concerns, prognosis, notes, visit_date)
-- VALUES(1,4, 'Persistent migraine', 'Chronic migraines, {'Patient is allergic to penicillin, prescription given'}', '2022-11-26'),
-- (3,1,'Morty fever, cronenberg syndrome', 'Severe flu, {'Patient infected by altered flu containing vole DNA, cross contaminated with mantis, koala, rattlesnake,shark, etc.'}', '2022-8-15'),
-- (4,2,'Persistent cough', 'Vomiting, chills, fever, {'Patient has regular flu'}', '2022-11-05'),
-- (2,3,'Persistent cough', 'Vomiting, chills, fever, {'Patient has regular flu'}', '2022-11-16');

-- INSERT INTO visits (patient_id, seen_by, patient_concerns, prognosis, notes, visit_date)
-- VALUES(1, 4, 'Persistent cough', 'Bronchitis',  'Patient is suffering from bronchitis.' '{Prescribed antibiotics and cough syrup.'}', '2022-11-26'),
-- (2, 1, 'Fever', 'Chills', 'Flu', 'Patient is suffering from the flu.' {'Prescribed antibiotics.'}', '2022-08-15'),
-- (3, 2, 'Headache', 'Migraine', 'Patient is suffering from a migraine.' {'Prescribed anti-migraine medicine.'}', '2022-11-05'),
-- (4, 3, 'Chest pain', 'Heart attack','Patient is suffering from a heart attack.' {'Admitted to ER.'}', '2020-11-16');




CREATE TABLE diagnoses (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    -- disease_id INTEGER REFERENCES diseases(id),
    disease_name TEXT NOT NULL,
    illness_found BOOLEAN NOT NULL,
    illness_desc TEXT NOT NULL,
    treatable BOOLEAN NOT NULL,
    visit_id INTEGER REFERENCES visits(id)
);


-- INSERT INTO diagnoses (patient_id, disease_name, illness_found, illness_desc, treatable, visit_id)
-- VALUES(1, 'Migraine', true, 'Chronic migraines', true, 1),
-- (3, 'Cronenberg Syndrome', true, 'Severe flu, 'Patient infected by altered flu containing vole DNA, cross contaminated with mantis, koala, rattlesnake,shark, etc.', true, 2),
-- (4, 'Flu', true, 'Vomiting, chills, fever', true, 3),
-- (2, 'Flu', true, 'Vomiting, chills, fever', true, 4);



CREATE TABLE diseases (
    id SERIAL PRIMARY KEY,
    disease_id INTEGER REFERENCES diagnoses(id),
    successfully_treated BOOLEAN DEFAULT TRUE,
    treated_by INTEGER REFERENCES doctors(id)
);

