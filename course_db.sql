-- create and select the database
-- change your_server_user_name in the following line before running this file
USE barrera_course_db;  -- MySQL command

-- drop tables if already exist
DROP TABLE IF EXISTS schedule;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS sections;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS courses;

-- create the tables

CREATE TABLE courses (
  courseNumber       CHAR(8)        NOT NULL,
  courseName         VARCHAR(80)    NOT NULL,
  courseDescription  VARCHAR(500)   NOT NULL,
  creditHours        DECIMAL(2, 1)  NOT NULL,
  integWriting       BOOLEAN        DEFAULT FALSE,
  PRIMARY KEY (courseNumber)
);

CREATE TABLE instructors (
  instructorID       INT(5)         NOT NULL  AUTO_INCREMENT,
  instructorName     VARCHAR(80)    NOT NULL,
  instructorOffice   VARCHAR(80),
  instructorEmail    VARCHAR(80),
  PRIMARY KEY (instructorID)
);

CREATE TABLE sections (
  courseNumber       CHAR(8)        NOT NULL,
  sectionNumber      CHAR(5)        NOT NULL,
  term               VARCHAR(10)    NOT NULL,
  AY_year            INT(11)        NOT NULL,
  instructorID       INT(5),
  enrollmentLimit    INT(4)         NOT NULL,
  meetingDays        VARCHAR(20),
  meetingTime        VARCHAR(20),
  PRIMARY KEY (sectionNumber, courseNumber, term, AY_year),
  CONSTRAINT FOREIGN KEY (courseNumber) references courses (courseNumber),
  CONSTRAINT FOREIGN KEY (instructorID) references instructors (instructorID)
);

CREATE TABLE students (
  studentID         VARCHAR(12)     NOT NULL,
  studentName       VARCHAR(255)    NOT NULL,
  PRIMARY KEY (studentID)
);

CREATE TABLE schedule (  
  studentID         VARCHAR(12)     NOT NULL,
  sectionNumber     INT(5)          NOT NULL,
  courseNumber      CHAR(8)         NOT NULL,
  term               VARCHAR(10)    NOT NULL,
  AY_year            INT(11)        NOT NULL,
  PRIMARY KEY (studentID, sectionNumber, courseNumber, term, AY_year),
  CONSTRAINT FOREIGN KEY (studentID) references students(studentID),
  CONSTRAINT FOREIGN KEY (courseNumber)  references courses(courseNumber)
);

