CREATE DATABASE CareerHub;
USE CareerHub;
CREATE TABLE Companies (
    CompanyID INT,
    CompanyName VARCHAR(100),
    Location VARCHAR(100),
    PRIMARY KEY (CompanyID)
);

CREATE TABLE Jobs (
    JobID INT,
    CompanyID INT,
    JobTitle VARCHAR(100),
    JobDescription TEXT,
    JobLocation VARCHAR(100),
    Salary DECIMAL(10, 2),
    JobType VARCHAR(50),
    PostedDate DATETIME,
    PRIMARY KEY (JobID),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

CREATE TABLE Applicants (
    ApplicantID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Resume TEXT,
    PRIMARY KEY (ApplicantID)
);

CREATE TABLE Applications (
    ApplicationID INT,
    JobID INT,
    ApplicantID INT,
    ApplicationDate DATETIME,
    CoverLetter TEXT,
    PRIMARY KEY (ApplicationID),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);
 
-- 1. Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”.
CREATE DATABASE CareerHub;

-- 2. Create tables for Companies, Jobs, Applicants and Applications.
-- 3. Define appropriate primary keys, foreign keys, and constraints.
CREATE TABLE Companies (
    CompanyID INT,
    CompanyName VARCHAR(100),
    Location VARCHAR(100),
    PRIMARY KEY (CompanyID)
);

CREATE TABLE Jobs (
    JobID INT,
    CompanyID INT,
    JobTitle VARCHAR(100),
    JobDescription TEXT,
    JobLocation VARCHAR(100),
    Salary DECIMAL(10, 2),
    JobType VARCHAR(50),
    PostedDate DATETIME,
    PRIMARY KEY (JobID),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

CREATE TABLE Applicants (
    ApplicantID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Resume TEXT,
    PRIMARY KEY (ApplicantID)
);

CREATE TABLE Applications (
    ApplicationID INT,
    JobID INT,
    ApplicantID INT,
    ApplicationDate DATETIME,
    CoverLetter TEXT,
    PRIMARY KEY (ApplicationID),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);
-- 4. Ensure the script handles potential errors, such as if the database or tables already exist.
CREATE DATABASE IF NOT EXISTS CareerHub;
CREATE TABLE IF NOT EXISTS Companies (
    CompanyID INT,
    CompanyName VARCHAR(100),
    Location VARCHAR(100),
    PRIMARY KEY (CompanyID)
);
-- 5. Write an SQL query to count the number of applications received for each job listing in the "Jobs" table.Display the job title and the corresponding application count. Ensure that it lists all jobs, even if they have no applications.
SELECT JobTitle, COUNT(ApplicationID) 
FROM Jobs
LEFT JOIN Applications ON Jobs.JobID = Applications.JobID
GROUP BY Jobs.JobID;

-- 6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary range.Allow parameters for the minimum and maximum salary values. Display the job title, company name, location, and salary for each matching job.
SELECT j.JobTitle, c.CompanyName, j.JobLocation, j.Salary
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary BETWEEN 40000 AND 70000;

-- 7. Write an SQL query that retrieves the job application history for a specific applicant.Allow a parameter for the ApplicantID, and return a result set with the job titles, company names, and application dates for all the jobs the applicant has applied to.
SELECT j.JobTitle, c.CompanyName, a.ApplicationDate
FROM Applications a
JOIN Jobs j ON a.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE a.ApplicantID = 123;

-- 8. Create an SQL query that calculates and displays the average salary offered by all companies for job listings in the "Jobs" table.Ensure that the query filters out jobs with a salary of zero.
SELECT AVG(Salary) 
FROM Jobs
WHERE Salary > 0;

-- 9. Write an SQL query to identify the company that has posted the most job listings.Display the company name along with the count of job listings they have posted. Handle ties if multiple companies have the same maximum count.
SELECT c.CompanyName, COUNT(j.JobID) 
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyID
ORDER BY JobCount DESC
LIMIT 1;

-- 10. Find the applicants who have applied for positions in companies located in 'CityX' and have at least 3 years of experience.
SELECT a.FirstName, a.LastName
FROM Applicants a
JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE c.Location = 'CityX' ;


-- 11. Retrieve a list of distinct job titles with salaries between $60,000 and $80,000.
SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000;

-- 12. Find the jobs that have not received any applications.
SELECT JobTitle
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
WHERE a.ApplicationID IS NULL;

-- 13. Retrieve a list of job applicants along with the companies they have applied to and the positions they have applied for.
SELECT a.FirstName, a.LastName, c.CompanyName, j.JobTitle
FROM Applicants a
JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID;

-- 14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not received any applications.
SELECT c.CompanyName, COUNT(j.JobID) 
FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyID;

-- 15. List all applicants along with the companies and positions they have applied for, including those who have not applied.
SELECT a.FirstName, a.LastName, c.CompanyName, j.JobTitle
FROM Applicants a
LEFT JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
LEFT JOIN Jobs j ON ap.JobID = j.JobID
LEFT JOIN Companies c ON j.CompanyID = c.CompanyID;

-- 16. Find companies that have posted jobs with a salary higher than the average salary of all jobs.
SELECT DISTINCT c.CompanyName
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.Salary > (SELECT AVG(Salary) FROM Jobs);

-- 17. Display a list of applicants with their names and a concatenated string of their city and state.
SELECT CONCAT(a.FirstName, ' ', a.LastName) ,  CONCAT(a.City, ', ', a.State) 
FROM Applicants a;

-- 18. Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'.
SELECT JobTitle
FROM Jobs
WHERE JobTitle LIKE '%Developer%' OR JobTitle LIKE '%Engineer%';

-- 19. Retrieve a list of applicants and the jobs they have applied for, including those who have not applied and jobs without applicants.
SELECT a.FirstName, a.LastName, j.JobTitle
FROM Applicants a
LEFT JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
LEFT JOIN Jobs j ON ap.JobID = j.JobID;

-- 20. List all combinations of applicants and companies where the company is in a specific city and the applicant has more than 2 years of experience.
SELECT a.FirstName, a.LastName, c.CompanyName
FROM Applicants a
JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE c.Location = 'Chennai' ;
