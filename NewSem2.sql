
USE JULYSEM2;

--Marina Pajvancic
--StudentNo 103340660

--TASK 3

CREATE TABLE ACCOUNT
(AcctNo INT not null,
origAcct INT not null,
recAcct INT not null,
fName VARCHAR(50) not null,
lName VARCHAR(50) not null,
creditLimit INT not null,
balance INT,
CONSTRAINT PK_ACCOUNT PRIMARY KEY (AcctNo, origAcct, recAcct));

SELECT NAME FROM sys.objects
WHERE TYPE = 'U';

CREATE TABLE LOGa
(AcctNo INT not null,
origAcct INT not null,
recAcct int not null,
logDateTime DATETIME not null,
amount int,
PRIMARY KEY (AcctNo, origAcct, recAcct, logDateTime),
FOREIGN KEY (AcctNo, origAcct, recAcct) REFERENCES ACCOUNT);
--Task 3
--Write a stored PROCEDURE which takes 3 parameters, from acctNo, to acctNo and an amount. **
--The procedure should update the FROM account so that its balance is reduced by the amount
--The proecure should update the TO account so that its balance is increased by the amount
--Log the transfer by inserting the FROMaccount TOaccount and currentDateTime and amount into the log
--table

drop procedure TransferMoney;

CREATE PROCEDURE TransferMoney  @origAcct INT, @recAcct INT,  @amount INT

AS 
BEGIN

UPDATE ACCOUNT SET balance = balance - @amount WHERE origAcct = @origAcct AND recAcct = @recAcct

UPDATE ACCOUNT SET balance = balance + @amount WHERE origAcct = @recAcct  AND recAcct = @origAcct

INSERT INTO LOGa /*deduction of money*/
(
AcctNo,
origAcct,
recAcct,
logDateTime,
amount
)
SELECT  
    AcctNo,
    origAcct,
    recAcct,
    GETDATE(),
    @amount * -1
FROM  ACCOUNT   
WHERE origAcct = @origAcct 
AND recAcct = @recAcct;



INSERT INTO LOGa /*addition of money*/
(
AcctNo,
origAcct,
recAcct,
logDateTime,
amount
)
SELECT  
    AcctNo,
    recAcct,
    origAcct,
    GETDATE(),
    @amount
FROM  ACCOUNT   
WHERE origAcct = @recAcct
AND recAcct = @origAcct;

END;

/*SELECT CONCAT('amount transferred is from',@origAcct, 'to',@recAcct,'for an amount of',
@amount, calculation formula to go in here;*/
END;

--Task1

--Create a stored procedure called ͚MULTIPLY that takes 2 numbers as paramaters and
--outputs to screen the answer in the following format: e.g. The product of 2 and 3 is 6;
--**Please note code still works even though underlined in red**


CREATE PROCEDURE MULTIPLY AS 
BEGIN
DECLARE @intNo_1 INT
SET @intNo_1 = 2
DECLARE @intNo_2 INT 
SET @intNo_2 = 3 

SELECT CONCAT('The product of ', @intNo_1, 'and ', @intNo_2, 'is ', @intNo_1 * @intNo_2)
END;

EXEC MULTIPLY;


--***alternative way for Task1 to be done-assigning variables within the execute entry so that the
--paramaters aren't fixed within the procedure. Code works even though there are red lines.

/*CREATE PROCEDURE MULTIPLY2
@intNo_1 INT,
@intNo_2 INT AS
BEGIN 
SELECT CONCAT('The product of ', @intNo_1, 'and ', @intNo_2, 'is ', @intNo_1*@intNo_2);
END;

EXEC MULTIPLY2 @intNo_1 = 5, @intNo_2 = 3; */




drop procedure multiply2;
select name, modify_date from sys.procedures; 

--Task2
--Create a stored function called ADD that takes 2 numbers as paramaters
--and returns the sum of numbers (as a suitable numeric datatype)
--Write an anonymous block that calls the stored function, and outputs the result
--in the following format eg 'The sum of 1 and 5 is 6'
CREATE FUNCTION AddSum(@intNo_1 INT, @intNo_2 INT)/*declares data type only*/
RETURNS INT AS BEGIN

RETURN (@intNo_1 + @intNo_2) /*Return Value*/
END;
--ANONYMOUS BLOCK (definition: not stored, single use,
--calls the function and outputs its return value)
BEGIN
SELECT CONCAT('The sum of 1 and 5 is ', 1+5) as AddedSum
END;


DROP FUNCTION AddSum;