-- populate the database
INSERT INTO courses (courseNumber, courseName, courseDescription, creditHours)
VALUES
('CS1000', 'Technology and Society', 'Examines and evaluates the consequences of technology on individuals, organizations and society to recognize its benefits, potential, and limitations. Explores current social, ethical, legal and philosophical topics to understand how the Digital Revolution impacts society.', 4.0),
('CS1150', 'Introduction to Computer Science', 'Expose students to the scientific method as implemented in computer science. Topics include basic programming, web design, database, logic gates, algorithm development and fundamentals of networking. The course requires students to apply and extend the concepts in a laboratory setting.', 4.0),
('CS1180', 'Computer Science I', 'Basic concepts of programming and programming languages. Structured programming, stepwise refinement, and object-oriented development.', 4.0),
('CS1181', 'Computer Science II', 'Advanced concepts of computer programming. Use of data structures and tools that facilitate programming.', 4.0),
('CS1200', 'Introduction to Discrete Structures', 'Emphasis of basic mathematical notation and manipulation with discrete structures.', 4.0),
('CS2200', 'Introduction to Computer Science', 'Discrete structures and their algorithms for computer science. Emphasis on rigorous proof and formal argumentation.', 4.0),
('CS2800', 'Web Development I', 'Introduction to basic web design and development using HTML and CSS. Topics include page structure, responsive design, and use of multimedia. Client-side programming using scripting languages such as JavaScript and jQuery will be introduced.', 3.0),
('CS3100', 'Data Structures and Algorithms', 'Study of the implementation of data structures and control structures in professional computer programs. Introduction to the fundamentals of complexity and analysis. Study of common standard problems and solutions (e.g., transitive closure and critical path). Emphasis on high-level language software design.', 3.0),
('CS3260', 'Numerical Methods for Computational Science', '', 3.0),
('CS3700', 'Introduction to Oracle/SQL Databases', '', 3.0),
('CS3800', 'Web Development II', 'Focuses on server side web development. Topics include creation of dynamic web pages, processing form data, database design and interaction, managing cookies and sessions, and security. Students will use a current server-side language such as PHP and a database management system such as MySQL.', 3.0),
('CS4000', 'Social Implications of Computing', 'Impact of computers and computing on society. Topics include privacy, dangers introduced by computers performing critical tasks, the effect of robots on the work force, the impact of computers on education, and the new legal issues introduced by computing. Integrated Writing course.', 3.0),
('CEG2170', 'Introduction to C Programming for Scientists and Engineers', 'Basic engineering problem solving using the C programming language. Topics include loops, selection, input/output, files, functions, arrays, complex variables, pointers, structures, and dynamic memory. Students will learn how to approach solving problems in engineering and science; how to develop algorithms, using advanced techniques such as recursion, searching, sorting and linked lists, to solve those problems; and how to implement those algorithms in the C language.', 4.0),
('CEG2171', 'C++ Programming for Scientists and Engineers', 'Object-oriented programming using the C++ programming language. Topics include abstract data types, inheritance, polymorphism, abstract classes, templates, pointers, linked lists, stacks, queues, recursion, sorting algorithms, and binary trees. Students will apply problem-solving techniques and algorithm development to solve problems in engineering and science, and will implement those algorithms in the C++ language.', 4.0),
('CEG2350', 'Operating System Concepts and Usage', 'Provides introduction to Linux and Windows operating systems and system administration. Covers files and directories, ownership and sharing, programs and processes, system calls, libraries, dynamic linking, command line shells, scripting, regular expressions and secure network protocols.', 4.0),
('CEG2400', 'Introduction to PC Networking', 'Introduces networking technologies including infrastructure and architectures, standards, protocols and directory services, administration, security and management.', 3.0),
('CEG3310', 'Computer Organization', 'Organization and sequential operation of digital computers. Binary and hexadecimal number systems, 2s complement arithmetic, program control, memory organization and hierarchy, addressing modes, stacks and parameter passing, interrupts and traps, I/O devices, DMA, cache, and virtual memory.', 4.0),
('CEG3320', 'Digital System Design', 'Basics of digital computer hardware and design. Topics include switching algebra and switching functions, logic design of combinational and sequential circuits, storage elements, register-level design, and instrumentation.', 4.0),
('CEG4110', 'Introduction to Software Engineering', 'Introduction to the concepts of Software Engineering. Software qualities, development life-cycle models, requirements analysis, semi-formal and formal systems modeling, system design, testing, and project management techniques. Case studies and a course project serve as examples illustrating the software engineering process.', 3.0),
('CEG4180', 'Object-Oriented Programming and Design', 'Study of object-oriented design and programming. Programming topics emphasize the core concepts of encapsulation, inheritance, polymorphism, and dynamic binding. Additional topics include class organization, software maintenance, and design of reusable components', 3.0),
('CEG4230', 'Introduction to Robotics', 'An introduction to the mathematics of robots. Topics covered include coordinate systems and transformations, manipulator kinematics and inverse kinematics, Jacobians, dynamic and trajectory planning.', 3.0);

UPDATE courses
SET integWriting = TRUE
WHERE courseNumber IN ('CS1180', 'CS1181', 'CS4000', 'CEG2171', 'CEG3320', 'CEG4110');

