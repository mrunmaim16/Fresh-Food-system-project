/*
RESULTING TABLES AFTER NORMALIZATION 

EMPLOYEE (EMPID, SSN, EMPNAME, JOBTITLE, DEPTID (FK))
EMPLOYEE_EMAIL (EMPID, EMPLOYEE_EMAIL)
EMPLOYEE_JOBTITLE( JOBTITLE, WORKING_HOURS, PAY_PER_HOUR)
EMPLOYEE_PHONENO (EMPID, EMPLOYEE_PHONENO)
DEPARTMENT (DEPTID, DEPT_NAME, CAT_ID, CAT_NAME, EMPID(FK))
PRODUCT (PID, PNAME, DEPTID(FK))
PRODUCT_SELLINGPRICE_QUANTITY (PNAME, SELLING_PRICE, AVAIL_QUALTITY)
PRODUCT_PNAME_SELLINGPRICE_RATING (PNAME, SELLING_PRICE, RATING)
ORDERS (OID, OTYPE (i.e. OrderStatus), MODE_OF_PAYMENT, CUSTID (FK))
PRODUCT_ORDER (PID, OID, QUANTITY)
SALES (SID, QUANTITY_LEFT_OVER)
ORDER_DETAILS (DELID, DEL_STATUS, EMPID (FK), OID (FK))
ORDER_PLACES_DATE (OID, ORDER_DATE)
ORDER_PLACES_QUANTITY (OID, ORDER_QUANTITY)
SALES_ORDER (SID, OID, DATE, DAY)
PRODUCT_SALES (SID, PID)
CUSTOMER (CUSTID, CUSTNAME)
CUSTOMER (CUSTOMER_EMAIL, CUSTOMER_PHONENO, CUSTOMER_ADDRESS)
CUSTOMER_EMAIL (CUSTID, CUSTOMER_EMAIL)
CUSTOMER_PHONENO (CUSTID, CUSTOMER_PHONENO)
CUSTOMER_ADDRESS (CUSTID, STREET_NO, CITY, ZIPCODE)
*/


CREATE TABLE Fall22_S004_9_EMPLOYEE (
	empID VARCHAR(10) NOT NULL,
	ssn INT NOT NULL,
	empName VARCHAR(100) NOT NULL,
	jobTitle VARCHAR(20) NOT NULL,
	PRIMARY KEY (empID)
);

CREATE TABLE Fall22_S004_9_CUSTOMER (
	custID VARCHAR(10) NOT NULL,
	custName VARCHAR(50) NOT NULL,
	PRIMARY KEY (custID)
);


CREATE TABLE Fall22_S004_9_CUSTOMER_EMAIL (
	custID VARCHAR(10) NOT NULL,
	custEmail VARCHAR(50) NOT NULL,
	PRIMARY KEY (custID,custEmail)
);

CREATE TABLE Fall22_S004_9_CUSTOMER_PHONENO (
	custID VARCHAR(10) NOT NULL,
	custPhoneNo INT NOT NULL,
	PRIMARY KEY (custID,custPhoneNo)
);

CREATE TABLE Fall22_S004_9_CUSTOMER_ADDRESS (
	custID VARCHAR(10) NOT NULL,
	streetNo VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	zipcode INT NOT NULL,
	PRIMARY KEY (custID,streetNo,city,zipcode)
);

CREATE TABLE Fall22_S004_9_EMPLOYEE_JOBTITLE (
	jobTitle VARCHAR(50) NOT NULL,
	workingHours INT NOT NULL,
	payPerHour FLOAT NOT NULL,
	PRIMARY KEY (jobTitle)
);

CREATE TABLE Fall22_S004_9_EMPLOYEE_PHONENO (
	empID VARCHAR(10) NOT NULL,
	empPhoneNo INT NOT NULL,
	PRIMARY KEY (empID,empPhoneNo)
);
CREATE TABLE Fall22_S004_9_EMPLOYEE_EMAIL (
	empID VARCHAR(10) NOT NULL,
	empEmail VARCHAR(50) NOT NULL,
	PRIMARY KEY (empID,empEmail)
);

CREATE TABLE FALL22_S004_9_DEPARTMENT  (
	deptID VARCHAR(10) NOT NULL,
	deptName VARCHAR(20) NOT NULL,
	catID VARCHAR(10) NOT NULL,
	catName VARCHAR(40) NOT NULL,
	PRIMARY KEY (deptID)
);

CREATE TABLE Fall22_S004_9_PRODUCT (
	pID VARCHAR(10) NOT NULL,
	pName VARCHAR(100) NOT NULL,
	PRIMARY KEY (pID)
);

