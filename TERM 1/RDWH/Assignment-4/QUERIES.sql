use Assignments;

CREATE TABLE dbo.Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Country VARCHAR(50),
    RegistrationDate DATE
);

CREATE TABLE dbo.Instructors (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(100),
    Department VARCHAR(100)
);

CREATE TABLE dbo.Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Category VARCHAR(100),
    InstructorID INT,
    CourseFee DECIMAL(10,2),
    FOREIGN KEY (InstructorID) REFERENCES dbo.Instructors(InstructorID)
);

CREATE TABLE dbo.Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    CompletionStatus VARCHAR(20),
    Score DECIMAL(5,2),
    FOREIGN KEY (StudentID) REFERENCES dbo.Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES dbo.Courses(CourseID)
);

CREATE TABLE dbo.Payments (
    PaymentID INT PRIMARY KEY,
    StudentID INT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    FOREIGN KEY (StudentID) REFERENCES dbo.Students(StudentID)
);

INSERT INTO dbo.Students VALUES
(1,'Alice','USA','2023-01-10'),
(2,'Brian','Canada','2023-02-15'),
(3,'Carlos','USA','2023-03-20'),
(4,'Diana','UK','2023-04-25'),
(5,'Ethan','Canada','2023-05-30'),
(6,'Fatima','USA','2023-06-10'),
(7,'George','UK','2023-07-15'),
(8,'Hannah','USA','2023-08-20');

INSERT INTO dbo.Instructors VALUES
(1,'Dr. Smith','Data Science'),
(2,'Dr. Adams','Programming'),
(3,'Dr. Lee','Data Science'),
(4,'Dr. Patel','Business'),
(5,'Dr. Brown','Programming');

INSERT INTO dbo.Courses VALUES
(1,'SQL Basics','Data Science',1,500),
(2,'Python Advanced','Programming',2,700),
(3,'Machine Learning','Data Science',3,1000),
(4,'Business Analytics','Business',4,800),
(5,'Java Programming','Programming',5,600);

INSERT INTO dbo.Enrollments VALUES
(1,1,1,'2023-02-01','Completed',85),
(2,1,3,'2023-02-10','Completed',90),
(3,2,2,'2023-03-01','Completed',75),
(4,3,1,'2023-03-05','Completed',88),
(5,3,3,'2023-03-20','In Progress',70),
(6,4,4,'2023-04-01','Completed',92),
(7,5,2,'2023-05-01','Completed',65),
(8,6,1,'2023-06-01','Completed',95),
(9,6,3,'2023-06-10','Completed',89),
(10,7,4,'2023-07-01','In Progress',60),
(11,8,5,'2023-08-01','Completed',78);

INSERT INTO dbo.Payments VALUES
(1,1,'2023-02-01',1000),
(2,2,'2023-03-01',700),
(3,3,'2023-03-05',1200),
(4,4,'2023-04-01',800),
(5,5,'2023-05-01',600),
(6,6,'2023-06-01',1500),
(7,7,'2023-07-01',800),
(8,8,'2023-08-01',600);



--1. Students Paying Above Average Payment | Write a query to list students whose total payments are greater than the average total payment of all students.
select s.StudentName, p.amount 
        from Payments p join Students s
        on s.StudentID =p.StudentID
        where amount > (select avg(amount) as Avg_total_payment 
                                    from payments);



--2. Courses with Above Average Enrollment | Display courses that have more enrollments than the average enrollment count of all courses.
select coursename,courseid from Courses where courseid in (select courseid from Enrollments group by CourseID having count(CourseID) > (
select avg(a.course_en_cnt) as avg_course_en_cnt from (
select courseid,count(*) as course_en_cnt from Enrollments group by CourseID) as a));



--3. Top Instructor by Revenue | Find the instructor who generated the highest total revenue, where revenue = sum of course fees for enrolled students.
select InstructorName from Instructors where InstructorID = (select InstructorID from Courses where CourseID = (
select top 1 c.courseid
                    from courses c join (
                                        select courseid,count(*) as course_en_cnt 
                                        from Enrollments group by CourseID) as a 
                                        on c.CourseID=a.CourseID
                    order by a.course_en_cnt*c.CourseFee desc));



--4. Students Enrolled in More Courses Than Average | List students who are enrolled in more courses than the average number of courses per student.
select StudentName from Students where StudentID in (
select StudentID from Enrollments group by StudentID having count(*) > (
select avg(a.course_enrolled) as avg_count_enrol from (
select StudentID,count(*) as course_enrolled from Enrollments group by StudentID) as a  )
);


--5. Highest Paying Student Per Country | For each country, find the student who has paid the highest total amount.
USE Assignments
select StudentName,Country from students where country in (select s.Country,max(p.Amount) as highest_paid_by_country from Students s join Payments p on s.StudentID=p.StudentID group by s.Country);





select * from Students;
select * from Payments;
select * from Courses;
select * from Enrollments;
select * from Instructors;



--5. Highest Paying Student Per Country | For each country, find the student who has paid the highest total amount.






select * from Students;
select * from Courses;
select * from Enrollments;
select * from Instructors;
select * from Payments;