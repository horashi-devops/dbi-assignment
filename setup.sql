-- ==============================================================================
-- 1. TẠO DATABASE VÀ CHỌN DATABASE
-- ==============================================================================
CREATE DATABASE IF NOT EXISTS AttendanceDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE AttendanceDB;

-- ==============================================================================
-- 2. TẠO CẤU TRÚC CÁC BẢNG (TABLES)
-- ==============================================================================

-- Bảng Semester
CREATE TABLE IF NOT EXISTS Semester (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    SemesterCode VARCHAR(20) UNIQUE NOT NULL, 
    SemesterName VARCHAR(100) NOT NULL
);

-- Bảng Course
CREATE TABLE IF NOT EXISTS Course (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    CourseCode VARCHAR(20) UNIQUE NOT NULL,
    CourseName VARCHAR(255) NOT NULL,
    Credits INT NOT NULL
);

-- Bảng Student
CREATE TABLE IF NOT EXISTS Student (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    StudentCode VARCHAR(20) UNIQUE NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100)
);

-- Bảng Teacher
CREATE TABLE IF NOT EXISTS Teacher (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    TeacherCode VARCHAR(20) UNIQUE NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100)
);

-- Bảng Class
CREATE TABLE IF NOT EXISTS Class (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ClassCode VARCHAR(50) NOT NULL,
    CourseId INT NOT NULL,
    SemesterId INT NOT NULL,
    FOREIGN KEY (CourseId) REFERENCES Course(Id),
    FOREIGN KEY (SemesterId) REFERENCES Semester(Id)
);

-- Bảng Enrollment
CREATE TABLE IF NOT EXISTS Enrollment (
    StudentId INT NOT NULL,
    ClassId INT NOT NULL,
    PRIMARY KEY (StudentId, ClassId),
    FOREIGN KEY (StudentId) REFERENCES Student(Id),
    FOREIGN KEY (ClassId) REFERENCES Class(Id)
);

-- Bảng ClassSession
CREATE TABLE IF NOT EXISTS ClassSession (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ClassId INT NOT NULL,
    TeacherId INT NOT NULL,
    SessionDate DATE NOT NULL,
    Room VARCHAR(50),
    TimeSlot VARCHAR(20),
    FOREIGN KEY (ClassId) REFERENCES Class(Id),
    FOREIGN KEY (TeacherId) REFERENCES Teacher(Id)
);

-- Bảng Attendance
CREATE TABLE IF NOT EXISTS Attendance (
    SessionId INT NOT NULL,
    StudentId INT NOT NULL,
    Status ENUM('Present', 'Absent', 'ExcusedAbsent') DEFAULT 'Present', 
    Notes TEXT,
    AttendanceTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (SessionId, StudentId),
    FOREIGN KEY (SessionId) REFERENCES ClassSession(Id),
    FOREIGN KEY (StudentId) REFERENCES Student(Id)
);

-- ==============================================================================
-- 3. CHÈN DỮ LIỆU MẪU (DUMMY DATA)
-- ==============================================================================

-- Thêm dữ liệu vào bảng Semester
INSERT INTO Semester (SemesterCode, SemesterName) VALUES 
('FA26', 'Fall 2026'),
('SP27', 'Spring 2027');

-- Thêm dữ liệu vào bảng Course
INSERT INTO Course (CourseCode, CourseName, Credits) VALUES 
('INT3111', 'Database Systems', 3),
('PRF192', 'Programming Fundamentals', 3),
('SWE201', 'Software Engineering', 3);

-- Thêm dữ liệu vào bảng Student
INSERT INTO Student (StudentCode, FullName, Email) VALUES 
('HE180001', 'Nguyen Van A', 'anvhe180001@fpt.edu.vn'),
('HE180002', 'Tran Thi B', 'btthe180002@fpt.edu.vn'),
('HE180003', 'Le Van C', 'clvhe180003@fpt.edu.vn');

-- Thêm dữ liệu vào bảng Teacher
INSERT INTO Teacher (TeacherCode, FullName, Email) VALUES 
('TC001', 'Nguyen Hoang D', 'hoangd@fpt.edu.vn'),
('TC002', 'Pham Thi E', 'thiep@fpt.edu.vn');

-- Thêm dữ liệu vào bảng Class 
-- Giả sử: Lớp 1 học Database (Id=1) vào kỳ FA26 (Id=1), Lớp 2 học PRF192 (Id=2) vào kỳ FA26
INSERT INTO Class (ClassCode, CourseId, SemesterId) VALUES 
('SE1801_INT3111', 1, 1),
('SE1802_PRF192', 2, 1);

-- Thêm dữ liệu vào bảng Enrollment (Sinh viên đăng ký lớp)
-- Sinh viên A (Id=1) và B (Id=2) đăng ký lớp Database (Id=1)
-- Sinh viên C (Id=3) đăng ký lớp C Programming (Id=2)
INSERT INTO Enrollment (StudentId, ClassId) VALUES 
(1, 1), 
(2, 1), 
(3, 2);

-- Thêm dữ liệu vào bảng ClassSession (Tạo các buổi học)
-- Lớp Database (Id=1) do Thầy D (Id=1) dạy vào 2 ngày khác nhau
INSERT INTO ClassSession (ClassId, TeacherId, SessionDate, Room, TimeSlot) VALUES 
(1, 1, '2026-09-01', 'Room 201', 'Slot 1'),
(1, 1, '2026-09-03', 'Room 201', 'Slot 1');

-- Thêm dữ liệu vào bảng Attendance (Điểm danh sinh viên cho buổi học)
-- Buổi học thứ 1 (Id=1) của lớp Database: Sinh viên A (Id=1) có mặt, Sinh viên B (Id=2) vắng mặt
INSERT INTO Attendance (SessionId, StudentId, Status, Notes) VALUES 
(1, 1, 'Present', 'Good'),
(1, 2, 'Absent', 'Overslept');

-- Buổi học thứ 2 (Id=2) của lớp Database: Sinh viên A (Id=1) có mặt, Sinh viên B (Id=2) vắng có phép
INSERT INTO Attendance (SessionId, StudentId, Status, Notes) VALUES 
(2, 1, 'Present', ''),
(2, 2, 'ExcusedAbsent', 'Sick leave approved');