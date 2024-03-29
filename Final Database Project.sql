-- --------------------------------------------------------------------- --------------------------------------------------------------------------------
-- Name: Ryan Groch
-- Class: IT-111
-- Abstract: Final Exam Database
-- --------------------------------------------------------------------------------

USE dbSQL1; 
SET NOCOUNT ON;	

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
IF OBJECT_ID( 'TJobWorkers' )									IS NOT NULL DROP TABLE TJobWorkers
IF OBJECT_ID( 'TJobMaterials' )									IS NOT NULL DROP TABLE TJobMaterials
IF OBJECT_ID( 'TJobs' )										IS NOT NULL DROP TABLE TJobs
IF OBJECT_ID( 'TStatuses' )									IS NOT NULL DROP TABLE TStatuses
IF OBJECT_ID( 'TWorkerSkills' )									IS NOT NULL DROP TABLE TWorkerSkills
IF OBJECT_ID( 'TCustomers' )									IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID( 'TWorkers' )									IS NOT NULL DROP TABLE TWorkers
IF OBJECT_ID( 'TSkills' )									IS NOT NULL DROP TABLE TSkills
IF OBJECT_ID( 'TMaterials' )									IS NOT NULL DROP TABLE TMaterials
IF OBJECT_ID( 'TVendors' )									IS NOT NULL DROP TABLE TVendors
IF OBJECT_ID( 'TStates' )									IS NOT NULL DROP TABLE TStates
-- --------------------------------------------------------------------------------
-- Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TJobs
(
	 intJobID							INTEGER				NOT NULL
	,intCustomerID							INTEGER				NOT NULL
	,intStatusID							INTEGER				NOT NULL
	,dtmStartDate							DATETIME			NOT NULL
	,dtmEndDate							DATETIME			NOT NULL
	,strJobDesc							VARCHAR(2000)			NOT NULL
		,CONSTRAINT TJobs_PK PRIMARY KEY ( intJobID )
)

-- --------------------------------------------------------------------------------
CREATE TABLE TCustomers
(
	  intCustomerID						INTEGER			NOT NULL
	 ,strFirstName						VARCHAR(255)		NOT NULL
	 ,strLastName						VARCHAR(255)		NOT NULL
	 ,strAddress_#						VARCHAR(255)		NOT NULL
	 ,strAddress_Street					Varchar(255)		Not Null
	 ,strCity						VARCHAR(255)		NOT NULL
	 ,intStateID						INTEGER			NOT NULL
	 ,strPhoneNumber					VARCHAR(255)		NOT NULL
		,CONSTRAINT TCustomer_PK PRIMARY KEY ( intCustomerID )
)

-- --------------------------------------------------------------------------------
CREATE TABLE TStatuses
(
	 intStatusID							INTEGER			NOT NULL
	,strStatus							VARCHAR(255)		NOT NULL
		,CONSTRAINT TStatuses_PK PRIMARY KEY ( intStatusID )
)

-- --------------------------------------------------------------------------------
CREATE TABLE TJobMaterials
(
	 intJobMaterialID					INTEGER				NOT NULL
	,intJobID						INTEGER				NOT NULL
	,intMaterialID						INTEGER				NOT NULL
	,intQuantity						INTEGER				NOT NULL
		,CONSTRAINT TCustomerJobMaterials_PK PRIMARY KEY ( intJobMaterialID )
)

-- --------------------------------------------------------------------------------
CREATE TABLE TMaterials
(
	 intMaterialID						INTEGER				NOT NULL
	,strDescription						VARCHAR(255)			NOT NULL
	,monCost						MONEY				NOT NULL
	,intVendorID						INTEGER				NOT NULL
		,CONSTRAINT TMaterials_PK PRIMARY KEY ( intMaterialID )
)

-- --------------------------------------------------------------------------------
CREATE TABLE TVendors
(
	 intVendorID						INTEGER			NOT NULL
	,strVendorName						VARCHAR(255)		NOT NULL
	,strAddress						VARCHAR(255)		NOT NULL
	,strCity						VARCHAR(255)		NOT NULL
	,intStateID						INTEGER			NOT NULL
	,strPhoneNumber						VARCHAR(255)		NOT NULL
		,CONSTRAINT TVendors_PK	 PRIMARY KEY ( intVendorID )
)

