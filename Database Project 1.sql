-- --------------------------------------------------------------------------------
-- Name: Ryan Groch
-- Class: IT-111 
-- Abstract: Test 1

-- --------------------------------------------------------------------------------
USE dbSQL1;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-----------------------------------------------------------------------------------

-- Drop Table Statements

If Object_ID ('TDoctorsPatients')		Is Not Null		Drop Table TDoctorsPatients
If Object_ID ('TNursesPatients')		Is Not Null		Drop Table TNursesPatients
If Object_ID ('TPatientsAppointments')	Is Not Null		Drop Table TPatientsAppointments
If Object_ID ('TNursesAppointments')	Is Not Null		Drop Table TNursesAppointments
If Object_ID ('TAppointments')			Is Not Null		Drop Table TAppointments
If Object_ID ('TPatients')				Is Not Null		Drop Table TPatients
If Object_ID ('TNurses')				Is Not Null		Drop Table TNurses
If Object_ID ('TDoctors')				Is Not Null		Drop Table TDoctors

--------------------------------------------------------------------------------------
-- Create Tables
--------------------------------------------------------------------------------------

Create Table TDoctors
(
	intDoctorID			Integer			Not Null
	,strFirstName		Varchar(25)		Not Null
	,strLastName		Varchar(25)		Not Null
	,strAddress			Varchar(25)		Not Null
	,strCity			Varchar(25)		Not Null
	,strState			Varchar(25)		Not Null
	,txtZIP				Varchar(25)		Not Null
	,strGender			Varchar(25)		Not Null
	,strRace			Varchar(25)		Not Null
	,dtmDatofHire		DateTime		Not Null
	,dtmTerminationDate	DateTime		
	,dtmBoardsDate		DateTime		Not Null
		,Constraint TDoctors_PK Primary Key (intDoctorID)
)


Create Table TNurses
(
	intNurseID			Integer			Not Null
	,strFirstName		Varchar(25)		Not Null
	,strLastName		Varchar(25)		Not Null
	,strAddress			Varchar(25)		Not Null
	,strCity			Varchar(25)		Not Null
	,strState			Varchar(25)		Not Null
	,txtZIP				Varchar(25)		Not Null
	,strGender			Varchar(25)		Not Null
	,strRace			Varchar(25)		Not Null
	,dtmDatofHire		DateTime		Not Null
	,dtmTerminationDate	DateTime		
	,dtmBoardsDate		DateTime		Not Null
		,Constraint TNurses_PK Primary Key (intNurseID)
)



Create Table TPatients
(
	intPatientID		Integer			Not Null
	,strFirstName		Varchar(25)		Not Null
	,strLastName		Varchar(25)		Not Null
	,strAddress			Varchar(25)		Not Null
	,strCity			Varchar(25)		Not Null
	,strState			Varchar(25)		Not Null
	,txtZIP				Varchar(25)		Not Null
	,strGender			Varchar(25)		Not Null
	,strRace			Varchar(25)		Not Null
	,dtmDOB				DateTime		Not Null
	,strInsurance		Varchar(25)		Not Null
	,strPhone			Varchar(25)		Not Null
	,strEmail			Varchar(25)		Not Null
	,strEmergencyContact Varchar(25)	Not Null
	,strEPhone			Varchar(25)		Not Null
	,strDiagnosis		Varchar(25)		Not Null
		,Constraint TPatients_PK Primary Key (intPatientID)
)


Create Table TAppointments
(
	intAppointmentID	Integer			Not Null
	,intDoctorID		Integer			Not Null
	,strReasonforVisit	Varchar(25)		Not Null
	,dtmDateofVisit		DateTime		Not Null
	,dtmFollowupDate	DateTime		Not Null
		,Constraint TAppointment_PK Primary Key (intAppointmentID)
)


