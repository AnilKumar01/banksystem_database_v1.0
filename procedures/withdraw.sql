USE BANK_SYSTEM
DELIMITER //
DROP PROCEDURE IF EXISTS WITHDRAW_AMOUNT;
CREATE PROCEDURE WITHDRAW_AMOUNT
(
	IN ACC_NO VARCHAR(20),
	IN WITHDRAW_AMOUNT DECIMAL(10,2),
	IN DESCRIPTION VARCHAR(60),
	OUT P_TRANSACTION_ID INT UNSIGNED
)
BEGIN
	DECLARE V_WIDAMOUNT DECIMAL(10,2);
	DECLARE V_NEWAMOUNT DECIMAL(10,2);
	
	SELECT (ACCOUNT_BALANCE) INTO V_WIDAMOUNT FROM ACCOUNT
	WHERE ACCOUNT_NO=ACC_NO;
    
	SET V_NEWAMOUNT= (V_WIDAMOUNT-WITHDRAW_AMOUNT);
    UPDATE ACCOUNT SET ACCOUNT_BALANCE=V_NEWAMOUNT WHERE ACCOUNT_NO=ACC_NO;
	
	INSERT INTO ACCOUNT_STATEMENTS(ACCOUNT_NO,TRANSACTION_DATE,DESCRIPTIONS,WITHDRAW,ACCOUNT_BALANCE)VALUES(ACC_NO,NOW(),DESCRIPTION,WITHDRAW_AMOUNT,V_NEWAMOUNT);
	
	INSERT INTO DAILY_TRANSACTIONS (T_AMOUNT, T_DATE_TIME, TRANSACTION_DETAIL, TO_OR_ON_ACCOUNT)
	VALUES(WITHDRAW_AMOUNT,NOW(),DESCRIPTION,ACC_NO);
	
	SELECT COUNT(*) INTO P_TRANSACTION_ID FROM DAILY_TRANSACTIONS;
	
 END;
//