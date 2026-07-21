-- ==============================================================================
-- 1. TẠO DATABASE VÀ CHỌN DATABASE
-- ==============================================================================
IF DB_ID('AttendanceDB') IS NULL
BEGIN
    CREATE DATABASE AttendanceDB;
END
GO

USE AttendanceDB;
GO

-- ==============================================================================
-- 2. TẠO CẤU TRÚC CÁC BẢNG (TABLES)
-- ==============================================================================

-- Bảng Semester
IF OBJECT_ID('Semester', 'U') IS NULL
CREATE TABLE Semester (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SemesterCode NVARCHAR(20) UNIQUE NOT NULL, 
    SemesterName NVARCHAR(100) NOT NULL
);
GO

-- Bảng Course
IF OBJECT_ID('Course', 'U') IS NULL
CREATE TABLE Course (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CourseCode NVARCHAR(20) UNIQUE NOT NULL,
    CourseName NVARCHAR(255) NOT NULL,
    Credits INT NOT NULL
);
GO

-- Bảng Student
IF OBJECT_ID('Student', 'U') IS NULL
CREATE TABLE Student (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    StudentCode NVARCHAR(20) UNIQUE NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100)
);
GO

-- Bảng Teacher
IF OBJECT_ID('Teacher', 'U') IS NULL
CREATE TABLE Teacher (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TeacherCode NVARCHAR(20) UNIQUE NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100)
);
GO

-- Bảng Class
IF OBJECT_ID('Class', 'U') IS NULL
CREATE TABLE Class (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ClassCode NVARCHAR(50) NOT NULL,
    CourseId INT NOT NULL,
    SemesterId INT NOT NULL,
    FOREIGN KEY (CourseId) REFERENCES Course(Id),
    FOREIGN KEY (SemesterId) REFERENCES Semester(Id)
);
GO

-- Bảng Enrollment
IF OBJECT_ID('Enrollment', 'U') IS NULL
CREATE TABLE Enrollment (
    StudentId INT NOT NULL,
    ClassId INT NOT NULL,
    PRIMARY KEY (StudentId, ClassId),
    FOREIGN KEY (StudentId) REFERENCES Student(Id),
    FOREIGN KEY (ClassId) REFERENCES Class(Id)
);
GO

-- Bảng ClassSession
IF OBJECT_ID('ClassSession', 'U') IS NULL
CREATE TABLE ClassSession (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ClassId INT NOT NULL,
    TeacherId INT NOT NULL,
    SessionDate DATE NOT NULL,
    Room NVARCHAR(50),
    TimeSlot NVARCHAR(20),
    FOREIGN KEY (ClassId) REFERENCES Class(Id),
    FOREIGN KEY (TeacherId) REFERENCES Teacher(Id)
);
GO

-- Bảng Attendance
IF OBJECT_ID('Attendance', 'U') IS NULL
CREATE TABLE Attendance (
    SessionId INT NOT NULL,
    StudentId INT NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Present' CHECK (Status IN ('Present', 'Absent', 'ExcusedAbsent')), 
    Notes NVARCHAR(MAX),
    AttendanceTime DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (SessionId, StudentId),
    FOREIGN KEY (SessionId) REFERENCES ClassSession(Id),
    FOREIGN KEY (StudentId) REFERENCES Student(Id)
);
GO

-- ==============================================================================
-- 3. CHÈN DỮ LIỆU MẪU (DUMMY DATA)
-- ==============================================================================

-- Thêm dữ liệu vào bảng Semester
INSERT INTO Semester (SemesterCode, SemesterName) VALUES 
(N'FA26', N'Fall 2026'),
(N'SP27', N'Spring 2027');

-- Thêm dữ liệu vào bảng Course
INSERT INTO Course (CourseCode, CourseName, Credits) VALUES 
(N'INT3111', N'Database Systems', 3),
(N'PRF192', N'Programming Fundamentals', 3),
(N'SWE201', N'Software Engineering', 3);

-- Thêm dữ liệu vào bảng Student
INSERT INTO Student (StudentCode, FullName, Email) VALUES 
(N'HE180001', N'Nguyen Van A', N'anvhe180001@fpt.edu.vn'),
(N'HE180002', N'Tran Thi B', N'btthe180002@fpt.edu.vn'),
(N'HE180003', N'Le Van C', N'clvhe180003@fpt.edu.vn');

-- Thêm dữ liệu vào bảng Teacher
INSERT INTO Teacher (TeacherCode, FullName, Email) VALUES 
(N'TC001', N'Nguyen Hoang D', N'hoangd@fpt.edu.vn'),
(N'TC002', N'Pham Thi E', N'thiep@fpt.edu.vn');

-- Thêm dữ liệu vào bảng Class 
INSERT INTO Class (ClassCode, CourseId, SemesterId) VALUES 
(N'SE1801_INT3111', 1, 1),
(N'SE1802_PRF192', 2, 1);

-- Thêm dữ liệu vào bảng Enrollment
INSERT INTO Enrollment (StudentId, ClassId) VALUES 
(1, 1), 
(2, 1), 
(3, 2);

-- Thêm dữ liệu vào bảng ClassSession
INSERT INTO ClassSession (ClassId, TeacherId, SessionDate, Room, TimeSlot) VALUES 
(1, 1, '2026-09-01', N'Room 201', N'Slot 1'),
(1, 1, '2026-09-03', N'Room 201', N'Slot 1');

-- Thêm dữ liệu vào bảng Attendance
INSERT INTO Attendance (SessionId, StudentId, Status, Notes) VALUES 
(1, 1, N'Present', N'Good'),
(1, 2, N'Absent', N'Overslept');

INSERT INTO Attendance (SessionId, StudentId, Status, Notes) VALUES 
(2, 1, N'Present', N''),
(2, 2, N'ExcusedAbsent', N'Sick leave approved');
GO
