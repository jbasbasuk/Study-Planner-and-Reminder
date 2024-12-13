-- Create a new StudyPlannerReminder database
CREATE DATABASE StudyPlannerReminder;
-- created database
USE StudyPlannerReminder;

CREATE TABLE Users (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    registrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- this is to Insert sample data into Users table
INSERT INTO Users (firstName, lastName, email, password) 
VALUES 
('Alice', 'Smith', 'alice@example.com', 'password123'),
('Bob', 'Johnson', 'bob@example.com', 'password456'),
('Charlie', 'Brown', 'charlie.brown@example.com', 'password789'),
('Dana', 'White', 'dana.white@example.com', 'mypassword'),
('Eve', 'Black', 'eve.black@example.com', 'securepass'),
('Frank', 'Castle', 'frank.castle@example.com', 'punisher123'),
('Grace', 'Hopper', 'grace.hopper@example.com', 'computerscience'),
('Hank', 'Pym', 'hank.pym@example.com', 'antman'),
('Ivy', 'Walker', 'ivy.walker@example.com', 'naturelover'),
('Jack', 'Sparrow', 'jack.sparrow@example.com', 'pirateslife'),
('Karen', 'Page', 'karen.page@example.com', 'investigator'),
('Leo', 'Nardo', 'leo.nardo@example.com', 'artlover'),
('Mona', 'Lisa', 'mona.lisa@example.com', 'enigmatic'),
('Nina', 'Simone', 'nina.simone@example.com', 'musicislife'),
('Oscar', 'Wilde', 'oscar.wilde@example.com', 'witgenius'),
('Pam', 'Beesly', 'pam.beesly@example.com', 'officeartist'),
('Quincy', 'Adams', 'quincy.adams@example.com', 'historybuff'),
('Rachel', 'Green', 'rachel.green@example.com', 'fashionicon'),
('Sam', 'Winchester', 'sam.winchester@example.com', 'hunter1'),
('Tina', 'Fey', 'tina.fey@example.com', 'comedyqueen');

CREATE TABLE Tasks (
    taskID INT AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    dueDate DATE,
    status ENUM('Pending', 'Completed') DEFAULT 'Pending',
    FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE
);

-- Insert sample data into Tasks table
INSERT INTO Tasks (userID, title, description, dueDate) 
VALUES 
(1, 'Math Homework', 'Complete algebra problems', '2024-12-10'),
(2, 'Science Project', 'Build a model volcano', '2024-12-15'),
(3, 'History Essay', 'Write about the industrial revolution', '2024-12-20'),
(4, 'Biology Lab Report', 'Analyze plant growth data', '2024-12-18'),
(5, 'Physics Assignment', 'Solve problems on projectile motion', '2024-12-22'),
(6, 'Literature Analysis', 'Read and analyze "To Kill a Mockingbird"', '2024-12-25'),
(7, 'Art Sketch', 'Create a pencil sketch of a landscape', '2024-12-17'),
(8, 'Music Practice', 'Practice scales on the piano', '2024-12-12'),
(9, 'Coding Challenge', 'Solve a beginner-level algorithm problem', '2024-12-14'),
(10, 'Group Presentation', 'Prepare slides for climate change presentation', '2024-12-19'),
(11, 'French Vocabulary', 'Memorize 50 new French words', '2024-12-16'),
(12, 'Chemistry Quiz', 'Revise for the periodic table quiz', '2024-12-13'),
(13, 'Geography Map', 'Label all countries in South America', '2024-12-23'),
(14, 'Statistics Homework', 'Complete regression analysis problems', '2024-12-21'),
(15, 'Creative Writing', 'Write a short story on adventure', '2024-12-26'),
(16, 'Health Research', 'Research the benefits of a balanced diet', '2024-12-20'),
(17, 'Drama Script', 'Memorize lines for the school play', '2024-12-24'),
(18, 'Economics Presentation', 'Create a presentation on supply and demand', '2024-12-15'),
(19, 'Spanish Speaking', 'Practice speaking for oral exam', '2024-12-18'),
(20, 'Robotics Project', 'Assemble and program a small robot', '2024-12-28');

CREATE TABLE Reminders (
    reminderID INT AUTO_INCREMENT PRIMARY KEY,
    taskID INT NOT NULL,
    reminderDateTime DATETIME NOT NULL,
    message TEXT NOT NULL,
    FOREIGN KEY (taskID) REFERENCES Tasks(taskID) ON DELETE CASCADE
);

-- Insert sample data into Reminders table
INSERT INTO Reminders (taskID, reminderDateTime, message)
VALUES
(1, '2024-12-09 18:00:00', 'Don’t forget to finish your math homework!'),
(2, '2024-12-14 10:00:00', 'Prepare materials for the volcano project.'),
(3, '2024-12-19 15:00:00', 'Submit your history essay on the industrial revolution.'),
(4, '2024-12-17 08:00:00', 'Finalize the biology lab report analysis.'),
(5, '2024-12-21 20:00:00', 'Review physics notes on projectile motion.'),
(6, '2024-12-23 09:00:00', 'Complete reading and analysis of "To Kill a Mockingbird".'),
(7, '2024-12-16 14:00:00', 'Finish your art sketch for the exhibition.'),
(8, '2024-12-11 19:00:00', 'Practice piano scales for 30 minutes.'),
(9, '2024-12-13 11:00:00', 'Attempt the coding challenge on algorithms.'),
(10, '2024-12-18 10:00:00', 'Rehearse slides for the group presentation on climate change.'),
(11, '2024-12-15 17:00:00', 'Revise French vocabulary list of 50 words.'),
(12, '2024-12-12 13:00:00', 'Prepare for the periodic table chemistry quiz.'),
(13, '2024-12-22 16:00:00', 'Review geography notes and practice labeling maps.'),
(14, '2024-12-20 18:00:00', 'Double-check your answers on regression analysis problems.'),
(15, '2024-12-25 20:00:00', 'Finish the first draft of your short adventure story.'),
(16, '2024-12-19 14:00:00', 'Wrap up research on the benefits of a balanced diet.'),
(17, '2024-12-23 09:30:00', 'Memorize lines for the school play’s opening act.'),
(18, '2024-12-14 11:00:00', 'Prepare slides for your supply and demand economics presentation.'),
(19, '2024-12-17 13:00:00', 'Practice speaking Spanish sentences for the oral exam.'),
(20, '2024-12-27 08:00:00', 'Test and finalize the programming for your robot.');

CREATE TABLE courses (
    courseID INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- Insert example data into Courses table
INSERT INTO courses (course_name, course_description, start_date, end_date) 
VALUES 
('Math 101', 'Introduction to Mathematics', '2024-01-15', '2024-05-15'),
('IT 103', 'Introduction to Programming', '2024-02-10', '2024-04-10'),
('History 201', 'World History course', '2024-03-01', '2024-06-01');

CREATE TABLE IF NOT EXISTS StudySessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,  -- This column must exist to reference the courses table
    study_date DATE NOT NULL,
    study_time TIME NOT NULL,
    study_topic VARCHAR(255) NOT NULL,
    reminder_time DATETIME,
    FOREIGN KEY (course_id) REFERENCES Courses(courseID)  -- Correctly reference the courseID column in the Courses table
);

-- Insert sample data into StudySessions table
INSERT INTO StudySessions (course_id, study_date, study_time, study_topic, reminder_time)
VALUES
(1, '2024-12-01', '10:00:00', 'Algebra Review', '2024-12-01 09:30:00'),
(2, '2024-12-05', '14:00:00', 'Industrial Revolution Discussion', '2024-12-05 13:30:00'),
(1, '2024-12-03', '11:00:00', 'Calculus Practice', '2024-12-03 10:30:00'),
(2, '2024-12-06', '16:00:00', 'World War II Overview', '2024-12-06 15:30:00'),
(1, '2024-12-10', '09:00:00', 'Trigonometry Practice', '2024-12-10 08:30:00'),
(1, '2024-12-12', '13:00:00', 'Statistics Session', '2024-12-12 12:30:00'),
(2, '2024-12-15', '10:30:00', 'French Revolution Timeline', '2024-12-15 10:00:00'),
(1, '2024-12-18', '14:00:00', 'Geometry Review', '2024-12-18 13:30:00'),
(2, '2024-12-20', '17:00:00', 'Ancient Civilizations Exploration', '2024-12-20 16:30:00'),
(1, '2024-12-22', '15:00:00', 'Algebra Advanced Problems', '2024-12-22 14:30:00'),
(2, '2024-12-23', '18:00:00', 'Modern History: Key Events', '2024-12-23 17:30:00');

SELECT user, host FROM mysql.user;
DROP USER 'myuser'@'localhost';
CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON StudyPlannerReminder.* TO 'myuser'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'myuser'@'localhost';

-- Show created tables
SHOW TABLES;