INSERT INTO instructors VALUES
(1001, 'Starkey, Vanessa', 'Russ 336', 'vanessa.starkey@wright.edu'),
(1002, 'Meyer, Karen', 'Russ 344', 'karen.meyer@wright.edu'),
(1003, 'Taylor, Ronald', 'Russ 340', 'ronald.taylor@wright.edu'),
(1004, 'Saunders, Vance', 'Russ 450', 'vance.saunders@wright.edu'),
(1005, 'Volkers, Richard', 'Russ 338', 'richard.volkers@wright.edu');

INSERT INTO instructors(instructorID, instructorName) VALUES
(1006, 'Fickert, Chris');

INSERT INTO sections VALUES
('CS1000', '01', 'Fall', 2016, 1004, 108, 'TR', '11:00am-12:20pm'),
('CS1000', '02', 'Fall', 2016, 1005, 54, 'MWF', '3:35pm-4:30pm'),
('CS1150', '01', 'Fall', 2016, 1002, 36, 'MWF', '11:15am-12:10pm'),
('CS1150', '02', 'Fall', 2016, 1002, 95, 'MWF', '11:25am-12:20pm'),
('CS1150', '03', 'Fall', 2016, 1005, 54, 'TR', '12:30pm-1:50pm'),
('CS1180', '01', 'Fall', 2016, 1001, 54, 'MWF', '11:15am-12:10pm'),
('CS1180', '02', 'Fall', 2016, 1001, 54, 'MWF', '1:25pm-2:20pm'),
('CS1200', '01', 'Fall', 2016, 1003, 54,  'TR', '11:00am-12:20pm'),
('CS2800', '01', 'Fall', 2016, 1001, 36, 'MWF', '11:15am-12:10pm'),
('CS3800', '01', 'Fall', 2016, 1001, 36, 'TR', '11:00am-12:20pm'),
('CS1000', '01', 'Spring', 2017, 1004, 108, 'TR', '8:00am-9:20am'),
('CS1000', '02', 'Spring', 2017, 1006, 54, 'MWF', '12:20pm-1:15pm'),
('CS1150', '01', 'Spring', 2017, 1002, 36, 'MWF', '12:20pm-1:15pm'),
('CS1150', '02', 'Spring', 2017, 1002, 95, 'MWF', '10:10am-11:05am'),
('CS1150', '03', 'Spring', 2017, 1005, 54, 'MWF', '11:15am-12:10pm'),
('CS1180', '01', 'Spring', 2017, 1006, 54, 'MWF', '11:15am-12:10pm'),
('CS1180', '02', 'Spring', 2017, 1006, 54, 'MWF', '3:35pm-4:30pm'),
('CS1200', '01', 'Spring', 2017, 1001, 54,  'TR', '11:00am-12:20pm'),
('CS2800', '01', 'Spring', 2017, 1001, 36, 'MWF', '3:35pm-4:30pm'),
('CS3800', '01', 'Spring', 2017, 1001, 36, 'TR', '2:00pm-3:20pm');

INSERT INTO students VALUES
('w123456', 'Smith, Alice'),
('w345678', 'Adams, Diane'),
('w987654', 'Rodriguez, John');

INSERT INTO schedule VALUES
('w123456', '01', 'CS1000', 'Fall', 2016),
('w123456', '02', 'CS1150', 'Fall', 2016),
('w123456', '01', 'CS1200', 'Fall', 2016),
('w345678', '02', 'CS1000', 'Fall', 2016),
('w345678', '01', 'CS1150', 'Fall', 2016),
('w987654', '01', 'CS1000', 'Fall', 2016),
('w987654', '02', 'CS1150', 'Fall', 2016),
('w987654', '02', 'CS1180', 'Fall', 2016),
('w123456', '01', 'CS1180', 'Spring', 2017),
('w123456', '01', 'CS2800', 'Spring', 2017),
('w345678', '02', 'CS1180', 'Spring', 2017),
('w345678', '01', 'CS1200', 'Spring', 2017),
('w987654', '01', 'CS1200', 'Spring', 2017);