Create Table TDoctorsPatients
(
	intDoctorPatientID	Integer			Not Null
	,intDoctorID		Integer			Not Null
	,intPatientID		Integer			Not Null
		,Constraint TDoctorsPatients_PK Primary Key (intDoctorPatientID)
)


Create Table TNursesPatients
(
	intNursesPatientsID		Integer		Not Null
	,intNurseID			Integer			Not Null
	,intPatientID		Integer			Not Null
		,Constraint TNursesPatients_PK Primary Key (intNursesPatientsID)
)


Create Table TPatientsAppointments
(
	intPatientAppointmentID	Integer		Not Null
	,intPatientID		Integer			Not Null
	,intAppointmentID	Integer			Not Null
		,Constraint TPatientsAppointments_PK Primary Key (intPatientAppointmentID)
)


Create Table TNursesAppointments
(
	intNursesAppointmentsID	Integer		Not Null
	,intNurseID			Integer			Not Null
	,intAppointmentID	Integer			Not Null
		,Constraint TNursesAppointments_PK Primary Key (intNursesAppointmentsID)
)


--------------------------------------------------------------------------------------
-- Establish Referential Integrity 
--------------------------------------------------------------------------------------

-- #	Child							Parent						Column
-- -	-----							------						---------
--1		TAppointments					TDoctors					intDoctorID
--2		TDoctorsPatients				TDoctors					intDoctorID		
--3		TDoctorsPatients				TPatients					intPatientID
--4		TNursesPatients					TPatients					intPatientID
--5		TNursesPatients					TNurses						intNurseID
--6		TPatientsAppointments			TPatients					intPatientID
--7		TPatientsAppointments			TAppointments				intAppointmentID
--8		TNursesAppointments				TNurses						intNurseID
--9		TNursesAppointments				TAppointments				intAppointmentID

--1
ALTER TABLE TAppointments ADD CONSTRAINT TAppointments_TDoctors_FK 
FOREIGN KEY ( intDoctorID ) REFERENCES TDoctors ( intDoctorID )

--2
ALTER TABLE TDoctorsPatients ADD CONSTRAINT TDoctorsPatients_TDoctors_FK 
FOREIGN KEY ( intDoctorID ) REFERENCES TDoctors ( intDoctorID )

--3
ALTER TABLE TDoctorsPatients ADD CONSTRAINT TDoctorsPatients_TPatients_FK 
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID )

--4
ALTER TABLE TNursesPatients ADD CONSTRAINT TNursesPatients_TPatients_FK 
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID )

--5
ALTER TABLE TNursesPatients ADD CONSTRAINT TNursesPatients_TNurses_FK 
FOREIGN KEY ( intNurseID ) REFERENCES TNurses ( intNurseID )

--6
ALTER TABLE TPatientsAppointments ADD CONSTRAINT TPatientsAppointments_TPatients_FK 
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID )

--7
ALTER TABLE TPatientsAppointments ADD CONSTRAINT TPatientsAppointments_TAppointments_FK
FOREIGN KEY ( intAppointmentID ) REFERENCES TAppointments ( intAppointmentID )


--8
ALTER TABLE TNursesAppointments ADD CONSTRAINT TNursesAppointments_TNurses_FK
FOREIGN KEY ( intNurseID ) REFERENCES TNurses ( intNurseID )


--9
ALTER TABLE TNursesAppointments ADD CONSTRAINT TNursesAppointments_TAppointments_FK
FOREIGN KEY ( intAppointmentID ) REFERENCES TAppointments ( intAppointmentID )


--------------------------------------------------------------------------------------
-- Insert Data
--------------------------------------------------------------------------------------

