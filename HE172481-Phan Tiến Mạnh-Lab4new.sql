--Q1. Cho biết ai đang quản lý phòng ban có tên: Phòng Nghiên cứu và phát triển. Thông tin yêu cầu: mã số,họ tên nhân viên, mã số phòng ban, tên phòng ban
SELECT * FROM tbldepartment
SELECT empSSN, empName,tblDepartment.depName, tblDepartment.depNum FROM tblEmployee
JOIN tblDepartment on tblEmployee.empSSN = tblDepartment.mgrSSN
WHERE tblEmployee.depNum = 5

--Q2.	Cho phòng ban có tên: Phòng Nghiên cứu và phát triển hiện đang quản lý dự án nào. Thông tin yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lý
SELECT * FROM tblDepartment
SELECT proNum, proName , tblDepartment.depName FROM tblProject
right JOIN tbldepartment on tblProject.depnum = tbldepartment.depnum
where tbldepartment.depNum = 5

--Q3.	Cho biết dự án có tên ProjectB hiện đang được quản lý bởi phòng ban nào. Thông tin yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lý
SElECT proNum, proName, tblDepartment.depName FROM tblProject
Join tblDepartment on tblProject.depNum = tblDepartment.depnum
where tblProject.proName = 'ProjectB'

--Q4.	Cho biết những nhân viên nào đang bị giám sát bởi nhân viên có tên Mai Duy An. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên
SELECT empSSN, empName FROM tblemployee
WHERE supervisorSSN = (SELECT empSSN FROM tblEmployee WHERE empName = N'Mai Duy An')

--Q5.	Cho biết ai hiện đang giám sát những nhân viên có tên Mai Duy An. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên giám sát
SELECT empSSN, empName FROM tblEmployee
WHERE empSSN = (SELECT supervisorSSN FROM tblEmployee WHERE empName = N'Mai Duy An')

--Q6.	Cho biết dự án có tên ProjectA hiện đang làm việc ở đâu. Thông tin yêu cầu: mã số, tên vị trí làm việc.
SELECT proName,tblLocation.locNum, tblLocation.locName FROM tblProject
Join tblLocation on tblLocation.locNum = tblProject.locNum 
WHERE tblProject.proName = N'ProjectA'

--Q7.	Cho biết vị trí làm việc có tên Tp. HCM hiện đang là chỗ làm việc của những dự án nào. Thông tin yêu cầu: mã số, tên dự án
SELECT locName, tblProject.proNum, tblProject.proName FROM tblLocation
Join tblProject on tblProject.locNum = tblLocation.locNum
WHERE tblLocation.locNum = 5

--Q8.	Cho biết những người phụ thuộc trên 18 tuổi. Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào.
SELECT tblDependent.depName, tblDependent.depBirthdate, tblemployee.empName FROM tblDependent
INNER JOIN tblEmployee ON tblDependent.empSSN = tblEmployee.empSSN
WHERE DATEDIFF(year, tblDependent.depBirthdate, GETDATE()) > 18

--Q9.	Cho biết những người phụ thuộc  là nam giới. Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào 
SELECT depName, depBirthdate, tblEmployee.empName FROM tblDependent
INNER JOIN tblEmployee ON tblDependent.empSSN= tblEmployee.empSSN
WHERE tblDependent.depSex = 'M'