CREATE TABLE FALL22_S004_9_ORDERS (
	oID VARCHAR(10) NOT NULL,
	oType VARCHAR(50) NOT NULL,
	modeOfPayment VARCHAR(50) NOT NULL,
	PRIMARY KEY (oID)
);


CREATE TABLE Fall22_S004_9_PRODUCT_order (
	pID VARCHAR(10) NOT NULL,
	oID VARCHAR(100) NOT NULL,
	quantity INT,
    FOREIGN KEY (oID) REFERENCES FALL22_S004_9_ORDERS(oID),
    FOREIGN KEY (pID) REFERENCES Fall22_S004_9_PRODUCT(pID)
);


CREATE TABLE FALL22_S004_9_PRODUCT_PNAME_SELLINGPRICE_QUANTITY (
	pName VARCHAR(100) NOT NULL,
	sellingPrice FLOAT NOT NULL,
	availQuantity INT NOT NULL,
	PRIMARY KEY (pName)
);

CREATE TABLE FALL22_S004_9_PRODUCT_PNAME_SELLINGPRICE_RATING  (
	pName VARCHAR(100) NOT NULL,
	sellingPrice FLOAT NOT NULL,
	rating FLOAT NOT NULL,
	PRIMARY KEY (pName, sellingPrice)
);

CREATE TABLE FALL22_S004_9_SALES (
	sID VARCHAR(10) NOT NULL,
	Qtyleftover int,
	PRIMARY KEY (sID)
);

CREATE TABLE FALL22_S004_9_ORDER_DETAILS (
	del_id VARCHAR(10) NOT NULL,
	del_status VARCHAR(50) NOT NULL,
	PRIMARY KEY (del_id)
);

CREATE TABLE FALL22_S004_9_ORDER_PLACES_DATE (
	oID VARCHAR(10) NOT NULL,
	order_Pdate DATE NOT NULL,
	PRIMARY KEY (oID,order_Pdate)
);

CREATE TABLE FALL22_S004_9_ORDER_PLACES_QUANTITY (
	oID VARCHAR(10) NOT NULL,
	o_pQuantity INT NOT NULL,
	PRIMARY KEY (oID,o_pQuantity)
);


CREATE TABLE FALL22_S004_9_SALES_ORDER (
	sID VARCHAR(10) NOT NULL,
	oID VARCHAR(10) NOT NULL,
	soDate DATE NOT NULL,
	day CHAR(10) NOT NULL,
    PRIMARY KEY(sID, oID),
    FOREIGN KEY (oID) REFERENCES FALL22_S004_9_ORDERS(oID),
    FOREIGN KEY (sID) REFERENCES FALL22_S004_9_SALES(sID)
);

CREATE TABLE Fall22_S004_9_PRODUCT_SALES (
	sID VARCHAR(10) NOT NULL,
	pID VARCHAR(10) NOT NULL,
    FOREIGN KEY (sID) REFERENCES FALL22_S004_9_SALES(sID),
    FOREIGN KEY (pID) REFERENCES Fall22_S004_9_PRODUCT(pID),
    PRIMARY KEY(sID, pID)
);


ALTER TABLE FALL22_S004_9_DEPARTMENT
ADD empID VARCHAR(10) NOT NULL;

ALTER TABLE FALL22_S004_9_DEPARTMENT
ADD CONSTRAINT empID
FOREIGN KEY (empID) REFERENCES Fall22_S004_9_EMPLOYEE(empID);


ALTER TABLE Fall22_S004_9_PRODUCT
ADD  deptID VARCHAR(10) NOT NULL;
ALTER TABLE Fall22_S004_9_PRODUCT
ADD CONSTRAINT deptID
FOREIGN KEY (deptID) REFERENCES FALL22_S004_9_DEPARTMENT(deptID);


ALTER TABLE FALL22_S004_9_ORDERS
ADD  custID VARCHAR(10) NOT NULL;
ALTER TABLE FALL22_S004_9_ORDERS
ADD CONSTRAINT FK_orders_custID
FOREIGN KEY (custID) REFERENCES Fall22_S004_9_CUSTOMER(custID);

ALTER TABLE FALL22_S004_9_ORDER_DETAILS
ADD  empID VARCHAR(10) NOT NULL;

ALTER TABLE FALL22_S004_9_ORDER_DETAILS
ADD CONSTRAINT FK_ord_detail_empID
FOREIGN KEY (empID) REFERENCES Fall22_S004_9_EMPLOYEE(empID);


ALTER TABLE FALL22_S004_9_ORDER_DETAILS
ADD  oID VARCHAR(10) NOT NULL;
ALTER TABLE FALL22_S004_9_ORDER_DETAILS
ADD CONSTRAINT oID
FOREIGN KEY (oID) REFERENCES FALL22_S004_9_ORDERS(oID);