Insert Into TDoctors (intDoctorID, strLastName, strFirstName, strAddress, strCity, strState, txtZIP, strGender, strRace, dtmDatofHire, dtmTerminationDate, dtmBoardsDate)
Values				(1, 'Smith', 'Roger', '555 Oak St.', 'Cincinnati', 'OH', '45115', 'M', 'Black', '5/22/2000', ' ', '1/20/1990')
					,(2, 'Young', 'Rich', '132 Example Rd.', 'Columbus', 'OH', '45103', 'M', 'White', '12/5/2007', '12/10/2007', '5/5/2005')
					,(3, 'Williams', 'Samantha', '1407 Glenview Rd.', 'Florence', 'AL', '35630', 'F', 'White', '9/28/1998', ' ', '7/15/1992') 
					,(4, 'Broerman', 'Toni', '4507 Forrest Ave.', 'Bethel', 'OH', '45100', 'F', 'Hispanic', '4/20/2017', ' ', '11/11/2011')
					,(5, 'Gordon', 'Jim', '5050 2nd St.', 'Gotham', 'MA', '55555', 'M', 'Latino', '10/31/2002', '8/2/2017', '1/1/2001') 


Insert Into TNurses (intNurseID, strLastName, strFirstName, strAddress, strCity, strState, txtZIP, strGender, strRace, dtmDatofHire, dtmTerminationDate, dtmBoardsDate)
Values				(1, 'White', 'Bob', '6458 Apartment Ln.', 'Nashville', 'TN', '78487', 'M', 'Hispanic', '10/5/2018', ' ', '10/6/2018')
					,(2, 'Moody', 'Jennifer', '5478 Avenue Ave.', 'New York City', 'NY', '45114', 'F', 'White', '12/25/2010', '12/25/2016', '11/11/2012')
					,(3, 'Groch', 'Kevin', '1234 Road Rd.', 'Birmingham', 'AL', '35689', 'M', 'White', '07/18/1999', '11/1/2013', '8/16/2002')
					,(4, 'James', 'Jones', '321 Elm St.', 'Cincinnati', 'Oh', '45201', 'M', 'Latino', '10/5/2018', ' ', '5/2/2016')
					,(5, 'Lan', 'Kim', '44561 Oak Ave.', 'Milford', 'Oh', '45246', 'M', 'Asian', '8/2/2011', '2/2/2014', '6/5/2004')


Insert Into TPatients (intPatientID, strLastName, strFirstName, strAddress, strCity, strState, txtZIP, strGender, strRace, dtmDOB, strInsurance, strPhone, strEmail, strEmergencyContact, strEPhone, strDiagnosis)
Values					(1, 'Evans', 'Bobby', '654 Elmhurst Rd.', 'Florence', 'AL', '35633', 'M', 'White', '5/5/2015', 'Emergency HealthCare', '256-587-6126', 'bobby@gmail.com', 'Bill', '256-318-1611', 'Flu')
						,(2, 'Hernandez', 'Jose', '1569 Windisch Rd.', 'West Chester', 'Oh', '45069', 'M', 'Hispanic', '7/20/2000', 'Personal Health', '513-124-9785', 'Jose@gmail.com', 'Henry', '513-664-6666', 'Healthy')
						,(3, 'Smith', 'Sally', '987 Main St.', 'Norwood', 'Oh', '45218', 'F', 'White', '12/25/2012', 'WorldWide Health', '513-541-2231', 'sally@gmail.com',  'Dan', '513-555-5555', 'Bronchitis') 
						,(4, 'Obama', 'Barrack', '1337 Happy Rd.', 'West Chester', 'Oh', '45069', 'M', 'Black', '11/11/2011', 'Government Health', '111-111-1111', 'barrack@gmail.com', 'Heather', '222-222-2222', 'Healthy')
						,(5, 'Parsons', 'Riley', '987 Main St.', 'Norwood', 'Oh', '45218', 'F', 'White', '9/30/2002', 'Health Shield', '321-654-9870', 'riley@gmail.com', ' Gary', '987-654-3210', 'Healthy')


