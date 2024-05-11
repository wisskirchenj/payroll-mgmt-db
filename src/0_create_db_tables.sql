CREATE DATABASE if not exists payroll;
USE payroll;
CREATE TABLE IF NOT EXISTS departments
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL
);
CREATE TABLE IF NOT EXISTS jobs
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    title       VARCHAR(45) NOT NULL,
    type        VARCHAR(45) NOT NULL,
    hourly_rate FLOAT(5, 2)
);
CREATE TABLE IF NOT EXISTS employees
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    first_name    VARCHAR(45) NOT NULL,
    last_name     VARCHAR(45) NOT NULL,
    department_id INT         NOT NULL,
    job_id        INT         NOT NULL,
    date_employed DATE,
    constraint fk_department_id foreign key (department_id) references departments (id),
    constraint fk_emp_job_id foreign key (job_id) references jobs (id)
);
CREATE TABLE IF NOT EXISTS insurance_benefits
(
    id               INT PRIMARY KEY AUTO_INCREMENT,
    job_id           INT NOT NULL,
    annual_insurance FLOAT(7, 2),
    constraint fk_ins_job_id foreign key (job_id) references jobs (id)
);
