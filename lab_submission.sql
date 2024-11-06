-- (i) A Procedure called PROC_LAB5 takes a minimum credit limit as an input parameter and return the list of customers who have a credit limit greater than or equal to that amount.
DELIMITER $$

CREATE PROCEDURE PROC_LAB5(IN minCreditLimit DECIMAL(10,2))
BEGIN
    SELECT customerName, creditLimit
    FROM customers
    WHERE creditLimit >= minCreditLimit
    ORDER BY creditLimit DESC;
END $$

DELIMITER ;

-- (ii) A Function called FUNC_LAB5 = calculates a simple commission (e.g., 5%) based on an input sales amount.
DELIMITER $$

CREATE FUNCTION FUNC_LAB5(salesAmount DOUBLE) RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE commission DOUBLE;
    SET commission = salesAmount * 0.05; -- Assuming a 5% commission rate
    RETURN commission;
END $$

DELIMITER ;

-- (iii) A View called VIEW_LAB5 = displays each customer's order history along with the total amount for each order, using information from customers, orders, and orderdetails.
CREATE VIEW VIEW_LAB5 AS
SELECT 
    c.customerNumber AS 'Customer ID',
    c.customerName AS 'Customer Name',
    o.orderNumber AS 'Order Number',
    SUM(od.quantityOrdered * od.priceEach) AS 'Order Total Amount'
FROM 
    customers c
JOIN 
    orders o ON c.customerNumber = o.customerNumber
JOIN 
    orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY 
    c.customerNumber, o.orderNumber
ORDER BY 
    c.customerNumber, o.orderNumber;