-- --------------------------------------------------------------------------------
CREATE TABLE TJobWorkers
(
	 intJobWorkerID						INTEGER				NOT NULL
	,intJobID						INTEGER				NOT NULL
	,intWorkerID						INTEGER				NOT NULL
	,intHoursWorked						INTEGER				NOT NULL
		,CONSTRAINT TCustomerJobWorkers_PK	PRIMARY KEY ( intJobWorkerID )
)

-- --------------------------------------------------------------------------------
CREATE TABLE TWorkers
(
	 intWorkerID						INTEGER			NOT NULL
	 ,strFirstName						VARCHAR(255)		NOT NULL
	 ,strLastName						VARCHAR(255)		NOT NULL
	 ,strAddress						VARCHAR(255)		NOT NULL
	 ,strCity						VARCHAR(255)		NOT NULL
	 ,intStateID						INTEGER			NOT NULL
	 ,strPhoneNumber					VARCHAR(255)		NOT NULL
	 ,dtmHireDate						DATETIME		NOT NULL
	 ,monHourlyRate						MONEY			NOT NULL
		 ,CONSTRAINT TWorkers_PK PRIMARY KEY ( intWorkerID )
)

-- --------------------------------------------------------------------------------
CREATE TABLE TWorkerSkills
(
	 intWorkerSkillID					INTEGER				NOT NULL
	,intWorkerID						INTEGER				NOT NULL
	,intSkillID							INTEGER			NOT NULL
		,CONSTRAINT	TWorkerSkills_PK PRIMARY KEY ( intWorkerSkillID )
)

-- --------------------------------------------------------------------------------
CREATE TABLE TSkills
(
	 intSkillID							INTEGER			NOT NULL
	,strSkill							VARCHAR(255)		NOT NULL
	,strDescription							VARCHAR(255)		NOT NULL
		,CONSTRAINT TSkills_PK PRIMARY KEY ( intSkillID )
)

-- --------------------------------------------------------------------------------
CREATE TABLE TStates
(
	 intStateID							INTEGER			NOT NULL
	,strState							VARCHAR(255)		NOT NULL
		,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID )
)

-- --------------------------------------------------------------------------------
-- Establish Referential Integrity  
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent							Column
-- -	-----							------							---------
-- 1	TJobs							TCustomers						intCustomerID    
-- 2	TJobs							TStatuses						intStatusID  

-- 3	TCustomers						TStates							intStateID  

-- 4	TJobMaterials						TJobs							intJobID 
-- 5	TJobMaterials						TMaterials						intMaterialID  

-- 6	TMaterials						TVendors						intVendorID  

-- 7	TVendors						TStates							intStateID   

-- 8	TJobWorkers						TJobs							intJobID  
-- 9	TJobWorkers						TWorkers						intWorkerID  

-- 10	TWorkers						TStates							intStateID   

-- 11	TWorkerSkills						TWorkers						intWorkerID   
-- 12	TWorkerSkills						TSkills							intSkillID   


-- 1
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TCustomers_FK 
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )

-- 2
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TStatuses_FK
FOREIGN KEY ( intStatusID ) REFERENCES TStatuses ( intStatusID )

-- 3
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 4
ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TJobs_FK
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )

-- 5
ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TMaterials_FK
FOREIGN KEY ( intMaterialID ) REFERENCES TMaterials ( intMaterialID )

-- 6
ALTER TABLE TMaterials ADD CONSTRAINT TMaterials_TVendors_FK
FOREIGN KEY ( intVendorID ) REFERENCES TVendors ( intVendorID )

-- 7
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 8
ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TJobs_FK
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )

-- 9
ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )

-- 10
ALTER TABLE TWorkers ADD CONSTRAINT TWorkers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 11
ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerskills_TWorkers_FK
FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )

