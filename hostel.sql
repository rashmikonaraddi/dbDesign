CREATE DATABASE hostel_db;
USE hostel_db;

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE Student_Phone (
    phone_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    phone_number VARCHAR(15),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Hostel (
    hostel_id INT AUTO_INCREMENT PRIMARY KEY,
    hostel_name VARCHAR(100)
);

CREATE TABLE Room (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    hostel_id INT,
    capacity INT,
    FOREIGN KEY (hostel_id) REFERENCES Hostel(hostel_id)
);

CREATE TABLE Room_Allocation (
    allocation_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    room_id INT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

CREATE TABLE Warden (
    warden_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    hostel_id INT,
    FOREIGN KEY (hostel_id) REFERENCES Hostel(hostel_id)
);

CREATE TABLE Maintenance_Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50)
);

CREATE TABLE Complaint (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    staff_id INT,
    description TEXT,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP NULL,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (staff_id) REFERENCES Maintenance_Staff(staff_id)
);

INSERT INTO Hostel (hostel_name) VALUES 
('Girls Hostel'),
('Boys Hostel');

INSERT INTO Room (hostel_id, capacity) VALUES 
(1, 2),
(1, 3),
(2, 2);

INSERT INTO Student (name, email) VALUES 
('Rashmi', 'rashmi@email.com'),
('Shreya', 'amit@email.com');

INSERT INTO Student_Phone (student_id, phone_number) VALUES 
(1, '9876543210'),
(1, '9123456780'),
(2, '9988776655');

INSERT INTO Room_Allocation (student_id, room_id) VALUES 
(1, 1),
(2, 2);

INSERT INTO Warden (name, hostel_id) VALUES 
('Anita', 1),
('Sharma', 2);

INSERT INTO Maintenance_Staff (name, role) VALUES 
('Ravi', 'Electrician'),
('Suresh', 'Plumber');

INSERT INTO Complaint (student_id, staff_id, description, status) VALUES 
(1, 1, 'Fan not working', 'Pending'),
(2, 2, 'Water leakage', 'Resolved');

SELECT s.name, r.room_id, h.hostel_name
FROM Student s
JOIN Room_Allocation ra ON s.student_id = ra.student_id
JOIN Room r ON ra.room_id = r.room_id
JOIN Hostel h ON r.hostel_id = h.hostel_id;

SELECT s.name, c.description, c.status, m.name AS staff_name
FROM Complaint c
JOIN Student s ON c.student_id = s.student_id
JOIN Maintenance_Staff m ON c.staff_id = m.staff_id;

SELECT h.hostel_name, w.name AS warden
FROM Hostel h
JOIN Warden w ON h.hostel_id = w.hostel_id;

SELECT s.name, sp.phone_number
FROM Student s
JOIN Student_Phone sp ON s.student_id = sp.student_id;