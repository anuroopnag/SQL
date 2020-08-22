CREATE TABLE Customer_Account_Details(
	Cust_ID 	      Number(5) 
			    CONSTRAINT Cust_Pkey Primary Key,
	Cust_Last_Name    VarChar2(20) 
                 CONSTRAINT CustLastName_Nnull NOT NULL,
 Cust_Mid_Name Char(3),
 Cust_First_Name   VarChar2(20),
 Account_No        Number(4) 
			    CONSTRAINT Cust_Account_Unq UNIQUE,
 Account_Type      Varchar2(15),
 Bank_branch       Varchar2(20),			
 Cust_Email 	      VarChar2(30) 
			    CONSTRAINT CustEmail_Unq UNIQUE );







INSERT INTO Customer_Account_Details
(Cust_ID,Cust_Last_Name,Cust_Mid_Name,Cust_First_Name,Account_No,Account_Type,Bank_Branch,Cust_Email)
VALUES (1,'Nag',NULL,'Anuroop',123,'Savings','Kolkata','anuroopnag@gmail.com');
INSERT INTO Customer_Account_Details
(Cust_ID,Cust_Last_Name,Cust_Mid_Name,Cust_First_Name,Account_No,Account_Type,Bank_Branch,Cust_Email)
VALUES (2,'Smith',NULL,'Rob',456,'Savings','Kolkata','smithrob@gmail.com');
SELECT * FROM Customer_Account_Details;
