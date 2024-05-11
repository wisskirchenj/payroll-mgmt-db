DROP FUNCTION if exists OvertimePay;
DROP FUNCTION if exists TaxOwed;
DROP FUNCTION if exists TotalPay;
DROP PROCEDURE if exists PayrollReport;
DROP TABLE if exists total_hours;

CREATE TEMPORARY TABLE total_hours
(
    name        VARCHAR(90) PRIMARY KEY,
    total_hours INT
);

INSERT INTO total_hours (name, total_hours)
VALUES ('Dixie Herda', 2095),
       ('Stephen West', 2091),
       ('Philip Wilson', 2160),
       ('Robin Walker', 2083),
       ('Antoinette Matava', 2115),
       ('Courtney Walker', 2206),
       ('Gladys Bosch', 900);

CREATE FUNCTION if not exists OvertimePay(
    hours INT,
    rate FLOAT(5, 2),
    max_overtime_pay FLOAT(6, 2)
) RETURNS FLOAT(8, 2)
    DETERMINISTIC
BEGIN
    DECLARE overtime_pay FLOAT(7, 2);
    SET overtime_pay = GREATEST(0, LEAST(hours * rate, max_overtime_pay));
    RETURN overtime_pay;
END;

CREATE FUNCTION if not exists TotalPay(
    total_hours INT,
    hourly_rate FLOAT(5, 2)
) RETURNS FLOAT(8, 2)
    DETERMINISTIC
BEGIN
    RETURN 2080 * hourly_rate
        + OvertimePay(total_hours - 2080, hourly_rate * 1.5, 6000.00);
END;

CREATE FUNCTION if not exists TaxOwed(
    income FLOAT(10, 2)
) RETURNS FLOAT(10, 2)
    DETERMINISTIC
BEGIN
    DECLARE tax_owed FLOAT(10, 2);
    SET tax_owed =
            CASE
                WHEN income <= 11000.00 THEN income * 10 / 100
                WHEN income <= 44725.00 THEN 1100.00 + (income - 11000.00) * 12 / 100
                WHEN income <= 95375.00 THEN 5147.00 + (income - 44725.00) * 22 / 100
                WHEN income <= 182100.00 THEN 16290.00 + (income - 95375.00) * 24 / 100
                WHEN income <= 231250.00 THEN 37104.00 + (income - 182100.00) * 32 / 100
                WHEN income <= 578125.00 THEN 52832.00 + (income - 231250.00) * 35 / 100
                ELSE 174238.25 + (income - 578125.00) * 37 / 100
                END;
    RETURN tax_owed;
END;

CREATE PROCEDURE if not exists PayrollReport(
    IN dept_name VARCHAR(45)
)
BEGIN
    SELECT CONCAT(e.first_name, ' ', e.last_name)                           AS full_names,
           2080 * j.hourly_rate                                             AS base_pay,
           OvertimePay(th.total_hours - 2080, j.hourly_rate * 1.5, 6000.00) AS overtime_pay,
           TotalPay(th.total_hours, j.hourly_rate)                          AS total_pay,
           TaxOwed(TotalPay(th.total_hours, j.hourly_rate))                 AS tax_owed,
           TotalPay(th.total_hours, j.hourly_rate)
               - TaxOwed(TotalPay(th.total_hours, j.hourly_rate))           AS net_income
    FROM employees e
             JOIN departments d ON e.department_id = d.id
             JOIN jobs j ON e.job_id = j.id
             JOIN total_hours th on CONCAT(e.first_name, ' ', e.last_name) = th.name
    WHERE d.name = dept_name
    ORDER BY net_income DESC;
END;
CALL PayrollReport('City Ethics Commission');
