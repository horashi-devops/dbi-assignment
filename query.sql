-- ==============================================================================
-- FILE: query.sql
-- MỤC ĐÍCH: Chứa các câu lệnh truy vấn dữ liệu từ AttendanceDB (SQL Server)
-- ==============================================================================

USE AttendanceDB;
GO

-- ------------------------------------------------------------------------------
-- 1. Xem danh sách sinh viên của một lớp cụ thể (VD: lớp 'SE1801_INT3111')
-- ------------------------------------------------------------------------------
SELECT 
    c.ClassCode, 
    s.StudentCode, 
    s.FullName AS StudentName, 
    s.Email
FROM Class c
JOIN Enrollment e ON c.Id = e.ClassId
JOIN Student s ON e.StudentId = s.Id
WHERE c.ClassCode = N'SE1801_INT3111';
GO

-- ------------------------------------------------------------------------------
-- 2. Thống kê sĩ số sinh viên của từng lớp học
-- ------------------------------------------------------------------------------
SELECT 
    c.ClassCode, 
    co.CourseName, 
    sem.SemesterCode,
    COUNT(e.StudentId) AS TotalStudents
FROM Class c
JOIN Course co ON c.CourseId = co.Id
JOIN Semester sem ON c.SemesterId = sem.Id
LEFT JOIN Enrollment e ON c.Id = e.ClassId
GROUP BY c.Id, c.ClassCode, co.CourseName, sem.SemesterCode;
GO

-- ------------------------------------------------------------------------------
-- 3. Xem lịch giảng dạy của một giảng viên (VD: thầy có mã 'TC001')
-- ------------------------------------------------------------------------------
SELECT 
    t.FullName AS TeacherName, 
    c.ClassCode, 
    co.CourseName,
    cs.SessionDate, 
    cs.Room, 
    cs.TimeSlot
FROM ClassSession cs
JOIN Teacher t ON cs.TeacherId = t.Id
JOIN Class c ON cs.ClassId = c.Id
JOIN Course co ON c.CourseId = co.Id
WHERE t.TeacherCode = N'TC001'
ORDER BY cs.SessionDate ASC, cs.TimeSlot ASC;
GO

-- ------------------------------------------------------------------------------
-- 4. Xem chi tiết lịch sử điểm danh của một sinh viên trong một lớp
-- (VD: Sinh viên 'HE180001' học lớp 'SE1801_INT3111')
-- ------------------------------------------------------------------------------
SELECT 
    s.StudentCode,
    s.FullName,
    cs.SessionDate,
    cs.TimeSlot,
    a.Status AS AttendanceStatus,
    a.Notes
FROM Attendance a
JOIN Student s ON a.StudentId = s.Id
JOIN ClassSession cs ON a.SessionId = cs.Id
JOIN Class c ON cs.ClassId = c.Id
WHERE s.StudentCode = N'HE180001' 
  AND c.ClassCode = N'SE1801_INT3111'
ORDER BY cs.SessionDate ASC;
GO

-- ------------------------------------------------------------------------------
-- 5. Báo cáo tổng hợp: Đếm số buổi vắng mặt (Absent) của từng sinh viên
-- ------------------------------------------------------------------------------
SELECT 
    s.StudentCode, 
    s.FullName, 
    c.ClassCode,
    COUNT(a.SessionId) AS TotalAbsences
FROM Student s
JOIN Attendance a ON s.Id = a.StudentId
JOIN ClassSession cs ON a.SessionId = cs.Id
JOIN Class c ON cs.ClassId = c.Id
WHERE a.Status = N'Absent'
GROUP BY s.Id, s.StudentCode, s.FullName, c.ClassCode
ORDER BY TotalAbsences DESC;
GO

-- ------------------------------------------------------------------------------
-- 6. Xem danh sách các buổi học chưa được điểm danh (dành cho Giảng viên kiểm tra)
-- Giả sử buổi học đã diễn ra trong quá khứ nhưng chưa có bản ghi trong bảng Attendance
-- ------------------------------------------------------------------------------
SELECT 
    cs.Id AS SessionId,
    c.ClassCode,
    cs.SessionDate,
    cs.TimeSlot,
    t.FullName AS TeacherName
FROM ClassSession cs
JOIN Class c ON cs.ClassId = c.Id
JOIN Teacher t ON cs.TeacherId = t.Id
LEFT JOIN Attendance a ON cs.Id = a.SessionId
WHERE a.SessionId IS NULL 
  AND cs.SessionDate < CAST(GETDATE() AS DATE);
GO
