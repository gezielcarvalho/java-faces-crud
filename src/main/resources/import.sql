-- Connect to the helpdesk database
USE helpdesk;

-- Create the tickets table (if not already created by Hibernate)
CREATE TABLE IF NOT EXISTS tickets (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status ENUM('OPEN', 'IN_PROGRESS', 'RESOLVED', 'CLOSED') DEFAULT 'OPEN',
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data into the tickets table
INSERT INTO tickets (title, description, status, createdDate) VALUES
('System Crash on Login', 'User reports that the system crashes when attempting to log in.', 'OPEN', '2023-10-01 10:15:00'),
('Email Delivery Failure', 'Customer emails are not being sent from the application.', 'IN_PROGRESS', '2023-10-02 14:30:00'),
('Password Reset Not Working', 'Users are unable to reset their passwords.', 'RESOLVED', '2023-10-03 09:00:00'),
('Database Timeout Error', 'System experiences timeouts during peak hours.', 'IN_PROGRESS', '2023-10-04 11:20:00'),
('UI Display Issue on Mobile', 'The main screen is not displaying properly on mobile devices.', 'OPEN', '2023-10-05 15:45:00'),
('Feature Request: Dark Mode', 'Request to add dark mode for the app.', 'CLOSED', '2023-10-06 13:15:00');
