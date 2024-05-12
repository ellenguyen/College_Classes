--Solutions to Optional Self Practice about Stored Functions and Triggers 
--For students

--1.1
--Solution 1: not use exception
CREATE OR REPLACE FUNCTION check_glaaccount_description
( account_description_par VARCHAR2)
RETURN NUMBER
AS
    return_value_var  NUMBER; 
BEGIN
    SELECT COUNT(*)
    INTO  return_value_var
    FROM  general_ledger_accounts
    WHERE account_description = account_description_par;
    
    return return_value_var;    
END;
/

--Solution 2: use EXCEPTION
CREATE OR REPLACE FUNCTION check_glaaccount_description
( account_description_par VARCHAR2)
RETURN NUMBER
AS
    return_value_var  NUMBER;
BEGIN
    SELECT 1
    INTO  return_value_var
    FROM  general_ledger_accounts
    WHERE account_description = account_description_par;
    
    return return_value_var;    
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

--1.2
SET SERVEROUTPUT ON

BEGIN
    IF check_glaaccount_description('Software') = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Software account exists.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Software account does NOT exist.');
    END IF;    
END;
/

----------------------
--2.1
CREATE OR REPLACE TRIGGER invoices_before_update_payment
    BEFORE UPDATE OF payment_total ON invoices
    FOR EACH ROW
BEGIN
    IF (:NEW.payment_total + :OLD.credit_total > :OLD.invoice_total) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Payment total + credit total can not be more than the invoice total!');
    END IF;
END;
/

--2.2
UPDATE invoices
SET   payment_total = 1500
WHERE invoice_id = 2;
