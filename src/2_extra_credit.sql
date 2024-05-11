DROP FUNCTION if exists OvertimePay;
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

CREATE PROCEDURE if not exists EmployeeTotalPay(
    IN first_name VARCHAR(45),
    IN last_name VARCHAR(45),
    IN total_hours INT,
    IN normal_hours INT,
    IN overtime_factor FLOAT(5, 3),
    IN max_overtime_pay FLOAT(6, 2),
    OUT total_pay FLOAT(10, 2)
)
DETERMINISTIC
BEGIN
    DECLARE overtime_hours INT;
    DECLARE hourly_rate FLOAT(5, 2);
    SET overtime_hours = total_hours - normal_hours;
    SELECT j.hourly_rate INTO hourly_rate
        FROM employees e
        JOIN jobs j ON e.job_id = j.id
        WHERE e.first_name = first_name
          AND e.last_name = last_name;
    SET total_pay = (normal_hours * hourly_rate) + OvertimePay(overtime_hours, hourly_rate * overtime_factor, max_overtime_pay);
END;

CALL EmployeeTotalPay('Philip', 'Wilson', 2160, 2080, 1.5, 6000.00, @Philip_Wilson);
CALL EmployeeTotalPay('Daisy', 'Diamond', 2100, 2080, 1.5, 6000.00, @Daisy_Diamond);

SELECT ROUND(@Philip_Wilson, 2) AS "Philip Wilson", ROUND(@Daisy_Diamond, 2) AS "Daisy Diamond";