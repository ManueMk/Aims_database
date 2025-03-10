

-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                           PostgreSQL
--                        (9/3/2025 17:57:40)
-- -----------------------------------------------------------------------------
--      Nom de la base : sqlproject
--      Projet : Accueil Win'Design version 7
--      Auteur : mk
--      Date de dernière modification : 9/3/2025 17:57:28
-- -----------------------------------------------------------------------------

drop database if exists DbmProject;
-- -----------------------------------------------------------------------------
--       CREATION DE LA BASE 
-- -----------------------------------------------------------------------------

CREATE DATABASE DbmProject;
--\c DbmProject;  -- Connect to the database after creation

-- -----------------------------------------------------------------------------
--       TABLE : ACCOMODATION
-- -----------------------------------------------------------------------------

CREATE TABLE ACCOMMODATION
   (
    ACCOMMODATION_ID varchar(100) NOT NULL,      
    ACCOMMODATION_PLACE varchar(100) NOT NULL,  
    ROOM_NUMBER varchar(8) NULL,               
    CAPACITY smallint NULL,                     
    STATUS varchar(100) NOT NULL,                
    PRIMARY KEY (ACCOMMODATION_ID)              
   );


-- -----------------------------------------------------------------------------
--       TABLE : PERSON
-- -----------------------------------------------------------------------------

