USE BANK_SYSTEM
DELIMITER //
DROP PROCEDURE IF EXISTS CHANGE_PASSWORD;
CREATE PROCEDURE CHANGE_PASSWORD
(
   IN P_USERNAME VARCHAR(60),
   IN P_PASSWORD VARCHAR(60)
)
BEGIN
	
	
	UPDATE DESKTOP_APP_USERS 
	SET PASSWORD=AES_ENCRYPT(P_PASSWORD, "6575")
	WHERE USERNAME=P_USERNAME;
END;
//