--Q10. Cho biết những nơi làm việc của phòng ban có tên : Phòng Nghiên cứu và phát triển. Thông tin yêu cầu: mã phòng ban, tên phòng ban, tên nơi làm việc.
SELECT d.depNum AS [Mã phòng ban], d.depName AS [Tên phòng ban], l.locName AS [Tên nơi làm việc]
FROM tblDepartment d
JOIN tblDepLocation dl ON d.depNum = dl.depNum
JOIN tblLocation l ON dl.locNum = l.locNum
WHERE d.depName = N'Phòng Nghiên cứu và phát triển';
--Q11.	Cho biết các dự án làm việc tại Tp. HCM. Thông tin yêu cầu: mã dự án, tên dự án, tên phòng ban chịu trách nhiệm dự án.
SELECT p.proNum AS [Mã dự án], p.proName AS [Tên dự án], d.depName AS [Tên phòng ban chịu trách nhiệm dự án]
FROM tblProject p
JOIN tblDepartment d ON p.depNum = d.depNum
JOIN tblLocation l ON p.locNum = l.locNum
WHERE l.locName = 'Tp. HCM';
--Q12.	Cho biết những người phụ thuộc là nữ giới, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển . Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ giữa người phụ thuộc với nhân viên 
SELECT e.empName AS [Tên nhân viên], d.depName AS [Tên người phụ thuộc], d.depRelationship AS [Mối liên hệ]
FROM tblDependent d
JOIN tblEmployee e ON d.empSSN = e.empSSN
JOIN tblDepartment dep ON e.depNum = dep.depNum
WHERE d.depSex = 'F' AND dep.depName = N'Phòng Nghiên cứu và phát triển';
--Q13.	Cho biết những người phụ thuộc trên 18 tuổi, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển. Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc, mối liên hệ giữa người phụ thuộc với nhân viên 
SELECT e.empName AS [Tên nhân viên], d.depName AS [Tên người phụ thuộc], d.depRelationship AS [Mối liên hệ]
FROM tblDependent d
JOIN tblEmployee e ON d.empSSN = e.empSSN
JOIN tblDepartment dep ON e.depNum = dep.depNum
WHERE DATEDIFF(YEAR, d.depBirthdate, GETDATE()) > 18 AND dep.depName = N'Phòng Nghiên cứu và phát triển';
--Q14.	Cho biết số lượng người phụ thuộc theo giới tính. Thông tin yêu cầu: giới tính, số lượng người phụ thuộc
SELECT d.depSex AS [Giới tính], COUNT(*) AS [Số lượng người phụ thuộc]
FROM tblDependent d
GROUP BY d.depSex;
--Q15.	Cho biết số lượng người phụ thuộc theo mối liên hệ với nhân viên. Thông tin yêu cầu: mối liên hệ, số lượng người phụ thuộc
SELECT d.depRelationship AS [Mối liên hệ], COUNT(*) AS [Số lượng người phụ thuộc]
FROM tblDependent d
GROUP BY d.depRelationship;
--Q16.	Cho biết số lượng người phụ thuộc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT d.depNum, d.depName, COUNT(dep.depName) AS SoLuongNguoiPhuThuoc
FROM dbo.tblDepartment d
LEFT JOIN dbo.tblDependent dep ON d.depNum = dep.empSSN
GROUP BY d.depNum, d.depName;
--Q17.	Cho biết phòng ban nào có số lượng người phụ thuộc là ít nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT TOP 1 d.depNum, d.depName, COUNT(dep.depName) AS SoLuongNguoiPhuThuoc
FROM dbo.tblDepartment d
LEFT JOIN dbo.tblDependent dep ON d.depNum = dep.empSSN
GROUP BY d.depNum, d.depName
ORDER BY COUNT(dep.depName) ASC;
--Q18.	Cho biết phòng ban nào có số lượng người phụ thuộc là nhiều nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT TOP 1 d.depNum, d.depName, COUNT(dep.depName) AS SoLuongNguoiPhuThuoc
FROM dbo.tblDepartment d
LEFT JOIN dbo.tblDependent dep ON d.depNum = dep.empSSN
GROUP BY d.depNum, d.depName
ORDER BY COUNT(dep.depName) DESC;
--Q19.	Cho biết tổng số giờ tham gia dự án của mỗi nhân viên. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT w.empSSN AS MaNhanVien, e.empName AS TenNhanVien, d.depName AS TenPhongBan, SUM(w.workHours) AS TongSoGio
FROM dbo.tblWorksOn w
INNER JOIN dbo.tblEmployee e ON w.empSSN = e.empSSN
INNER JOIN dbo.tblDepartment d ON e.depNum = d.depNum
GROUP BY w.empSSN, e.empName, d.depName;
--Q20.	Cho biết tổng số giờ làm dự án của mỗi phòng ban. Thông tin yêu cầu: mã phòng ban,  tên phòng ban, tổng số giờ
SELECT d.depNum AS MaPhongBan, d.depName AS TenPhongBan, SUM(w.workHours) AS TongSoGio
FROM dbo.tblWorksOn w
INNER JOIN dbo.tblEmployee e ON w.empSSN = e.empSSN
INNER JOIN dbo.tblDepartment d ON e.depNum = d.depNum
GROUP BY d.depNum, d.depName;
--Q21.	Cho biết nhân viên nào có số giờ tham gia dự án là ít nhất. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án
SELECT TOP 1 w.empSSN AS MaNhanVien, e.empName AS TenNhanVien, SUM(w.workHours) AS TongSoGioThamGia
FROM dbo.tblWorksOn w
INNER JOIN dbo.tblEmployee e ON w.empSSN = e.empSSN
GROUP BY w.empSSN, e.empName
ORDER BY SUM(w.workHours) ASC;
--Q22.	Cho biết nhân viên nào có số giờ tham gia dự án là nhiều nhất. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án
SELECT TOP 1 w.empSSN AS MaNhanVien, e.empName AS TenNhanVien, SUM(w.workHours) AS TongSoGioThamGia
FROM dbo.tblWorksOn w
INNER JOIN dbo.tblEmployee e ON w.empSSN = e.empSSN
GROUP BY w.empSSN, e.empName
ORDER BY SUM(w.workHours) DESC;
--Q23.	Cho biết những nhân viên nào lần đầu tiên tham gia dụ án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT w.empSSN AS MaNhanVien, e.empName AS TenNhanVien, d.depName AS TenPhongBan
FROM dbo.tblWorksOn w
INNER JOIN dbo.tblEmployee e ON w.empSSN = e.empSSN
INNER JOIN dbo.tblDepartment d ON e.depNum = d.depNum
WHERE w.empSSN IN (
    SELECT empSSN
    FROM dbo.tblWorksOn
    GROUP BY empSSN
    HAVING COUNT(*) = 1
);
--Q24.	Cho biết những nhân viên nào lần thứ hai tham gia dụ án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT w.empSSN AS MaNhanVien, e.empName AS TenNhanVien, d.depName AS TenPhongBan
FROM dbo.tblWorksOn w
INNER JOIN dbo.tblEmployee e ON w.empSSN = e.empSSN
INNER JOIN dbo.tblDepartment d ON e.depNum = d.depNum
WHERE w.empSSN IN (
    SELECT empSSN
    FROM dbo.tblWorksOn
    GROUP BY empSSN
    HAVING COUNT(*) > 1
);
--Q25.	Cho biết những nhân viên nào tham gia tối thiểu hai dự án. Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT w.empSSN AS MaNhanVien, e.empName AS TenNhanVien, d.depName AS TenPhongBan
FROM dbo.tblWorksOn w
INNER JOIN dbo.tblEmployee e ON w.empSSN = e.empSSN
INNER JOIN dbo.tblDepartment d ON e.depNum = d.depNum
WHERE w.empSSN IN (
    SELECT empSSN
    FROM dbo.tblWorksOn
    GROUP BY empSSN
    HAVING COUNT(*) >= 2
);
--Q26.	Cho biết số lượng thành viên của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
SELECT P.proNum AS MaDuAn , P.proName AS Tenduan, COUNT(W.empSSN) AS Soluongthanhvien
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName;
--Q27.	Cho biết tổng số giờ làm của mỗi dự án. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
SELECT P.proNum as Maduan, P.proName as Tenduan, SUM(W.workHours) AS TongSoGioLam
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName;
--Q28.	Cho biết dự án nào có số lượng thành viên là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
SELECT P.proNum as Maduan, P.proName as Tenduan, COUNT(W.empSSN) AS SoLuongThanhVien
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
HAVING COUNT(W.empSSN) = (
    SELECT MIN(MemberCount)
    FROM (
        SELECT COUNT(W.empSSN) AS MemberCount
        FROM tblProject P
        LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
        GROUP BY P.proNum, P.proName
    ) AS Subquery
);
--Q29.	Cho biết dự án nào có số lượng thành viên là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
SELECT P.proNum as Maduan, P.proName as Tenduan, COUNT(W.empSSN) AS SoLuongThanhVien
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
HAVING COUNT(W.empSSN) = (
    SELECT MAX(MemberCount)
    FROM (
        SELECT COUNT(W.empSSN) AS MemberCount
        FROM tblProject P
        LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
        GROUP BY P.proNum, P.proName
    ) AS Subquery
);
--Q30.	Cho biết dự án nào có tổng số giờ làm là ít nhất. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
SELECT P.proNum as Maduan, P.proName as Tenduan, SUM(W.workHours) AS TongSoGioLam
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
HAVING SUM(W.workHours) = (
    SELECT MIN(TotalWorkHours)
    FROM (
        SELECT SUM(W.workHours) AS TotalWorkHours
        FROM tblProject P
        LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
        GROUP BY P.proNum, P.proName
    ) AS Subquery
);
--Q31.	Cho biết dự án nào có tổng số giờ làm là nhiều nhất. Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
SELECT P.proNum as Maduan, P.proName as Tenduan, SUM(W.workHours) AS TongSoGioLam
FROM tblProject P
LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
GROUP BY P.proNum, P.proName
HAVING SUM(W.workHours) = (
    SELECT MAX(TotalWorkHours)
    FROM (
        SELECT SUM(W.workHours) AS TotalWorkHours
        FROM tblProject P
        LEFT JOIN tblWorksOn W ON P.proNum = W.proNum
        GROUP BY P.proNum, P.proName
    ) AS Subquery
);
--Q32.	Cho biết số lượng phòng ban làm việc theo mỗi nơi làm việc. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
SELECT L.locName AS [Tên nơi làm việc], COUNT(DISTINCT D.depNum) AS [Số lượng phòng ban]
FROM tblLocation L
LEFT JOIN tblDepLocation DL ON L.locNum = DL.locNum
LEFT JOIN tblDepartment D ON DL.depNum = D.depNum
GROUP BY L.locName;
--Q33.	Cho biết số lượng chỗ làm việc theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
SELECT D.depNum as [Mã phòng ban], D.depName as [Tên phòng ban] , COUNT(DL.locNum) AS [Số lượng chỗ làm việc]
FROM tblDepartment D
LEFT JOIN tblDepLocation DL ON D.depNum = DL.depNum
GROUP BY D.depNum, D.depName;
--Q34.	Cho biết phòng ban nào có nhiều chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
SELECT D.depNum as [Mã phòng ban], D.depName as [Tên phòng ban] , COUNT(DL.locNum) AS [Số lượng chỗ làm việc]
FROM tblDepartment D
LEFT JOIN tblDepLocation DL ON D.depNum = DL.depNum
GROUP BY D.depNum, D.depName
HAVING COUNT(DL.locNum) = (
    SELECT MAX(WorkplaceCount)
    FROM (
        SELECT COUNT(DL.locNum) AS WorkplaceCount
        FROM tblDepartment D
        LEFT JOIN tblDepLocation DL ON D.depNum = DL.depNum
        GROUP BY D.depNum, D.depName
    ) AS Subquery
);
--Q35.	Cho biết phòng ban nào có it chỗ làm việc nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
SELECT D.depNum as [Mã phòng ban], D.depName as [Tên phòng ban] , COUNT(DL.locNum) AS [Số lượng chỗ làm việc]
FROM tblDepartment D
LEFT JOIN tblDepLocation DL ON D.depNum = DL.depNum
GROUP BY D.depNum, D.depName
HAVING COUNT(DL.locNum) = (
    SELECT MIN(WorkplaceCount)
    FROM (
        SELECT COUNT(DL.locNum) AS WorkplaceCount
        FROM tblDepartment D
        LEFT JOIN tblDepLocation DL ON D.depNum = DL.depNum
        GROUP BY D.depNum, D.depName
    ) AS Subquery
);
--Q36.	Cho biết địa điểm nào có nhiều phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
SELECT L.locName AS [Tên nơi làm việc], COUNT(DL.depNum) AS [Số lượng phòng ban]
FROM tblLocation L
LEFT JOIN tblDepLocation DL ON L.locNum = DL.locNum
GROUP BY L.locName
HAVING COUNT(DL.depNum) = (
    SELECT MAX(DepartmentCount)
    FROM (
        SELECT COUNT(DL.depNum) AS DepartmentCount
        FROM tblLocation L
        LEFT JOIN tblDepLocation DL ON L.locNum = DL.locNum
        GROUP BY L.locName
    ) AS Subquery
);
--Q37.	Cho biết địa điểm nào có ít phòng ban làm việc nhất. Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban		
SELECT L.locName AS [Tên nơi làm việc], COUNT(DL.depNum) AS [Số lượng phòng ban]
FROM tblLocation L
LEFT JOIN tblDepLocation DL ON L.locNum = DL.locNum
GROUP BY L.locName
HAVING COUNT(DL.depNum) = (
    SELECT MIN(DepartmentCount)
    FROM (
        SELECT COUNT(DL.depNum) AS DepartmentCount
        FROM tblLocation L
        LEFT JOIN tblDepLocation DL ON L.locNum = DL.locNum
        GROUP BY L.locName
    ) AS Subquery
);
--Q38.	Cho biết nhân viên nào có nhiều người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc
SELECT E.empSSN as [Mã số], E.empName as [Họ tên nhân viên], COUNT(D.depName) AS SoLuongNguoiPhuThuoc
FROM tblEmployee E
LEFT JOIN tblDependent D ON E.empSSN = D.empSSN
GROUP BY E.empSSN, E.empName
HAVING COUNT(D.depName) = (
    SELECT MAX(DependentCount)
    FROM (
        SELECT COUNT(D.depName) AS DependentCount
        FROM tblEmployee E
        LEFT JOIN tblDependent D ON E.empSSN = D.empSSN
        GROUP BY E.empSSN
    ) AS Subquery
);
--Q39.	Cho biết nhân viên nào có ít người phụ thuộc nhất. Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc
SELECT E.empSSN as [Mã số], E.empName as [Họ tên nhân viên], COUNT(D.depName) AS SoLuongNguoiPhuThuoc
FROM tblEmployee E
LEFT JOIN tblDependent D ON E.empSSN = D.empSSN
GROUP BY E.empSSN, E.empName
HAVING COUNT(D.depName) = (
    SELECT MIN(DependentCount)
    FROM (
        SELECT COUNT(D.depName) AS DependentCount
        FROM tblEmployee E
        LEFT JOIN tblDependent D ON E.empSSN = D.empSSN
        GROUP BY E.empSSN
    ) AS Subquery
);
--Q40.	Cho biết nhân viên nào không có người phụ thuộc. Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên, tên phòng ban của nhân viên
SELECT E.empSSN as [Mã số nhân viên], E.empName [Họ tên nhân viên], D.depName AS [Tên phòng ban]
FROM tblEmployee E
LEFT JOIN tblDependent D ON E.empSSN = D.empSSN
WHERE D.depName IS NULL;

