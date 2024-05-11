USE payroll;

INSERT INTO departments (name) VALUES ('Office of Finance');
INSERT INTO departments (name) VALUES ('Office of Human Resources');
INSERT INTO departments (name) VALUES ('City Ethics Commission');
INSERT INTO jobs (title, type, hourly_rate) VALUES ('Accountant', 'Full Time', 25.00);
INSERT INTO jobs (title, type, hourly_rate) VALUES ('Tax Renewal Assistant I', 'Part Time', 15.00);
INSERT INTO jobs (title, type, hourly_rate) VALUES ('Senior Accountant II', 'Full Time', 40.00);
INSERT INTO jobs (title, type, hourly_rate) VALUES ('Senior Accountant I', 'Full Time', 35.00);
INSERT INTO jobs (title, type, hourly_rate) VALUES ('Investment Officer II', 'Full Time', 35.00);
INSERT INTO jobs (title, type, hourly_rate) VALUES ('Management Analyst II', 'Full Time', 40.00);
INSERT INTO jobs (title, type, hourly_rate) VALUES ('Management Analyst I', 'Part Time', 25.00);
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Carol', 'Brown', 1, 2, DATE('2022-04-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Daisy', 'Diamond', 1, 3, DATE('2022-02-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Rich', 'Elbert', 1, 5, DATE('2019-07-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Lee', 'Durrett', 1, 7, DATE('2011-01-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Ray', 'Shipley', 1, 6, DATE('2023-10-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Nina', 'Shipley', 2, 6, DATE('2021-10-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Dixie', 'Herda', 3, 1, DATE('2020-10-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Stephen', 'West', 3, 2, DATE('2020-10-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Robin', 'Walker', 3, 3, DATE('2020-10-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Antoinette', 'Matava', 3, 4, DATE('2020-10-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Courtney', 'Walker', 3, 5, DATE('2020-10-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Gladys', 'Bosch', 3, 6, DATE('2020-10-01'));
INSERT INTO employees (first_name, last_name, department_id, job_id, date_employed)
VALUES ('Philip', 'Wilson', 3, 1, DATE('2020-10-01'));
INSERT INTO insurance_benefits (job_id, annual_insurance) VALUES (1, 5000.00);
INSERT INTO insurance_benefits (job_id, annual_insurance) VALUES (2, 1000.00);
INSERT INTO insurance_benefits (job_id, annual_insurance) VALUES (3, 11000.00);
INSERT INTO insurance_benefits (job_id, annual_insurance) VALUES (4, 9000.00);
INSERT INTO insurance_benefits (job_id, annual_insurance) VALUES (5, 8000.00);
INSERT INTO insurance_benefits (job_id, annual_insurance) VALUES (6, 10000.00);
INSERT INTO insurance_benefits (job_id, annual_insurance) VALUES (7, 6000.00);