-- 12
ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerskills_TSkills_FK
FOREIGN KEY ( intSkillID ) REFERENCES TSkills ( intSkillID )

-- --------------------------------------------------------------------------------
-- Add Data
-- --------------------------------------------------------------------------------
Insert Into TStates (intStateID, strState)
Values				(1, 'Alabama')
					,(2, 'Ohio')
					,(3, 'Illinois')
					,(4, 'Florida')

-- --------------------------------------------------------------------------------
Insert Into TCustomers (intCustomerID, strFirstName, strLastName, strAddress_#, strAddress_Street, strCity, intStateID, strPhoneNumber)
Values					(1, 'Bobby', 'McRay', '5050', 'Main St.', 'Florence', 1, '256-556-2258')
					   ,(2, 'Ryan', 'Gosling', '1337', 'Awesome Rd.', 'Cincinnati', 2, '513-225-1128')
					   ,(3, 'Toni', 'Breoerman', '5910', 'Woodthrush Ln.', 'Chicago', 3, '813-987-6681')
					   ,(4, 'Greg', 'Groch', '1234', 'Main St.', 'Hunstville', 1, '256-999-9999')
					   ,(5, 'Arthur', 'Morgan', '5555', 'Main St.', 'Huntley', 3, '813-541-9725')

-- --------------------------------------------------------------------------------
Insert Into TStatuses (intStatusID, strStatus)
Values				  (1, 'Completed')
					,(2, 'In Progress')
					,(3, 'Not Completed')

-- --------------------------------------------------------------------------------
Insert Into TJobs (intJobID, strJobDesc, dtmStartDate, dtmEndDate, intCustomerID, intStatusID)
Values			 (1, 'Leaky faucet', '1/1/2010', '1/15/2010', 1, 1)
				,(2, 'Bad toilet', '5/15/2015', '5/25/2015', 2, 2)
				,(3, 'Shower leaking', '9/27/2018', '10/20/2018', 3, 3)
				,(4, 'Leaking Ceiling', '2/19/2016', '3/7/2015', 1, 1)
				,(5, 'Bad Floor Plumbing', '5/21/2011', '6/12/2011', 1, 1)
				,(6, 'Faulty Water Heater', '12/1/2018', '12/15/2011', 1, 2)
				,(7, 'Broken Sink Handle', '10/11/2014', '10/12/2014', 1, 3)
				
-- --------------------------------------------------------------------------------
Insert Into TWorkers (intWorkerID, strFirstName, strLastName, strAddress, strCity, intStateID, strPhoneNumber, dtmHireDate, monHourlyRate)
Values				 (1, 'John', 'Smith', '2550 Street St.', 'Cincinnati', 1, '513-225-6458', '7/15/2005', '20.00')
					,(2, 'Ole Man', 'Jenkins', '4507 Eastwood Dr.', 'Tampa Bay', 4, '557-623-1147', '12/1/2018', '15.00')
					,(3, 'Tommy', 'Tomphson', '555 ClearView Ave.', 'Cleavland', 2, '513-696-6969', '8/27/2010', '17.00')
					,(4, 'Susan', 'Grimshaw', '1234 Valentine Rd.', ' Birmingham', 1, '256-445-1236', '5/17/2012', '16.00')

-- --------------------------------------------------------------------------------
Insert Into TVendors (intVendorID, strVendorName, strAddress, strCity, intStateID, strPhoneNumber)
Values				 (1, 'PlumbingPeople', '6012 Plumbing Rd.', 'Bethel', 2, '513-556-5131')

-- --------------------------------------------------------------------------------
Insert Into TMaterials (intMaterialID, strDescription, monCost, intVendorID)
Values					(1, 'Pipe', '45.00', 1)
						,(2, 'Tools', '75.00', 1)
						,(3, 'Hardware', '25.00', 1)
						,(4, 'Supplies', '15.00', 1)

-- --------------------------------------------------------------------------------
Insert Into TJobMaterials (intJobMaterialID, intJobID, intMaterialID, intQuantity)
Values					  (1, 1, 1, 40)
						 ,(2, 2, 2, 10)
						 ,(3, 3, 3, 15)
						 ,(4, 4, 1, 30)
						 ,(5, 5, 2, 5)
						 
-- --------------------------------------------------------------------------------
Insert Into TJobWorkers (intJobWorkerID, intJobID, intWorkerID, intHoursWorked)
Values					(1, 1, 1, 40)
						,(2, 2, 2, 45)
						,(3, 3, 3, 0)
						,(4, 4, 2, 25)
						,(5, 5, 1, 37)
						,(6, 6, 3, 20)
						,(7, 7, 1, 30) 

-- --------------------------------------------------------------------------------
Insert Into TSkills (intSkillID, strSkill, strDescription)
Values				(1, 'Plumbing', 'Has worked in plumbing for over a decade.')
					,(2, 'Clean Up', 'Especially handy and organizing and cleaning.')
					,(3, 'Carpentry', 'Has vast knowledge in carpentry.')
					,(4, 'Business', 'Know how to successfully run a small business.')
-- --------------------------------------------------------------------------------	
Insert Into TWorkerSkills (intWorkerSkillID, intWorkerID, intSkillID)
Values					  (1, 1, 1)
						  ,(2, 1, 2)
						  ,(3, 3, 3)
						  ,(4, 3, 4)
						  ,(5, 4, 3)

-- --------------------------------------------------------------------------------
--Update and Delete Data
-- --------------------------------------------------------------------------------
-- 3.1
Select	TC.intCustomerID
		,TC.strFirstName + ', ' + TC.strLastName as Customers_Name
		,TC.strAddress_# + ', ' + TC.strAddress_Street as Address

From	TCustomers as TC

Update TCustomers
Set	   strAddress_# = '123'
Where  intCustomerID = 2

Update	TCustomers
Set		strAddress_Street = 'New Address'
Where	intCustomerID = 2

Select	TC.intCustomerID
		,TC.strFirstName + ', ' + TC.strLastName as Customers_Name
		,TC.strAddress_# + ', ' + TC.strAddress_Street as Address

From	TCustomers as TC

-- --------------------------------------------------------------------------------	  	
-- 3.2 
Select intWorkerID
		,strFirstName
		,strLastName
		,monHourlyRate 

From TWorkers

Update	TWorkers
Set		monHourlyRate = '22.00'
Where	intWorkerID = 1

Update	TWorkers
Set		monHourlyRate = '19.00'
Where	intWorkerID = 3

Select intWorkerID
		,strFirstName
		,strLastName
		,monHourlyRate From TWorkers	

-- --------------------------------------------------------------------------------	
-- 3.3
Select * From TJobWorkers

Delete From TJobWorkers
Where		intHoursWorked > '45'
	
Select * From TJobWorkers 


Select * From TJobMaterials

Delete From	TJobMaterials
Where		intMaterialID = 3

Select * From TJobMaterials

-- --------------------------------------------------------------------------------	
-- Queries
-- --------------------------------------------------------------------------------	
-- 4.1
Select	TJ.intJobID
		,strJobDesc as Job_Description
		,TS.strStatus as Job_Status
		,TC.intCustomerID
		,TC.strFirstName + ', ' + TC.strLastName as Customers_Name 
		,TJ.dtmStartDate as Start_Date

From	TJobs as TJ JOIN TCustomers as TC
	ON	TJ.intCustomerID = TC.intCustomerID
		JOIN	TStatuses as TS
	ON	TS.intStatusID = TJ.intStatusID

Where	TS.intStatusID = '2'

Order By TJ.intJobID

 --------------------------------------------------------------------------------	
--4.2 
Select	TJ.intJobID
		,TJ.strJobDesc as Job_Description
		,TS.strStatus as Job_Status
		,TC.strFirstName + ', ' + TC.strLastName as Customers_Name 
		,TM.intMaterialID
		,TM.strDescription as Materials
		,TJM.intQuantity as Material_Quantity
		,TM.monCost as Material_Cost
			

From	TJobs as TJ JOIN TStatuses as TS
	ON	TJ.intStatusID = TS.intStatusID

		JOIN TCustomers as TC
	ON	TC.intCustomerID = TJ.intCustomerID

		JOIN TJobMaterials as TJM
	ON	TJM.intJobID = TJ.intJobID

		JOIN TMaterials as TM
	ON	TM.intMaterialID = TJM.intMaterialID

Where	TS.intStatusID = 1

Order By TJ.intJobID
		,TM.intMaterialID

-- --------------------------------------------------------------------------------	
-- 4.3 Write a query to list the total cost for all materials for each completed job for the customer. 
--Use the data returned in step 4.2 to validate your results. 
Select	TJ.intJobID
		,TJ.strJobDesc as Job_Description
		,TS.strStatus as Job_Status
		,TC.strFirstName + ', ' + TC.strLastName as Customers_Name 
		,TM.strDescription as Materials
		,TJM.intQuantity as Material_Quantity
		,SUM(TM.monCost) as Material_Cost
			

From	TJobs as TJ JOIN TStatuses as TS
	ON	TJ.intStatusID = TS.intStatusID

		JOIN TCustomers as TC
	ON	TC.intCustomerID = TJ.intCustomerID

		JOIN TJobMaterials as TJM
	ON	TJM.intJobID = TJ.intJobID

		JOIN TMaterials as TM
	ON	TM.intMaterialID = TJM.intMaterialID

Where	TS.intStatusID = 1

Group By TJ.intJobID
		,TJ.strJobDesc
		,TS.strStatus
		,TC.strFirstName
		,TC.strLastName
		,TM.intMaterialID	
		,TM.strDescription
		,TJM.intQuantity

Order By TJ.intJobID

-- --------------------------------------------------------------------------------
--4.4	
Select	TJ.intJobID
		,TJ.strJobDesc as Job_Description
		,TS.strStatus as Job_Status
		,SUM(COALESCE(TJW.intHoursWorked, 0)) as Hours_Worked
		,AVG(COALESCE(TW.monHourlyRate * TJW.intHoursWorked, 0)) as Avg_Hourly_Rate

From	TJobs as TJ JOIN TStatuses as TS
	ON	TJ.intStatusID = TS.intStatusID

		LEFT JOIN TJobWorkers as TJW
	ON	TJW.intJobID = TJ.intJobID

		LEFT JOIN TWorkers as TW
	ON	TW.intWorkerID = TJW.intWorkerID

Group By TJ.intJobID
		 ,TJ.strJobDesc
		 ,TS.strStatus

Order By AVG(TW.monHourlyRate * TJW.intHoursWorked)

-- --------------------------------------------------------------------------------
--4.5
Select	TM.intMaterialID
		,TM.strDescription as Item_Description
		,ISNULL(CONVERT(varchar(25), TJ.intJobID), 'Not Used') as JobID

From	TMaterials as TM LEFT JOIN TJobMaterials as TJM
	ON	TM.intMaterialID = TJM.intMaterialID

		LEFT JOIN TJobs as TJ
	ON	TJ.intJobID = TJM.intJobID

-- --------------------------------------------------------------------------------
--4.6
Select	TW.intWorkerID
		,TW.strFirstName + ', ' + TW.strLastName as Workers_Name 
		,TS.intSkillID
		,TS.strSkill as Worker_Skill
		,TS.strDescription as Skill_Description
		,TW.dtmHireDate as Hire_Date
		,COUNT(TJW.intJobID) as Jobs_worked

From	TWorkers as TW Left JOIN TJobWorkers as TJW
	ON	TW.intWorkerID = TJW.intWorkerID

		Left JOIN TWorkerSkills as TWS
	ON	TWS.intWorkerID = TW.intWorkerID

		Left JOIN TSkills as TS
	ON	TS.intSkillID = TWS.intSkillID

Where	TS.intSkillID = 3

Group By TW.intWorkerID
		 ,TW.strFirstName
		 ,TW.strLastName
		 ,TS.intSkillID
		 ,TS.strSkill
		 ,TS.strDescription
		 ,TW.dtmHireDate

Order By TW.intWorkerID

-- --------------------------------------------------------------------------------
--4.7
Select	TW.intWorkerID
		,TW.strFirstName + ', ' + TW.strLastName as Workers_Name 
		,SUM(TJW.intHoursWorked) as Hours_Worked
		,COUNT(TJW.intJobID) as Jobs_worked

From	TWorkers as TW JOIN TJobWorkers as TJW
	ON	TW.intWorkerID = TJW.intWorkerID

Where	TJW.intHoursWorked > '20'

Group By TW.intWorkerID
		 ,TW.strFirstName
		 ,TW.strLastName

Order By TW.intWorkerID

-- --------------------------------------------------------------------------------
--4.8
Select	TC.intCustomerID
		,TC.strFirstName + ', ' + TC.strLastName as Customers_Name
		,TC.strAddress_# + ', ' + TC.strAddress_Street Address
				
From	TCustomers as TC

Where	TC.strAddress_Street = 'Main St.'
							 
Order By TC.intCustomerID

-- --------------------------------------------------------------------------------
--4.9 
Select	 TJ.intJobID
		,TJ.strJobDesc as Job_Description
		,TJ.dtmStartDate as Job_Start_Date
		,TJ.dtmEndDate as Job_End_Date
		,TS.strStatus as Job_Status

From	TJobs as TJ FULL JOIN TStatuses as TS
	ON	TJ.intStatusID = TS.intStatusID
	
Where	TS.intStatusID = 1
	AND	TJ.dtmStartDate BETWEEN '1/1/2010' and '1/31/2010'

-- --------------------------------------------------------------------------------
--4.10
Select	TW.intWorkerID
		,TW.strFirstName + ', ' + TW.strLastName as Worker_Name
		,TC.strFirstName + ', ' + TC.strLastName as Customer_Name
		,COUNT(TJW.intJobID) as Jobs_worked

From	TWorkers as TW LEFT JOIN TJobWorkers as TJW
	ON	TW.intWorkerID = TJW.intWorkerID

		LEFT JOIN TJobs as TJ
	ON	TJ.intJobID = TJW.intJobID

		LEFT JOIN TCustomers as TC
	ON	TC.intCustomerID = TJ.intCustomerID


Group By TW.intWorkerID
		 ,TW.strFirstName
		 ,TW.strLastName
		 ,TC.strFirstName
		 ,TC.strLastName

-- --------------------------------------------------------------------------------
--4.11
Select	TW.intWorkerID
		,TW.strFirstName + ', ' + TW.strLastName as Worker_Name
		,COUNT(TS.strSkill) as Number_of_Skills
		
From	TWorkers as TW LEFT JOIN TWorkerSkills as TWS
	ON	TW.intWorkerID = TWS.intWorkerID

		LEFT JOIN TSkills as TS
	ON	TS.intSkillID = TWS.intSkillID

Group By TW.intWorkerID
		 ,TW.strFirstName
		 ,TW.strLastName

Order By TW.intWorkerID

-- --------------------------------------------------------------------------------
--4.12 Write a query to list the total Charge to the customer for each job. Calculate the total charge to the customer as the 
--total cost of materials + total Labor costs + 30% Profit. 


-- -------------------------------------------------------------------------------- 
--4.13
Select	ISNULL(CONVERT(varchar(25), TV.intVendorID), 'No Job') as VendorID
		,ISNULL(CONVERT(varchar(25), TV.strVendorName), 'No Job') as Vendor
		,SUM(COALESCE(TM.monCost * TJM.intQuantity, 0)) as Total_Cost

From	TVendors as TV RIGHT JOIN TMaterials as TM
	ON	TV.intVendorID = TM.intVendorID

		RIGHT JOIN TJobMaterials as TJM
	ON	TJM.intMaterialID = TM.intMaterialID

		RIGHT JOIN TJobs as TB
	ON	TB.intJobID = TJM.intJobID

Where	TB.intJobID = 3

Group By TV.intVendorID
		 ,TV.strVendorName
		 
