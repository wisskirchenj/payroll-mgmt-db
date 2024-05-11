DROP FUNCTION if exists OvertimePay;
DROP FUNCTION if exists TaxOwed;
DROP PROCEDURE if exists EmployeeTotalPay;

CREATE FUNCTION if not exists OvertimePay(
    hours INT,
    rate FLOAT(5, 2),
    max_overtime_pay FLOAT(6, 2)
) RETURNS FLOAT(7, 2)
    DETERMINISTIC
BEGIN
    DECLARE overtime_pay FLOAT(7, 2);
    SET overtime_pay = hours * rate;
    IF overtime_pay <= 0 THEN
        SET overtime_pay = 0;
    ELSEIF overtime_pay > max_overtime_pay THEN
        SET overtime_pay = max_overtime_pay;
    END IF;
    RETURN overtime_pay;
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

CREATE PROCEDURE if not exists EmployeeTotalPay(
    IN first_name VARCHAR(45),
    IN last_name VARCHAR(45),
    IN total_hours INT,
    IN normal_hours INT,
    IN overtime_factor FLOAT(5, 3),
    IN max_overtime_pay FLOAT(6, 2),
    OUT total_pay FLOAT(10, 2)
)
BEGIN
    DECLARE overtime_hours INT;
    DECLARE hourly_rate FLOAT(5, 2);
    SET overtime_hours = total_hours - normal_hours;
    SELECT j.hourly_rate
    INTO hourly_rate
    FROM employees e
             JOIN jobs j ON e.job_id = j.id
    WHERE e.first_name = first_name
      AND e.last_name = last_name;
    SET total_pay =
            (normal_hours * hourly_rate) + OvertimePay(overtime_hours, hourly_rate * overtime_factor, max_overtime_pay);
END;

CALL EmployeeTotalPay('Philip', 'Wilson', 2160, 2080, 1.5, 6000.00, @Philip_Wilson);
CALL EmployeeTotalPay('Daisy', 'Diamond', 2100, 2080, 1.5, 6000.00, @Daisy_Diamond);

SELECT ROUND(TaxOwed(@Philip_Wilson), 2) AS "Philip Wilson", ROUND(TaxOwed(@Daisy_Diamond), 2) AS "Daisy Diamond";