CREATE TABLE PERSON
   (
    PERSON_ID varchar(100) NOT NULL  ,
    ACCOMMODATION_ID varchar(100) NULL  , 
    FIRSTNAME varchar(100)  NULL  ,
    LASTNAME varchar(100)  NOT NULL  ,
    DATE_BIRTH date NOT NULL  ,
    CREDENTIAL_ID varchar(100)  NOT NULL  ,
    COUNTRY varchar(100) NOT NULL  ,
    GENDER varchar(1) NOT NULL  ,
    ADDRESS varchar(100) NULL  ,
    EMERGENCY_CONTACT varchar(100)  NOT NULL  ,
    START_DATE date NULL  ,
    END_DATE date NULL
,   CONSTRAINT PK_PERSON PRIMARY KEY (PERSON_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PERSON
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PERSON_ACCOMODATION
     ON PERSON (ACCOMMODATION_ID);


-- -----------------------------------------------------------------------------
--       TABLE : STAFF
-- -----------------------------------------------------------------------------

CREATE TABLE STAFF
   (
    STAFF_ID varchar(100) NOT NULL  ,
    PERSON_ID varchar(100) NOT NULL  ,
    POSITION_STAFF varchar(100) NULL  ,
    EMPLOYMENT_TYPE varchar(100) NULL  ,
    SALARY int4 NULL  ,
    START_DATE date NOT NULL  ,
    END_DATE date NULL
,   CONSTRAINT PK_STAFF PRIMARY KEY (STAFF_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE STAFF
-- -----------------------------------------------------------------------------

CREATE UNIQUE INDEX I_FK_STAFF_PERSON
     ON STAFF (PERSON_ID);


-- -----------------------------------------------------------------------------
--       TABLE : TUTOR
-- -----------------------------------------------------------------------------

CREATE TABLE TUTOR
   (
    TUTOR_ID varchar(100)  NOT NULL  ,
    PERSON_ID varchar(100) not NULL  ,
    COURSE_ID varchar(100)  not NULL  ,
    BACKGROUND varchar(100) NOT NULL  ,
    ACADEMIC_YEAR date NOT NULL
,   CONSTRAINT PK_TUTOR PRIMARY KEY (TUTOR_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE TUTOR
-- -----------------------------------------------------------------------------

CREATE UNIQUE INDEX I_FK_TUTOR_PERSON
     ON TUTOR (PERSON_ID);


CREATE  INDEX I_FK_TUTOR_COURSES
     ON TUTOR (COURSE_ID);


-- -----------------------------------------------------------------------------
--       TABLE : STUDENT
-- -----------------------------------------------------------------------------

CREATE TABLE STUDENT
   (
    STUDENT_ID varchar(100)  NOT NULL  ,
    PERSON_ID varchar(100) NOT NULL  ,
    PROGRAM varchar(100) NOT NULL  ,
    FUNDING_TYPE varchar(100) NULL  ,
    STATUS varchar(100)  NULL  ,
    DATE_REGISTRATION date NOT NULL  ,
    ACADEMIC_YEAR date NOT NULL
,   CONSTRAINT PK_STUDENT PRIMARY KEY (STUDENT_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE STUDENT
-- -----------------------------------------------------------------------------

CREATE UNIQUE INDEX I_FK_STUDENT_PERSON
     ON STUDENT (PERSON_ID);


-- -----------------------------------------------------------------------------
--       TABLE : LECTURER
-- -----------------------------------------------------------------------------

CREATE TABLE LECTURER
   (
    LECTURER_ID varchar(100)  NOT NULL  ,
    PERSON_ID varchar(100) NOT NULL  ,
    HOME_INSTITUTION varchar(100) NULL  ,
    FIELD varchar(100) NOT NULL  ,
    BIOGRAPHY text NULL  ,
    IS_VISITING boolean NULL  ,
    START_VISIT date NULL  ,
    END_VISIT date NULL
,   CONSTRAINT PK_LECTURER PRIMARY KEY (LECTURER_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE LECTURER
-- -----------------------------------------------------------------------------

CREATE UNIQUE INDEX I_FK_LECTURER_PERSON
     ON LECTURER (PERSON_ID);


-- -----------------------------------------------------------------------------
--       TABLE : BLOCK
-- -----------------------------------------------------------------------------

CREATE TABLE BLOCK
   (
    BLOCK_ID varchar(100) NOT NULL  ,
    PHASE varchar(100) NOT NULL  ,
    START_DATE date NOT NULL  ,
    END_DATE date NOT NULL  ,
    ACADEMIC_YEAR varchar(100) NULL
,   CONSTRAINT PK_BLOCK PRIMARY KEY (BLOCK_ID)
   );

-- -----------------------------------------------------------------------------
--       TABLE : COURSES
-- -----------------------------------------------------------------------------

CREATE TABLE COURSES
   (
    COURSE_ID varchar(100) NOT NULL  ,
    BLOCK_ID varchar(100) NULL  ,
    COURSE_NAME varchar(100) NOT NULL  ,
    DESCRIPTION text NULL
,   CONSTRAINT PK_COURSES PRIMARY KEY (COURSE_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE COURSES
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_COURSES_BLOCK
     ON COURSES (BLOCK_ID);


-- -----------------------------------------------------------------------------
--       TABLE : TAKE
-- -----------------------------------------------------------------------------

CREATE TABLE TAKE
   (
    STUDENT_ID varchar(100)  NOT NULL  ,
    COURSE_ID varchar(100) NOT NULL  ,
    GRADE varchar(100)  NULL
,   CONSTRAINT PK_TAKE PRIMARY KEY (STUDENT_ID, COURSE_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE TAKE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_TAKE_STUDENT
     ON TAKE (STUDENT_ID);


CREATE  INDEX I_FK_TAKE_COURSES
     ON TAKE (COURSE_ID);


-- -----------------------------------------------------------------------------
--       TABLE : TEACH
-- -----------------------------------------------------------------------------

CREATE TABLE TEACH
   (
    LECTURER_ID varchar(100)  NOT NULL  ,
    COURSE_ID varchar(100) NOT NULL
,   CONSTRAINT PK_TEACH PRIMARY KEY (LECTURER_ID, COURSE_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE TEACH
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_TEACH_LECTURER
     ON TEACH (LECTURER_ID);


CREATE  INDEX I_FK_TEACH_COURSES
     ON TEACH (COURSE_ID);


-- -----------------------------------------------------------------------------
--       TABLE : MEAL_PLAN
-- -----------------------------------------------------------------------------

CREATE TABLE MEAL_PLAN
   (
    MEAL_ID varchar(100) NOT NULL  ,
    DESCRIPTION text NULL  ,
    COST_MEAL money NULL  ,
    DATE_MEAL date NULL
,   CONSTRAINT PK_MEAL_PLAN PRIMARY KEY (MEAL_ID)
   );

-- -----------------------------------------------------------------------------
--       TABLE : IS_EATEN
-- -----------------------------------------------------------------------------

CREATE TABLE IS_EATEN
   (
    MEAL_ID varchar(100) NOT NULL  ,
    PERSON_ID varchar(100) NOT NULL
,   CONSTRAINT PK_IS_EATEN PRIMARY KEY (MEAL_ID, PERSON_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE IS_EATEN
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_IS_EATEN_MEAL_PLAN
     ON IS_EATEN (MEAL_ID);


CREATE  INDEX I_FK_IS_EATEN_PERSON
     ON IS_EATEN (PERSON_ID);


-- -----------------------------------------------------------------------------
--       TABLE : RESEARCH_PROJECT
-- -----------------------------------------------------------------------------

CREATE TABLE RESEARCH_PROJECT
   (
    PROJECT_ID varchar(100)  NOT NULL  ,
    STUDENT_ID varchar(100)  NOT NULL  ,
    LECTURER_ID varchar(100)  NOT NULL  ,
    TUTOR_ID varchar(100)  NOT NULL  ,
    TITLE text NULL  ,
    DESCRIPTION text NULL  ,
    START_DATE date NULL  ,
    END_DATE date NULL
,   CONSTRAINT PK_RESEARCH_PROJECT PRIMARY KEY (PROJECT_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE RESEARCH_PROJECT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_RESEARCH_PROJECT_STUDENT
     ON RESEARCH_PROJECT (STUDENT_ID);


CREATE  INDEX I_FK_RESEARCH_PROJECT_LECTURER
     ON RESEARCH_PROJECT (LECTURER_ID);


CREATE  INDEX I_FK_RESEARCH_PROJECT_TUTOR
     ON RESEARCH_PROJECT (TUTOR_ID);


-- -----------------------------------------------------------------------------
--       TABLE : FINANCIAL_TRANSACTION
-- -----------------------------------------------------------------------------

CREATE TABLE FINANCIAL_TRANSACTION
   (
    TRANSACTION_ID varchar(100) NOT NULL  ,
    TRANSACTION_DATE date NOT NULL  ,
    AMOUNT money NOT NULL  ,
    RECIPIENT_ID varchar(100) NULL  ,
    DESCRIPTION text NULL  ,
    APPROVED_BY varchar(100) NULL
,   CONSTRAINT PK_FINANCIAL_TRANSACTION PRIMARY KEY (TRANSACTION_ID)
   );

-- -----------------------------------------------------------------------------
--       TABLE : OUTREACH_PROGRAM
-- -----------------------------------------------------------------------------

CREATE TABLE OUTREACH_PROGRAM
   (
    OUTREACH_ID varchar(100)  NOT NULL  ,
    OUTREACH_NAME varchar(100) NULL  ,
    DESCRIPTION text NULL
,   CONSTRAINT PK_OUTREACH_PROGRAM PRIMARY KEY (OUTREACH_ID)
   );

-- -----------------------------------------------------------------------------
--       TABLE : EVENTS
-- -----------------------------------------------------------------------------

CREATE TABLE EVENTS
   (
    EVENT_ID varchar(100) NOT NULL  ,
    EVENT_NAME varchar(100) NOT NULL  ,
    EVENT_TYPE varchar(100) NULL  ,
    LOCATION varchar(100) NOT NULL  ,
    DESCRIPTION text NULL  ,
    START_DATE timestamp NULL  ,
    END_DATE timestamp NULL
,   CONSTRAINT PK_EVENTS PRIMARY KEY (EVENT_ID)
   );

-- -----------------------------------------------------------------------------
--       TABLE : PUBLICATION
-- -----------------------------------------------------------------------------

CREATE TABLE PUBLICATION
   (
    PUBLICATION_ID varchar(100)  NOT NULL  ,
    TITLE_PUBLI text NOT NULL  ,
    ABSTRACT text NULL  ,
    PUBLICATION_DATE date NULL  ,
    DOI text NULL  ,
    JOURNAL text NULL  ,
    TYPE varchar(100) NULL
,   CONSTRAINT PK_PUBLICATION PRIMARY KEY (PUBLICATION_ID)
   );

-- -----------------------------------------------------------------------------
--       TABLE : ALUMNI
-- -----------------------------------------------------------------------------

CREATE TABLE ALUMNI
   (
    ALUMNI_ID varchar(100) NOT NULL  ,
    PERSON_ID varchar(100) NULL  ,
    GRADUATION_DATE date NOT NULL  ,
    CURRENT_OCCUPATION varchar(100) NULL  ,
    CONTACT varchar(100) NULL
,   CONSTRAINT PK_ALUMNI PRIMARY KEY (ALUMNI_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ALUMNI
-- -----------------------------------------------------------------------------

CREATE UNIQUE INDEX I_FK_ALUMNI_PERSON
     ON ALUMNI (PERSON_ID);


-- -----------------------------------------------------------------------------
--       TABLE : IS_FINANCED
-- -----------------------------------------------------------------------------

CREATE TABLE IS_FINANCED
   (
    EVENT_ID varchar(100) NOT NULL  ,
    GRANT_ID_1 varchar(100)  NOT NULL
,   CONSTRAINT PK_IS_FINANCED PRIMARY KEY (EVENT_ID, GRANT_ID_1)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE IS_FINANCED
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_IS_FINANCED_EVENTS
     ON IS_FINANCED (EVENT_ID);


CREATE  INDEX I_FK_IS_FINANCED_GRANTS
     ON IS_FINANCED (GRANT_ID_1);


-- -----------------------------------------------------------------------------
--       TABLE : IS_GRANT
-- -----------------------------------------------------------------------------

CREATE TABLE IS_GRANT
   (
    PROJECT_ID varchar(100)  NOT NULL  ,
    GRANT_ID_1 varchar(100)  not NULL
,   CONSTRAINT PK_IS_GRANT PRIMARY KEY (PROJECT_ID, GRANT_ID_1)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE IS_GRANT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_IS_GRANT_RESEARCH_PROJECT
     ON IS_GRANT (PROJECT_ID);


CREATE  INDEX I_FK_IS_GRANT_GRANTS
     ON IS_GRANT (GRANT_ID_1);


-- -----------------------------------------------------------------------------
--       TABLE : HAVE_GRANT
-- -----------------------------------------------------------------------------

CREATE TABLE HAVE_GRANT
   (
    OUTREACH_ID varchar(100)  NOT NULL  ,
    GRANT_ID_1 varchar(100)  NOT NULL
,   CONSTRAINT PK_HAVE_GRANT PRIMARY KEY (OUTREACH_ID, GRANT_ID_1)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE HAVE_GRANT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_HAVE_GRANT_OUTREACH_PROGR
     ON HAVE_GRANT (OUTREACH_ID);


CREATE  INDEX I_FK_HAVE_GRANT_GRANTS
     ON HAVE_GRANT (GRANT_ID_1);


-- -----------------------------------------------------------------------------
--       TABLE : CAN_PARTICIPATE
-- -----------------------------------------------------------------------------

CREATE TABLE CAN_PARTICIPATE
   (
    PERSON_ID varchar(100) NOT NULL  ,
    EVENT_ID varchar(100) NOT NULL
,   CONSTRAINT PK_CAN_PARTICIPATE PRIMARY KEY (PERSON_ID, EVENT_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CAN_PARTICIPATE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CAN_PARTICIPATE_PERSON
     ON CAN_PARTICIPATE (PERSON_ID);


CREATE  INDEX I_FK_CAN_PARTICIPATE_EVENTS
     ON CAN_PARTICIPATE (EVENT_ID);


-- -----------------------------------------------------------------------------
--       TABLE : PARTICIPATE
-- -----------------------------------------------------------------------------

CREATE TABLE PARTICIPATE
   (
    PERSON_ID varchar(100) NOT NULL  ,
    OUTREACH_ID varchar(100)  NOT NULL
,   CONSTRAINT PK_PARTICIPATE PRIMARY KEY (PERSON_ID, OUTREACH_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PARTICIPATE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PARTICIPATE_PERSON
     ON PARTICIPATE (PERSON_ID);


CREATE  INDEX I_FK_PARTICIPATE_OUTREACH_PROG
     ON PARTICIPATE (OUTREACH_ID);


-- -----------------------------------------------------------------------------
--       TABLE : IS_AUTHOR
-- -----------------------------------------------------------------------------

CREATE TABLE IS_AUTHOR
   (
    PUBLICATION_ID varchar(100)  NOT NULL  ,
    PERSON_ID varchar(100) NOT NULL  ,
    AUTHOR_ORDER smallint NULL  -- Changed to smallint
,   CONSTRAINT PK_IS_AUTHOR PRIMARY KEY (PUBLICATION_ID, PERSON_ID)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE IS_AUTHOR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_IS_AUTHOR_PUBLICATION
     ON IS_AUTHOR (PUBLICATION_ID);


CREATE  INDEX I_FK_IS_AUTHOR_PERSON
     ON IS_AUTHOR (PERSON_ID);


-- -----------------------------------------------------------------------------
--       TABLE : GRANTS
-- -----------------------------------------------------------------------------

CREATE TABLE GRANTS
   (
    GRANT_ID varchar(100)  NOT NULL  ,
    GRANT_ID_1 varchar(100)  ,
    TITLE varchar(100) NULL  ,
    DESCRIPTION text NULL  ,
    FUNDINGAGENCY varchar(100) NULL  ,
    AMOUNT money NOT NULL  ,
    STATUS varchar(100)  NOT NULL
,   CONSTRAINT PK_GRANTS PRIMARY KEY (GRANT_ID)
   );


-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE
-- -----------------------------------------------------------------------------


ALTER TABLE PERSON ADD 
     CONSTRAINT FK_PERSON_ACCOMMODATION
          FOREIGN KEY (ACCOMMODATION_ID)
               REFERENCES ACCOMMODATION (ACCOMMODATION_ID);

ALTER TABLE STAFF ADD 
     CONSTRAINT FK_STAFF_PERSON
          FOREIGN KEY (PERSON_ID)
               REFERENCES PERSON (PERSON_ID);

ALTER TABLE TUTOR ADD 
     CONSTRAINT FK_TUTOR_PERSON
          FOREIGN KEY (PERSON_ID)
               REFERENCES PERSON (PERSON_ID);

ALTER TABLE TUTOR ADD 
     CONSTRAINT FK_TUTOR_COURSES
          FOREIGN KEY (COURSE_ID)
               REFERENCES COURSES (COURSE_ID);

ALTER TABLE STUDENT ADD 
     CONSTRAINT FK_STUDENT_PERSON
          FOREIGN KEY (PERSON_ID)
               REFERENCES PERSON (PERSON_ID);

ALTER TABLE LECTURER ADD 
     CONSTRAINT FK_LECTURER_PERSON
          FOREIGN KEY (PERSON_ID)
               REFERENCES PERSON (PERSON_ID);

ALTER TABLE COURSES ADD 
     CONSTRAINT FK_COURSES_BLOCK
          FOREIGN KEY (BLOCK_ID)
               REFERENCES BLOCK (BLOCK_ID);

ALTER TABLE TAKE ADD 
     CONSTRAINT FK_TAKE_STUDENT
          FOREIGN KEY (STUDENT_ID)
               REFERENCES STUDENT (STUDENT_ID);

ALTER TABLE TAKE ADD 
     CONSTRAINT FK_TAKE_COURSES
          FOREIGN KEY (COURSE_ID)
               REFERENCES COURSES (COURSE_ID);

ALTER TABLE TEACH ADD 
     CONSTRAINT FK_TEACH_LECTURER
          FOREIGN KEY (LECTURER_ID)
               REFERENCES LECTURER (LECTURER_ID);

ALTER TABLE TEACH ADD 
     CONSTRAINT FK_TEACH_COURSES
          FOREIGN KEY (COURSE_ID)
               REFERENCES COURSES (COURSE_ID);

ALTER TABLE IS_EATEN ADD 
     CONSTRAINT FK_IS_EATEN_MEAL_PLAN
          FOREIGN KEY (MEAL_ID)
               REFERENCES MEAL_PLAN (MEAL_ID);

ALTER TABLE IS_EATEN ADD 
     CONSTRAINT FK_IS_EATEN_PERSON
          FOREIGN KEY (PERSON_ID)
               REFERENCES PERSON (PERSON_ID);

ALTER TABLE RESEARCH_PROJECT ADD 
     CONSTRAINT FK_RESEARCH_PROJECT_STUDENT
          FOREIGN KEY (STUDENT_ID)
               REFERENCES STUDENT (STUDENT_ID);

ALTER TABLE RESEARCH_PROJECT ADD 
     CONSTRAINT FK_RESEARCH_PROJECT_LECTURER
          FOREIGN KEY (LECTURER_ID)
               REFERENCES LECTURER (LECTURER_ID);

ALTER TABLE RESEARCH_PROJECT ADD 
     CONSTRAINT FK_RESEARCH_PROJECT_TUTOR
          FOREIGN KEY (TUTOR_ID)
               REFERENCES TUTOR (TUTOR_ID);

ALTER TABLE ALUMNI ADD 
     CONSTRAINT FK_ALUMNI_PERSON
          FOREIGN KEY (PERSON_ID)
               REFERENCES PERSON (PERSON_ID);

ALTER TABLE IS_FINANCED ADD 
     CONSTRAINT FK_IS_FINANCED_EVENTS
          FOREIGN KEY (EVENT_ID)
               REFERENCES EVENTS (EVENT_ID);

ALTER TABLE IS_FINANCED ADD 
     CONSTRAINT FK_IS_FINANCED_GRANTS
          FOREIGN KEY (GRANT_ID_1)
               REFERENCES GRANTS (GRANT_ID);

ALTER TABLE IS_GRANT ADD 
     CONSTRAINT FK_IS_GRANT_RESEARCH_PROJECT
          FOREIGN KEY (PROJECT_ID)
               REFERENCES RESEARCH_PROJECT (PROJECT_ID);

ALTER TABLE IS_GRANT ADD 
     CONSTRAINT FK_IS_GRANT_GRANTS
          FOREIGN KEY (GRANT_ID_1)
               REFERENCES GRANTS (GRANT_ID);

ALTER TABLE HAVE_GRANT ADD 
     CONSTRAINT FK_HAVE_GRANT_OUTREACH_PROGRAM
          FOREIGN KEY (OUTREACH_ID)
               REFERENCES OUTREACH_PROGRAM (OUTREACH_ID);

ALTER TABLE HAVE_GRANT ADD 
     CONSTRAINT FK_HAVE_GRANT_GRANTS
          FOREIGN KEY (GRANT_ID_1)
               REFERENCES GRANTS (GRANT_ID);

ALTER TABLE CAN_PARTICIPATE ADD 
     CONSTRAINT FK_CAN_PARTICIPATE_PERSON
          FOREIGN KEY (PERSON_ID)
               REFERENCES PERSON (PERSON_ID);

ALTER TABLE CAN_PARTICIPATE ADD 
     CONSTRAINT FK_CAN_PARTICIPATE_EVENTS
          FOREIGN KEY (EVENT_ID)
               REFERENCES EVENTS (EVENT_ID);

ALTER TABLE PARTICIPATE ADD 
     CONSTRAINT FK_PARTICIPATE_PERSON
          FOREIGN KEY (PERSON_ID)
               REFERENCES PERSON (PERSON_ID);

ALTER TABLE PARTICIPATE ADD 
     CONSTRAINT FK_PARTICIPATE_OUTREACH_PROGRAM
          FOREIGN KEY (OUTREACH_ID)
               REFERENCES OUTREACH_PROGRAM (OUTREACH_ID);

ALTER TABLE IS_AUTHOR ADD 
     CONSTRAINT FK_IS_AUTHOR_PUBLICATION
          FOREIGN KEY (PUBLICATION_ID)
               REFERENCES PUBLICATION (PUBLICATION_ID);

ALTER TABLE IS_AUTHOR ADD 
     CONSTRAINT FK_IS_AUTHOR_PERSON
          FOREIGN KEY (PERSON_ID)
               REFERENCES PERSON (PERSON_ID);


-- -----------------------------------------------------------------------------
--                END OF CREATION
-- -----------------------------------------------------------------------------

              
 -- Ensure you are connected to the sqlproject database
             
              
-- Ensure you are connected to the sqlproject database
              
              -- Ensure you are connected to the sqlproject database

-- TABLE: ACCOMODATION
INSERT INTO ACCOMMODATION (ACCOMMODATION_ID, ACCOMMODATION_PLACE, ROOM_NUMBER, CAPACITY, STATUS)
VALUES
('A001', 'Dorm A', '101', 2, 'Occupied'),
('A002', 'Dorm A', '102', 2, 'Occupied'),
('A003', 'Dorm B', '201', 4, 'Occupied'),
('A004', 'Dorm B', '202', 4, 'Occupied'),
('A005', 'Dorm C', '301', 2, 'Occupied'),
('A006', 'Dorm C', '302', 2, 'Vacant'),
('A007', 'Dorm D', '401', 4, 'Vacant'),
('A008', 'Dorm D', '402', 4, 'Occupied'),
('A009', 'Apartment 1', 'A1', 1, 'Occupied'),
('A010', 'Apartment 2', 'A2', 1, 'Vacant'),
('A011', 'Apartment 3', 'A3', 1, 'Occupied'),
('A012', 'Apartment 4', 'A4', 1, 'Vacant'),
('A013', 'Apartment 5', 'A5', 1, 'Occupied'),
('A014', 'Apartment 6', 'A6', 1, 'Vacant'),
('A015', 'Apartment 7', 'A7', 1, 'Occupied');

-- TABLE: PERSON
INSERT INTO PERSON (PERSON_ID, ACCOMMODATION_ID, FIRSTNAME, LASTNAME, DATE_BIRTH, CREDENTIAL_ID, COUNTRY, GENDER, ADDRESS, EMERGENCY_CONTACT, START_DATE, END_DATE)
VALUES
('P001', 'A001', 'Alice', 'Smith', '1995-03-15', 'C001', 'USA', 'F', '123 Main St', '555-1234', '2021-09-01', NULL),
('P002', 'A002', 'Bob', 'Johnson', '1990-10-20', 'C002', 'Canada', 'M', '456 Oak Ave', '555-5678', '2020-01-15', NULL),
('P003', 'A003', 'Charlie', 'Brown', '1988-07-04', 'C003', 'UK', 'M', '789 Pine Ln', '555-9012', '2019-05-01', NULL),
('P004', 'A004', 'David', 'Lee', '1992-12-01', 'C004', 'Australia', 'M', '101 Elm Rd', '555-3456', '2022-02-28', NULL),
('P005', 'A005', 'Eve', 'Davis', '1997-05-10', 'C005', 'Germany', 'F', '222 Maple Dr', '555-7890', '2023-08-15', NULL),
('P006', NULL, 'Grace', 'Wilson', '1985-09-22', 'C006', 'France', 'F', '333 Cherry St', '555-2345', NULL, NULL),
('P007', NULL, 'Henry', 'Garcia', '1993-06-08', 'C007', 'Spain', 'M', '444 Walnut Ave', '555-6789', NULL, NULL),
('P008', NULL, 'Ivy', 'Rodriguez', '1991-11-18', 'C008', 'Italy', 'F', '555 Birch Ln', '555-0123', NULL, NULL),
('P009', NULL, 'Jack', 'Williams', '1987-04-25', 'C009', 'Japan', 'M', '666 Cedar Rd', '555-4567', NULL, NULL),
('P010', NULL, 'Karen', 'Jones', '1996-01-03', 'C010', 'China', 'F', '777 Oak Dr', '555-8901', NULL, NULL),
('P011', NULL, 'Liam', 'Martinez', '1994-08-12', 'C011', 'Brazil', 'M', '888 Pine St', '555-1234', NULL, NULL),
('P012', NULL, 'Mia', 'Anderson', '1989-02-14', 'C012', 'Mexico', 'F', '999 Elm Ave', '555-5678', NULL, NULL),
('P013', NULL, 'Noah', 'Taylor', '1998-07-30', 'C013', 'India', 'M', '111 Maple Ln', '555-9012', NULL, NULL),
('P014', NULL, 'Olivia', 'Thomas', '1992-09-05', 'C014', 'South Africa', 'F', '222 Cherry Rd', '555-3456', NULL, NULL),
('P015', NULL, 'Peter', 'Moore', '1990-03-21', 'C015', 'Nigeria', 'M', '333 Walnut St', '555-7890', NULL, NULL),
('P016', 'A002', 'Sofia', 'Brown', '1993-11-10', 'C016', 'Ireland', 'F', '444 Oak Ave', '555-2468', '2022-03-01', NULL),
('P017', 'A003', 'Tom', 'Green', '1991-04-05', 'C017', 'New Zealand', 'M', '555 Pine Ln', '555-3690', '2021-07-15', NULL);

-- TABLE: ALUMNI
INSERT INTO ALUMNI (ALUMNI_ID, PERSON_ID, GRADUATION_DATE, CURRENT_OCCUPATION, CONTACT)
VALUES
('AL001', 'P001', '2017-05-20', 'Software Engineer at Google', 'alice.smith@email.com'),
('AL002', 'P002', '2012-05-20', 'Data Scientist at Facebook', 'bob.johnson@email.com'),
('AL003', 'P003', '2010-05-20', 'Professor at Cambridge', 'charlie.brown@email.com'),
('AL004', 'P004', '2014-05-20', 'Researcher at CSIRO', 'david.lee@email.com'),
('AL005', 'P005', '2019-05-20', 'Doctor at Charite', 'eve.davis@email.com'),
('AL006', NULL, '2020-05-20', 'Project Manager at Microsoft', 'grace.wilson@email.com'),
('AL007', NULL, '2015-05-20', 'Lawyer at a private practice', 'henry.garcia@email.com'),
('AL008', NULL, '2013-05-20', 'Consultant at McKinsey', 'ivy.rodriguez@email.com'),
('AL009', NULL, '2009-05-20', 'Economist at World Bank', 'jack.williams@email.com'),
('AL010', NULL, '2018-05-20', 'Psychologist at a private practice', 'karen.jones@email.com'),
('AL011', NULL, '2016-05-20', 'Entrepreneur (Tech Startup)', 'liam.martinez@email.com'),
('AL012', NULL, '2011-05-20', 'Politician', 'mia.anderson@email.com'),
('AL013', NULL, '2017-05-20', 'Geographer at a research institute', 'noah.taylor@email.com'),
('AL014', NULL, '2012-05-20', 'Environmental Scientist at the EPA', 'olivia.thomas@email.com'),
('AL015', NULL, '2010-05-20', 'Art Curator at a museum', 'peter.moore@email.com'),
('AL016', NULL, '2019-05-20', 'Software Developer at Amazon', 'emma.clark@email.com'),
('AL017', NULL, '2014-05-20', 'Data Analyst at Netflix', 'ryan.hall@email.com');

-- TABLE: STAFF
INSERT INTO STAFF (STAFF_ID, PERSON_ID, POSITION_STAFF, EMPLOYMENT_TYPE, SALARY, START_DATE, END_DATE)
VALUES
('S001', 'P001', 'Professor', 'Full-time', 120000, '2021-09-01', NULL),
('S002', 'P002', 'Associate Professor', 'Full-time', 100000, '2020-01-15', NULL),
('S003', 'P003', 'Lecturer', 'Part-time', 60000, '2019-05-01', NULL),
('S004', 'P004', 'Teaching Assistant', 'Part-time', 40000, '2022-02-28', NULL),
('S005', 'P005', 'Research Assistant', 'Full-time', 50000, '2023-08-15', NULL),
('S006', 'P006', 'Administrator', 'Full-time', 70000, '2022-06-01', NULL),
('S007', 'P007', 'Librarian', 'Full-time', 65000, '2021-11-01', NULL),
('S008', 'P008', 'IT Support', 'Full-time', 55000, '2023-03-01', NULL),
('S009', 'P009', 'Counselor', 'Full-time', 75000, '2020-09-01', NULL),
('S010', 'P010', 'Admissions Officer', 'Full-time', 68000, '2022-01-15', NULL),
('S011', 'P011', 'Financial Aid Officer', 'Full-time', 72000, '2021-04-01', NULL),
('S012', 'P012', 'Career Advisor', 'Full-time', 70000, '2023-07-01', NULL),
('S013', 'P013', 'Marketing Specialist', 'Full-time', 62000, '2020-12-01', NULL),
('S014', 'P014', 'HR Manager', 'Full-time', 80000, '2022-09-01', NULL),
('S015', 'P015', 'Accountant', 'Full-time', 65000, '2021-06-15', NULL),
('S016', 'P016', 'Dean', 'Full-time', 150000, '2020-02-01', NULL),
('S017', 'P017', 'Registrar', 'Full-time', 78000, '2022-05-01', NULL);

-- TABLE: LECTURER
INSERT INTO LECTURER (LECTURER_ID, PERSON_ID, HOME_INSTITUTION, FIELD, BIOGRAPHY, IS_VISITING, START_VISIT, END_VISIT)
VALUES
('L001', 'P001', 'MIT', 'Mathematics', 'Expert in Number Theory', FALSE, NULL, NULL),
('L002', 'P002', 'Stanford', 'Computer Science', 'Specializes in AI', FALSE, NULL, NULL),
('L003', 'P003', 'Cambridge', 'Physics', 'Research in Quantum Mechanics', FALSE, NULL, NULL),
('L004', 'P004', 'Oxford', 'Chemistry', 'Focus on Organic Chemistry', FALSE, NULL, NULL),
('L005', 'P005', 'Harvard', 'Biology', 'Studies Genetics', FALSE, NULL, NULL),
('L006', 'P006', 'Caltech', 'Engineering', 'Robotics and Automation', TRUE, '2024-01-15', '2024-06-30'),
('L007', 'P007', 'UCLA', 'History', 'American History Specialist', TRUE, '2023-09-01', '2023-12-15'),
('L008', 'P008', 'Yale', 'Literature', 'Shakespearean Scholar', TRUE, '2024-02-01', '2024-05-31'),
('L009', 'P009', 'LSE', 'Economics', 'Macroeconomics Expert', TRUE, '2023-11-01', '2024-03-31'),
('L010', 'P010', 'Columbia', 'Psychology', 'Clinical Psychology Research', TRUE, '2024-03-15', '2024-07-15'),
('L011', 'P011', 'Sorbonne', 'Sociology', 'Social Theory and Research', FALSE, NULL, NULL),
('L012', 'P012', 'Sciences Po', 'Political Science', 'Comparative Politics Expert', FALSE, NULL, NULL),
('L013', 'P013', 'ETH Zurich', 'Geography', 'Urban Planning and Development', FALSE, NULL, NULL),
('L014', 'P014', 'ANU', 'Environmental Science', 'Climate Change Research', FALSE, NULL, NULL),
('L015', 'P015', 'Courtauld Institute', 'Art History', 'Renaissance Art Specialist', FALSE, NULL, NULL),
('L016', 'P016', 'University of Toronto', 'Medicine', 'Specializes in cardiology', FALSE, NULL, NULL),
('L017', 'P017', 'Kyoto University', 'Engineering', 'Expert in civil engineering', FALSE, NULL, NULL);

-- TABLE: STUDENT
INSERT INTO STUDENT (STUDENT_ID, PERSON_ID, PROGRAM, FUNDING_TYPE, STATUS, DATE_REGISTRATION, ACADEMIC_YEAR)
VALUES
('ST001', 'P006', 'Computer Science', 'Scholarship', 'Active', '2023-09-01', '2023-01-01'),
('ST002', 'P007', 'Engineering', 'Loan', 'Active', '2022-09-01', '2022-01-01'),
('ST003', 'P008', 'Business Administration', 'Self-funded', 'Active', '2021-09-01', '2021-01-01'),
('ST004', 'P009', 'Law', 'Grant', 'Active', '2020-09-01', '2020-01-01'),
('ST005', 'P010', 'Medicine', 'Scholarship', 'Active', '2023-09-01', '2023-01-01'),
('ST006', 'P011', 'Architecture', 'Loan', 'Active', '2022-09-01', '2022-01-01'),
('ST007', 'P012', 'Education', 'Self-funded', 'Active', '2021-09-01', '2021-01-01'),
('ST008', 'P013', 'Psychology', 'Grant', 'Active', '2020-09-01', '2020-01-01'),
('ST009', 'P014', 'Sociology', 'Scholarship', 'Active', '2023-09-01', '2023-01-01'),
('ST010', 'P015', 'Political Science', 'Loan', 'Active', '2022-09-01', '2022-01-01'),
('ST011', 'P001', 'History', 'Self-funded', 'Active', '2021-09-01', '2021-01-01'),
('ST012', 'P002', 'Literature', 'Grant', 'Active', '2020-09-01', '2020-01-01'),
('ST013', 'P003', 'Economics', 'Scholarship', 'Active', '2023-09-01', '2023-01-01'),
('ST014', 'P004', 'Geography', 'Loan', 'Active', '2022-09-01', '2022-01-01'),
('ST015', 'P005', 'Environmental Science', 'Self-funded', 'Active', '2021-09-01', '2021-01-01'),
('ST016', 'P016', 'Business', 'Scholarship', 'Active', '2023-09-01', '2023-01-01'),
('ST017', 'P017', 'Engineering', 'Loan', 'Active', '2022-09-01', '2022-01-01');

-- TABLE: BLOCK
INSERT INTO BLOCK (BLOCK_ID, PHASE, START_DATE, END_DATE, ACADEMIC_YEAR)
VALUES
('B001', 'Fall Semester', '2023-09-01', '2023-12-15', '2023-2024'),
('B002', 'Spring Semester', '2024-01-15', '2024-05-30', '2023-2024'),
('B003', 'Summer Session I', '2024-06-15', '2024-07-31', '2023-2024'),
('B004', 'Summer Session II', '2024-08-01', '2024-08-31', '2023-2024'),
('B005', 'Fall Semester', '2024-09-01', '2024-12-15', '2024-2025'),
('B006', 'Spring Semester', '2025-01-15', '2025-05-30', '2024-2025'),
('B007', 'Summer Session I', '2025-06-15', '2025-07-31', '2024-2025'),
('B008', 'Summer Session II', '2025-08-01', '2025-08-31', '2024-2025'),
('B009', 'Fall Semester', '2022-09-01', '2022-12-15', '2022-2023'),
('B010', 'Spring Semester', '2023-01-15', '2023-05-30', '2022-2023'),
('B011', 'Summer Session I', '2023-06-15', '2023-07-31', '2022-2023'),
('B012', 'Summer Session II', '2023-08-01', '2023-08-31', '2022-2023'),
('B013', 'Fall Semester', '2021-09-01', '2021-12-15', '2021-2022'),
('B014', 'Spring Semester', '2022-01-15', '2022-05-30', '2021-2022'),
('B015', 'Summer Session I', '2022-06-15', '2022-07-31', '2021-2022'),
('B016', 'Fall Semester', '2020-09-01', '2020-12-15', '2020-2021'),
('B017', 'Spring Semester', '2021-01-15', '2021-05-30', '2020-2021');

-- TABLE: COURSES
INSERT INTO COURSES (COURSE_ID, BLOCK_ID, COURSE_NAME, DESCRIPTION)
VALUES
('C001', 'B001', 'Calculus I', 'Introduction to Calculus'),
('C002', 'B001', 'Data Structures', 'Fundamental Data Structures'),
('C003', 'B002', 'Classical Mechanics', 'Newtonian Mechanics'),
('C004', 'B002', 'Organic Chemistry I', 'Basic Organic Chemistry'),
('C005', 'B003', 'Genetics', 'Principles of Heredity'),
('C006', 'B003', 'Thermodynamics', 'Laws of Thermodynamics'),
('C007', 'B004', 'American History', 'Survey of US History'),
('C008', 'B004', 'Shakespeare', 'Shakespearean Plays'),
('C009', 'B005', 'Microeconomics', 'Basic Microeconomic Principles'),
('C010', 'B005', 'Abnormal Psychology', 'Study of Mental Disorders'),
('C011', 'B006', 'Social Theory', 'Major Social Theories'),
('C012', 'B006', 'Comparative Politics', 'Comparison of Political Systems'),
('C013', 'B007', 'Urban Geography', 'Study of Urban Environments'),
('C014', 'B007', 'Climate Change', 'Causes and Effects of Climate Change'),
('C015', 'B008', 'Renaissance Art', 'Art of the Renaissance Period'),
('C016', 'B009', 'Marketing', 'Introduction to Marketing Principles'),
('C017', 'B010', 'Structural Analysis', 'Basic Structural Analysis Concepts');

-- TABLE: TUTOR

INSERT INTO TUTOR (TUTOR_ID, PERSON_ID, COURSE_ID, BACKGROUND, ACADEMIC_YEAR)
VALUES
('T001', 'P001', 'C001', 'Mathematics PhD', '2024-01-01'),
('T002', 'P002', 'C002', 'Computer Science MSc', '2024-01-01'),
('T003', 'P003', 'C003', 'Physics BSc', '2024-01-01'),
('T004', 'P004', 'C004', 'Chemistry PhD', '2024-01-01'),
('T005', 'P005', 'C005', 'Biology MSc', '2024-01-01'),
('T006', 'P006', 'C006', 'Engineering PhD', '2023-01-01'),
('T007', 'P007', 'C007', 'History MA', '2023-01-01'),
('T008', 'P008', 'C008', 'Literature PhD', '2023-01-01'),
('T009', 'P009', 'C009', 'Economics MSc', '2023-01-01'),
('T010', 'P010', 'C010', 'Psychology PhD', '2023-01-01'),
('T011', 'P011', 'C011', 'Sociology MA', '2022-01-01'),
('T012', 'P012', 'C012', 'Political Science PhD', '2022-01-01'),
('T013', 'P013', 'C013', 'Geography MSc', '2022-01-01'),
('T014', 'P014', 'C014', 'Environmental Science PhD', '2022-01-01'),
('T015', 'P015', 'C015', 'Art History MA', '2022-01-01'),
('T016', 'P016', 'C002', 'Business Admin MBA', '2024-01-01'),
('T017', 'P017', 'C006', 'Civil Engineering PhD', '2024-01-01');



-- TABLE: TAKE
INSERT INTO TAKE (STUDENT_ID, COURSE_ID, GRADE)
VALUES
('ST001', 'C002', 'A'),
('ST001', 'C001', 'B'),
('ST002', 'C006', 'C'),
('ST002', 'C004', 'A'),
('ST003', 'C009', 'B'),
('ST003', 'C012', 'A'),
('ST004', 'C007', 'C'),
('ST004', 'C011', 'B'),
('ST005', 'C005', 'A'),
('ST005', 'C014', 'B'),
('ST006', 'C001', 'C'),
('ST006', 'C008', 'A'),
('ST007', 'C010', 'B'),
('ST007', 'C015', 'C'),
('ST008', 'C003', 'A'),
('ST009', 'C004', 'B'),
('ST010', 'C005', 'C');

-- TABLE: TEACH
INSERT INTO TEACH (LECTURER_ID, COURSE_ID)
VALUES
('L001', 'C001'),
('L002', 'C002'),
('L003', 'C003'),
('L004', 'C004'),
('L005', 'C005'),
('L006', 'C006'),
('L007', 'C007'),
('L008', 'C008'),
('L009', 'C009'),
('L010', 'C010'),
('L011', 'C011'),
('L012', 'C012'),
('L013', 'C013'),
('L014', 'C014'),
('L015', 'C015'),
('L016', 'C016'),
('L017', 'C017');

-- TABLE: MEAL_PLAN
INSERT INTO MEAL_PLAN (MEAL_ID, DESCRIPTION, COST_MEAL, DATE_MEAL)
VALUES
('M001', 'Breakfast Buffet', 10.00, '2024-03-01'),
('M002', 'Lunch Combo', 15.00, '2024-03-01'),
('M003', 'Dinner Special', 20.00, '2024-03-01'),
('M004', 'Breakfast Buffet', 10.00, '2024-03-02'),
('M005', 'Lunch Combo', 15.00, '2024-03-02'),
('M006', 'Dinner Special', 20.00, '2024-03-02'),
('M007', 'Breakfast Buffet', 10.00, '2024-03-03'),
('M008', 'Lunch Combo', 15.00, '2024-03-03'),
('M009', 'Dinner Special', 20.00, '2024-03-03'),
('M010', 'Breakfast Buffet', 10.00, '2024-03-04'),
('M011', 'Lunch Combo', 15.00, '2024-03-04'),
('M012', 'Dinner Special', 20.00, '2024-03-04'),
('M013', 'Breakfast Buffet', 10.00, '2024-03-05'),
('M014', 'Lunch Combo', 15.00, '2024-03-05'),
('M015', 'Dinner Special', 20.00, '2024-03-05'),
('M016', 'Vegetarian Lunch', 12.00, '2024-03-06'),
('M017', 'Vegan Dinner', 18.00, '2024-03-06');

-- TABLE: IS_EATEN
INSERT INTO IS_EATEN (MEAL_ID, PERSON_ID)
VALUES
('M001', 'P001'),
('M002', 'P001'),
('M003', 'P001'),
('M004', 'P002'),
('M005', 'P002'),
('M006', 'P003'),
('M007', 'P003'),
('M008', 'P004'),
('M009', 'P004'),
('M010', 'P005'),
('M011', 'P005'),
('M012', 'P006'),
('M013', 'P006'),
('M014', 'P007'),
('M015', 'P007'),
('M016', 'P008'),
('M017', 'P009');

-- TABLE: OUTREACH_PROGRAM
INSERT INTO OUTREACH_PROGRAM (OUTREACH_ID, OUTREACH_NAME, DESCRIPTION)
VALUES
('OP001', 'Community Tutoring', 'Provides tutoring services to local schools'),
('OP002', 'Environmental Cleanup', 'Organizes cleanup events in local parks'),
('OP003', 'Food Bank Support', 'Volunteers at the local food bank'),
('OP004', 'Homeless Shelter Support', 'Provides support to homeless shelters'),
('OP005', 'Senior Citizen Visits', 'Visits senior citizens in nursing homes'),
('OP006', 'Youth Mentoring', 'Mentoring program for at-risk youth'),
('OP007', 'Disability Awareness', 'Programs to promote disability awareness'),
('OP008', 'Literacy Programs', 'Runs literacy programs for adults and children'),
('OP009', 'Health Awareness', 'Organizes health awareness campaigns'),
('OP010', 'Animal Shelter Support', 'Provides support to local animal shelters'),
('OP011', 'Community Garden', 'Maintains a community garden for local residents'),
('OP012', 'Legal Aid Clinics', 'Provides free legal aid to low-income individuals'),
('OP013', 'Arts and Crafts Workshops', 'Runs arts and crafts workshops for children'),
('OP014', 'Music Therapy Programs', 'Offers music therapy programs to patients'),
('OP015', 'Coding Workshops', 'Provides coding workshops to students'),
('OP016', 'Environmental Education', 'Educates the public about environmental issues'),
('OP017', 'Career Counseling', 'Offers career counseling to students');

-- TABLE: EVENTS
INSERT INTO EVENTS (EVENT_ID, EVENT_NAME, EVENT_TYPE, LOCATION, DESCRIPTION, START_DATE, END_DATE)
VALUES
('EV001', 'Welcome Week', 'Orientation', 'Campus Quad', 'Orientation for new students', '2024-08-28 09:00:00', '2024-08-30 17:00:00'),
('EV002', 'Career Fair', 'Career', 'Student Union', 'Recruiting event for students', '2024-09-15 10:00:00', '2024-09-15 16:00:00'),
('EV003', 'Homecoming Game', 'Sports', 'Stadium', 'Annual homecoming football game', '2024-10-20 14:00:00', '2024-10-20 17:00:00'),
('EV004', 'Thanksgiving Dinner', 'Social', 'Dining Hall', 'Thanksgiving dinner for students', '2024-11-28 12:00:00', '2024-11-28 14:00:00'),
('EV005', 'Winter Formal', 'Social', 'Ballroom', 'Annual winter formal dance', '2024-12-15 19:00:00', '2024-12-15 23:00:00'),
('EV006', 'Spring Fling', 'Social', 'Campus Green', 'Spring festival with music and games', '2025-04-15 11:00:00', '2025-04-15 17:00:00'),
('EV007', 'Graduation Ceremony', 'Academic', 'Auditorium', 'Graduation ceremony for graduating students', '2025-05-20 10:00:00', '2025-05-20 12:00:00'),
('EV008', 'Alumni Reunion', 'Social', 'Various Locations', 'Reunion event for alumni', '2025-06-10 10:00:00', '2025-06-12 18:00:00'),
('EV009', 'Summer Concert Series', 'Music', 'Campus Quad', 'Weekly summer concert series', '2024-06-01 19:00:00', '2024-08-31 22:00:00'),
('EV010', 'International Food Festival', 'Cultural', 'Student Union', 'Festival showcasing international cuisine', '2024-07-15 12:00:00', '2024-07-15 16:00:00'),
('EV011', 'Science Fair', 'Academic', 'Science Building', 'Exhibition of student science projects', '2024-03-10 10:00:00', '2024-03-10 14:00:00'),
('EV012', 'Art Exhibition', 'Art', 'Art Gallery', 'Exhibition of student artwork', '2024-04-05 12:00:00', '2024-04-05 16:00:00'),
('EV013', 'Debate Tournament', 'Academic', 'Law School', 'Intercollegiate debate tournament', '2024-05-01 09:00:00', '2024-05-02 17:00:00'),
('EV014', 'Theatre Production', 'Arts', 'Theatre', 'Student theatre production', '2024-11-05 19:00:00', '2024-11-07 22:00:00'),
('EV015', 'Guest Lecture Series', 'Academic', 'Lecture Hall', 'Weekly guest lecture series', '2024-09-05 14:00:00', '2024-12-12 16:00:00'),
('EV016', 'Coding Competition', 'Academic', 'Computer Lab', 'Annual coding competition for students', '2024-02-10 09:00:00', '2024-02-10 17:00:00'),
('EV017', 'Music Festival', 'Music', 'Campus Field', 'Annual music festival featuring local bands', '2024-05-15 14:00:00', '2024-05-15 22:00:00');

-- TABLE: PUBLICATION
INSERT INTO PUBLICATION (PUBLICATION_ID, TITLE_PUBLI, ABSTRACT, PUBLICATION_DATE, DOI, JOURNAL, TYPE)
VALUES
('PB001', 'Advances in AI', 'Summary of recent AI breakthroughs', '2024-01-15', 'doi:10.1000/12345', 'AI Journal', 'Journal Article'),
('PB002', 'Climate Change Effects', 'Assessment of climate change impact', '2023-11-01', 'doi:10.1000/67890', 'Nature Climate', 'Journal Article'),
('PB003', 'Economic Inequality', 'Analysis of wealth distribution', '2024-02-20', 'doi:10.1000/13579', 'Economics Review', 'Journal Article'),
('PB004', 'Social Media Influence', 'Study of social media effects', '2023-12-05', 'doi:10.1000/24680', 'Social Media Journal', 'Conference Paper'),
('PB005', 'Quantum Computing', 'Explanation of quantum computing principles', '2024-03-10', 'doi:10.1000/98765', 'Physics Today', 'Journal Article'),
('PB006', 'Nanomaterials Synthesis', 'Novel method for nanomaterial synthesis', '2023-10-25', 'doi:10.1000/43210', 'Chemical Science', 'Journal Article'),
('PB007', 'Global Health Challenges', 'Overview of global health issues', '2024-04-01', 'doi:10.1000/56789', 'Lancet', 'Review Article'),
('PB008', 'Digital Art Trends', 'Analysis of current digital art trends', '2023-11-15', 'doi:10.1000/09876', 'Art Journal', 'Conference Paper'),
('PB009', 'Renewable Energy Sources', 'Assessment of renewable energy options', '2024-05-05', 'doi:10.1000/87654', 'Energy Policy', 'Journal Article'),
('PB010', 'Human Brain Mapping', 'Overview of human brain mapping techniques', '2023-12-20', 'doi:10.1000/34567', 'Neuroscience', 'Review Article'),
('PB011', 'Sustainable Agriculture', 'Strategies for sustainable farming', '2024-06-10', 'doi:10.1000/76543', 'Agricultural Science', 'Journal Article'),
('PB012', 'Urban Planning Designs', 'Innovative concepts in urban design', '2023-10-01', 'doi:10.1000/23456', 'Urban Planning Journal', 'Journal Article'),
('PB013', 'Biomedical Engineering', 'Advances in biomedical engineering fields', '2024-07-01', 'doi:10.1000/45678', 'Biomedical Engineering Journal', 'Review Article'),
('PB014', 'Cybersecurity Strategies', 'Analysis of effective cybersecurity measures', '2023-11-20', 'doi:10.1000/56789', 'Cybersecurity Review', 'Conference Paper'),
('PB015', 'Robotics Automation', 'Recent robotics and automation advancements', '2024-08-01', 'doi:10.1000/90123', 'Robotics Automation Journal', 'Journal Article'),
('PB016', 'Financial Crisis Analysis', 'Analysis of recent financial crisis', '2023-09-10', 'doi:10.1000/11223', 'Finance Journal', 'Journal Article'),
('PB017', 'Civil Engineering Innovations', 'Overview of new developments', '2024-01-20', 'doi:10.1000/44556', 'Civil Engineering Journal', 'Review Article');

-- TABLE: RESEARCH_PROJECT
INSERT INTO RESEARCH_PROJECT (PROJECT_ID, STUDENT_ID, LECTURER_ID, TUTOR_ID, TITLE, DESCRIPTION, START_DATE, END_DATE)
VALUES
('RP001', 'ST001', 'L002', 'T002', 'AI in Healthcare', 'Application of AI in medical diagnosis', '2024-01-15', '2024-05-30'),
('RP002', 'ST002', 'L006', 'T006', 'Robotics in Manufacturing', 'Automation in manufacturing processes', '2023-09-01', '2023-12-15'),
('RP003', 'ST003', 'L009', 'T009', 'Economic Impact of Globalization', 'Study of globalization effects on economies', '2024-02-01', '2024-05-31'),
('RP004', 'ST004', 'L007', 'T007', 'Civil Rights Movement', 'Analysis of the Civil Rights Movement', '2023-11-01', '2024-03-31'),
('RP005', 'ST005', 'L005', 'T005', 'Genetic Engineering', 'Ethical considerations in genetic engineering', '2024-03-15', '2024-07-15'),
('RP006', 'ST006', 'L001', 'T001', 'Sustainable Building Design', 'Innovative approaches to building design', '2023-01-01', '2024-05-30'),
('RP007', 'ST007', 'L001', 'T001', 'Early Childhood Development', 'Impact of early education on child development', '2023-01-01', '2023-12-15'),
('RP008', 'ST008', 'L002', 'T002', 'Cognitive Biases', 'Influence of biases on decision-making', '2023-09-01', '2024-03-31'),
('RP009', 'ST009', 'L003', 'T003', 'Poverty and Inequality', 'Factors contributing to social disparities', '2023-09-01', '2024-07-15'),
('RP010', 'ST010', 'L004', 'T004', 'Presidential Power', 'Scope and influence of executive authority', '2024-01-15', '2024-05-30'),
('RP011', 'ST011', 'L001', 'T007', 'Digital Archives', 'Preservation of digital archives', '2023-01-01', '2024-03-31'),
('RP012', 'ST012', 'L002', 'T008', 'Postmodern Literature', 'Exploration of postmodern literary trends', '2023-09-01', '2024-07-15'),
('RP013', 'ST013', 'L009', 'T009', 'Behavioral Economics', 'Psychological factors affecting economic decisions', '2024-01-15', '2024-05-30'),
('RP014', 'ST014', 'L010', 'T010', 'Memory and Aging', 'Processes and challenges of memory in older age', '2023-01-01', '2024-03-31'),
('RP015', 'ST015', 'L011', 'T011', 'Social Media Impact', 'Influence on communication and identity', '2023-09-01', '2024-07-15'),
('RP016', 'ST016', 'L016', 'T016', 'Marketing Strategies', 'Innovative marketing strategies', '2024-02-01', '2024-06-30'),
('RP017', 'ST017', 'L017', 'T017', 'Structural Optimization', 'Optimal design of structures', '2023-10-01', '2024-04-30');

-- TABLE: FINANCIAL_TRANSACTION
INSERT INTO FINANCIAL_TRANSACTION (TRANSACTION_ID, TRANSACTION_DATE, AMOUNT, RECIPIENT_ID, DESCRIPTION, APPROVED_BY)
VALUES
('FT001', '2024-01-10', 1500.00, 'ST001', 'Tuition Fee Payment', 'S006'),
('FT002', '2024-01-15', 500.00, 'A001', 'Accommodation Fee', 'S006'),
('FT003', '2024-01-20', 200.00, 'M001', 'Meal Plan Payment', 'S006'),
('FT004', '2024-01-25', 1000.00, 'RP001', 'Research Grant', 'S006'),
('FT005', '2024-01-30', 300.00, 'L002', 'Travel Reimbursement', 'S006'),
('FT006', '2024-02-05', 1200.00, 'ST002', 'Tuition Fee Payment', 'S006'),
('FT007', '2024-02-10', 450.00, 'A002', 'Accommodation Fee', 'S006'),
('FT008', '2024-02-15', 180.00, 'M002', 'Meal Plan Payment', 'S006'),
('FT009', '2024-02-20', 900.00, 'RP002', 'Research Grant', 'S006'),
('FT010', '2024-02-25', 280.00, 'L006', 'Travel Reimbursement', 'S006'),
('FT011', '2024-03-01', 1300.00, 'ST003', 'Tuition Fee Payment', 'S006'),
('FT012', '2024-03-05', 400.00, 'A003', 'Accommodation Fee', 'S006'),
('FT013', '2024-03-10', 150.00, 'M003', 'Meal Plan Payment', 'S006'),
('FT014', '2024-03-15', 800.00, 'RP003', 'Research Grant', 'S006'),
('FT015', '2024-03-20', 250.00, 'L009', 'Travel Reimbursement', 'S006'),
('FT016', '2024-03-25', 1100.00, 'ST004', 'Tuition Fee Payment', 'S006'),
('FT017', '2024-03-30', 350.00, 'A004', 'Accommodation Fee', 'S006');

-- TABLE: GRANTS
INSERT INTO GRANTS (GRANT_ID, TITLE, DESCRIPTION, FUNDINGAGENCY, AMOUNT, STATUS)
VALUES
('GR001', 'AI Research Grant', 'Grant for AI research projects', 'National Science Foundation', 50000.00, 'Approved'),
('GR002', 'Climate Action Grant', 'Grant for climate change initiatives', 'Environmental Protection Agency', 75000.00, 'Approved'),
('GR003', 'Economic Development Grant', 'Grant for economic development projects', 'World Bank', 100000.00, 'Approved'),
('GR004', 'Cultural Preservation Grant', 'Grant for cultural preservation projects', 'UNESCO', 60000.00, 'Approved'),
('GR005', 'Health Research Grant', 'Grant for health research projects', 'National Institutes of Health', 80000.00, 'Approved'),
('GR006', 'Tech Innovation Grant', 'Grant for technology innovation projects', 'Intel Foundation', 90000.00, 'Approved'),
('GR007', 'Education Improvement Grant', 'Grant for education improvement projects', 'Bill & Melinda Gates Foundation', 120000.00, 'Approved'),
('GR008', 'Social Justice Grant', 'Grant for social justice initiatives', 'Ford Foundation', 70000.00, 'Approved'),
('GR009', 'Environmental Conservation Grant', 'Grant for environmental conservation projects', 'The Nature Conservancy', 85000.00, 'Approved'),
('GR010', 'Arts and Culture Grant', 'Grant for arts and culture projects', 'National Endowment for the Arts', 65000.00, 'Approved'),
('GR011', 'Community Development Grant', 'Grant for community development projects', 'Local Community Fund', 55000.00, 'Approved'),
('GR012', 'Youth Empowerment Grant', 'Grant for youth empowerment programs', 'Youth Empowerment Foundation', 78000.00, 'Approved'),
('GR013', 'Disability Support Grant', 'Grant for disability support initiatives', 'Disability Rights Fund', 62000.00, 'Approved'),
('GR014', 'Legal Aid Grant', 'Grant for legal aid services', 'Open Society Foundations', 95000.00, 'Approved'),
('GR015', 'Public Health Grant', 'Grant for public health initiatives', 'World Health Organization', 110000.00, 'Approved'),
('GR016', 'Sustainable Energy Grant', 'Grants for sustainable enegy', 'Clean Energy foundation', 500000.00, 'Approved'),
('GR017', 'Smart Cities Research', 'Research for smart cities', 'Smart Foundations', 100000.00, 'Approved');


-- TABLE: IS_GRANT
INSERT INTO IS_GRANT (PROJECT_ID, GRANT_ID_1)
VALUES
('RP001', 'GR001'),
('RP002', 'GR002'),
('RP003', 'GR003'),
('RP004', 'GR004'),
('RP005', 'GR005'),
('RP006', 'GR006'),
('RP007', 'GR007'),
('RP008', 'GR008'),
('RP009', 'GR009'),
('RP010', 'GR010'),
('RP011', 'GR011'),
('RP012', 'GR012'),
('RP013', 'GR013'),
('RP014', 'GR014'),
('RP015', 'GR015'),
('RP016', 'GR006'),
('RP017', 'GR007');

-- TABLE: IS_FINANCED
INSERT INTO IS_FINANCED (EVENT_ID, GRANT_ID_1)
VALUES
('EV001', 'GR001'),
('EV002', 'GR002'),
('EV003', 'GR003'),
('EV004', 'GR004'),
('EV005', 'GR005'),
('EV006', 'GR006'),
('EV007', 'GR007'),
('EV008', 'GR008'),
('EV009', 'GR009'),
('EV010', 'GR010'),
('EV011', 'GR011'),
('EV012', 'GR012'),
('EV013', 'GR013'),
('EV014', 'GR014'),
('EV015', 'GR015'),
('EV016', 'GR001'),
('EV017', 'GR002');



-- TABLE: HAVE_GRANT
INSERT INTO HAVE_GRANT (OUTREACH_ID, GRANT_ID_1)
VALUES
('OP001', 'GR001'),
('OP002', 'GR002'),
('OP003', 'GR003'),
('OP004', 'GR004'),
('OP005', 'GR005'),
('OP006', 'GR006'),
('OP007', 'GR007'),
('OP008', 'GR008'),
('OP009', 'GR009'),
('OP010', 'GR010'),
('OP011', 'GR011'),
('OP012', 'GR012'),
('OP013', 'GR013'),
('OP014', 'GR014'),
('OP015', 'GR015'),
('OP016', 'GR001'),
('OP017', 'GR002');

-- TABLE: CAN_PARTICIPATE
INSERT INTO CAN_PARTICIPATE (PERSON_ID, EVENT_ID)
VALUES
('P001', 'EV001'),
('P002', 'EV002'),
('P003', 'EV003'),
('P004', 'EV004'),
('P005', 'EV005'),
('P006', 'EV006'),
('P007', 'EV007'),
('P008', 'EV008'),
('P009', 'EV009'),
('P010', 'EV010'),
('P011', 'EV011'),
('P012', 'EV012'),
('P013', 'EV013'),
('P014', 'EV014'),
('P015', 'EV015'),
('P016', 'EV016'),
('P017', 'EV017');

-- TABLE: PARTICIPATE
INSERT INTO PARTICIPATE (PERSON_ID, OUTREACH_ID)
VALUES
('P001', 'OP001'),
('P002', 'OP002'),
('P003', 'OP003'),
('P004', 'OP004'),
('P005', 'OP005'),
('P006', 'OP006'),
('P007', 'OP007'),
('P008', 'OP008'),
('P009', 'OP009'),
('P010', 'OP010'),
('P011', 'OP011'),
('P012', 'OP012'),
('P013', 'OP013'),
('P014', 'OP014'),
('P015', 'OP015'),
('P016', 'OP001'),
('P017', 'OP002');

-- TABLE: IS_AUTHOR
INSERT INTO IS_AUTHOR (PUBLICATION_ID, PERSON_ID, AUTHOR_ORDER)
VALUES
('PB001', 'P001', 1),
('PB002', 'P002', 1),
('PB003', 'P003', 1),
('PB004', 'P004', 1),
('PB005', 'P005', 1),
('PB006', 'P006', 1),
('PB007', 'P007', 1),
('PB008', 'P008', 1),
('PB009', 'P009', 1),
('PB010', 'P010', 1),
('PB011', 'P011', 1),
('PB012', 'P012', 1),
('PB013', 'P013', 1),
('PB014', 'P014', 1),
('PB015', 'P015', 1),
('PB016', 'P001', 2),
('PB017', 'P002', 2);


-- End of data insertion script

      

              
              
              