Insert Into TAppointments (intAppointmentID, intDoctorID, strReasonforVisit, dtmDateofVisit, dtmFollowupDate)
Values					  (1, 1, 'Chest Pain', '8/5/2016', '9/5/2016')
						 ,(2, 2, 'Check Up', '3/17/2015', '5/20/2015')
						 ,(3, 3, 'Headache', '1/1/2018', '2/1/2018')
						 ,(4, 4, 'Back Pain', '6/30/2017', '8/1/2017')
						 ,(5, 5, 'Check Up', '10/5/2018', '11/10/2018')


Insert Into TDoctorsPatients (intDoctorPatientID, intDoctorID, intPatientID)
Values						(1, 3, 1)
							,(2, 2, 5)
							,(3, 5, 4)
							,(4, 1, 2)
							,(5, 4, 3)


Insert Into TNursesPatients (intNursesPatientsID, intNurseID, intPatientID)
Values						(1, 2, 1)
							,(2, 5, 2)
							,(3, 3, 3)
							,(4, 1, 5)
							,(5, 4, 4)


Insert Into TPatientsAppointments (intPatientAppointmentID, intPatientID, intAppointmentID)
Values							(1, 1, 3)
								,(2, 2, 5)
								,(3, 3, 1)
								,(4, 4, 2)
								,(5, 5, 4)
				

Insert Into TNursesAppointments (intNursesAppointmentsID, intNurseID, intAppointmentID)
Values							(1, 1, 5)
								,(2, 2, 1)
								,(3, 3, 2)
								,(4, 4, 3)
								,(5, 5, 4)


--------------------------------------------------------------------------------------
--Select Data
--------------------------------------------------------------------------------------

Select intPatientID, strLastName, strFirstName, strAddress, strCity, strState, txtZIP, strGender, strRace, dtmDOB, strInsurance, strPhone, strEmail, strEmergencyContact, strEPhone, strDiagnosis
From	TPatients


Select intPatientID, strLastName, strFirstName, strAddress, strCity, strState, txtZIP, strGender, strRace, dtmDOB, strInsurance, strPhone, strEmail, strEmergencyContact, strEPhone, strDiagnosis
From	TPatients
Where	txtZIP = '45069'


Select strLastName as PatientFirstName, strFirstName as PatientLastName, dtmDateofVisit
From	TAppointments	as TA
		,TPatients		as TP
Where	TA.intAppointmentID = TP.intPatientID
	and  dtmDateofVisit <= '1/1/2018'
Order by	dtmDateofVisit
 

Select	intPatientID, TP.strFirstName as PatientFirstName, TP.strLastName  as PatientLastName, intNurseID, TN.strFirstName as NurseFirstName, TN.strLastName as NurseLastName 
From	TNurses		as	TN
		,TPatients	as	TP
Where	intNurseID = intPatientID
	and intNurseID = '4'


Select	intPatientID, TP.strFirstName as PatientFirstName, TP.strLastName as PatientLastName, intDoctorID, TD.strFirstName as DoctorFirstName, TD.strLastName as DoctorLastName
From	TPatients	as	TP
		,TDoctors	as	TD
Where	intDoctorID = intPatientID
	and intDoctorID = '4'


--------------------------------------------------------------------------------------
--Update Data
--------------------------------------------------------------------------------------

Select * 
From TPatients

Update	TPatients
Set		strEmergencyContact = 'Sally'
		,strEPhone = '555-555-8795'
Where	intPatientID = '2'

Select * 
From TPatients


--------------------------------------------------------------------------------------
--Delete Data
--------------------------------------------------------------------------------------
Select TPA.*, TA.*
From	TPatientsAppointments as TPA
		,TAppointments	as	TA
Where	TPA.intPatientAppointmentID = TA.intAppointmentID

Delete From TPatientsAppointments
Where		intAppointmentID = '2'
		
Select TPA.*, TA.*
From	TPatientsAppointments as TPA
		,TAppointments	as	TA
Where	TPA.intPatientAppointmentID = TA.intAppointmentID