--Q41.	Cho biết phòng ban nào không có người phụ thuộc. Thông tin yêu cầu: mã số phòng ban, tên phòng ban
SELECT [depNum], [depName] 
FROM [dbo].[tblDepartment] 
WHERE [depNum] NOT IN (SELECT DISTINCT [depNum] FROM [dbo].[tblDependent])
--Q42.	Cho biết những nhân viên nào chưa hề tham gia vào bất kỳ dự án nào. Thông tin yêu cầu: mã số, tên nhân viên, tên phòng ban của nhân viên
SELECT e.empSSN, e.empName, d.depName
FROM dbo.tblEmployee e LEFT JOIN dbo.tblWorksOn w ON e.empSSN = w.empSSN
INNER JOIN dbo.tblDepartment d ON e.depNum = d.depNum
WHERE w.empSSN IS NULL
--Q43.	Cho biết phòng ban không có nhân viên nào tham gia (bất kỳ) dự án. Thông tin yêu cầu: mã số phòng ban, tên phòng ban
SELECT d.depNum, d.depName
FROM tblDepartment d
WHERE NOT EXISTS(
    SELECT *
    FROM tblEmployee e
    JOIN tblWorksOn w ON e.empSSN = w.empSSN
    WHERE e.depNum = d.depNum
)
--Q44.	Cho biết phòng ban không có nhân viên nào tham gia vào dự án có tên là ProjectA. Thông tin yêu cầu: mã số phòng ban, tên phòng ban
SELECT DISTINCT d.depNum, d.depName 
FROM tblDepartment d 
LEFT JOIN tblEmployee e ON d.depNum = e.depNum 
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN 
LEFT JOIN tblProject p ON w.proNum = p.proNum 
WHERE p.proName = 'ProjectA' AND e.empSSN IS NULL
--Q45.	Cho biết số lượng dự án được quản lý theo mỗi phòng ban. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
SELECT d.depNum, d.depName, COUNT(p.proNum) AS 'totalProjects'
FROM tblDepartment d 
LEFT JOIN tblProject p ON d.depNum = p.depNum
GROUP BY d.depNum, d.depName
--Q46.	Cho biết phòng ban nào quản lý it dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
SELECT TOP 1 d.depNum, d.depName, COUNT(p.proNum) AS numProjects
FROM tblDepartment d
LEFT JOIN tblProject p ON d.depNum = p.depNum
GROUP BY d.depNum, d.depName
ORDER BY numProjects ASC;
--Q47.	Cho biết phòng ban nào quản lý nhiều dự án nhất. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
SELECT TOP 1 dep.depNum, dep.depName, COUNT(proj.proNum) AS numOfProjects
FROM tblDepartment dep
INNER JOIN tblProject proj ON dep.depNum = proj.depNum
GROUP BY dep.depNum, dep.depName
ORDER BY COUNT(proj.proNum) DESC
--Q48.	Cho biết những phòng ban nào có nhiểu hơn 5 nhân viên đang quản lý dự án gì. Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng nhân viên của phòng ban, tên dự án quản lý
SELECT dep.depNum, dep.depName, COUNT(emp.empSSN) as numEmp, pro.proName
FROM tblDepartment dep
INNER JOIN tblEmployee emp ON dep.depNum = emp.depNum
INNER JOIN tblWorksOn w ON emp.empSSN = w.empSSN
INNER JOIN tblProject pro ON w.proNum = pro.proNum
GROUP BY dep.depNum, dep.depName, pro.proName
HAVING COUNT(emp.empSSN) > 5
--Q49.	Cho biết những nhân viên thuộc phòng có tên là Phòng nghiên cứu, và không có người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên
SELECT empSSN, empName
FROM tblEmployee
WHERE depNum = (SELECT depNum FROM tblDepartment WHERE depName='Phòng nghiên cứu') AND empSSN NOT IN (SELECT empSSN FROM tblDependent)
--Q50.	Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này không có người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, tổng số giờ làm
SELECT e.empSSN, e.empName, SUM(w.workHours) AS TotalHours
FROM tblEmployee e
LEFT JOIN tblWorksOn w ON e.empSSN = w.empSSN
LEFT JOIN tblDependent d ON e.empSSN = d.empSSN
WHERE d.depName IS NULL
GROUP BY e.empSSN, e.empName
--Q51.	Cho biết tổng số giờ làm của các nhân viên, mà các nhân viên này có nhiều hơn 3 người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, số lượng người phụ thuộc, tổng số giờ làm
SELECT e.empSSN, e.empName, COUNT(d.depName) AS numDependents, SUM(w.workHours) AS totalWorkHours
FROM tblEmployee e
JOIN tblDependent d ON e.empSSN = d.empSSN
JOIN tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY e.empSSN, e.empName
HAVING COUNT(d.depName) > 3
--Q52.	Cho biết tổng số giờ làm việc của các nhân viên hiện đang dưới quyền giám sát (bị quản lý bởi) của nhân viên Mai Duy An. Thông tin yêu cầu: mã nhân viên, họ tên nhân viên, tổng số giờ làm
SELECT e.empSSN, e.empName, SUM(w.workHours) as TotalWorkHours
FROM tblEmployee e
INNER JOIN tblWorksOn w ON e.empSSN = w.empSSN
WHERE e.supervisorSSN = (SELECT empSSN FROM tblEmployee WHERE empName = 'Mai Duy An')
GROUP BY e.empSSN, e.empName