# Introduction
This capstone project was developed as part of Luke Barousse’s SQL course. While the course provides a tutorial for this capstone project, I have made several modifications to tailor it to my own analysis. With the goal of better understanding and navigating the job market, particularly in the field of data analytics. The primary focus is to equip individuals with the essential skills and insights needed to succeed in this competitive industry. By analyzing industry trends and potential employers, this project aims to provide valuable resources and guidance for aspiring data analysts.  It explores the most in-demand and high-paying skills to help identify the best job opportunities in data analytics. Through a series of SQL queries, this project investigates crucial aspects such as the most in-demand skills, salary trends, and the relationship between demand and compensation in the data analytics field. <br /> 
# Dataset
The data used serves as the foundation for this analysis, offering detailed information on job titles, salaries, locations, and key skills. 
# Tools & Language 
- **SQL**: Used for querying and analyzing job posting data.  
- **PostgreSQL**: A database management system utilized for storing and managing job posting data.  
- **Visual Studio Code**: A code editor employed for writing and executing SQL queries.  
- **Git & GitHub**: Used for version control, project tracking, and sharing scripts and analyses.
# Exploratory Data Analysis (EDA)  
-**Check available tables**:
```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';
```
Result: 

```json
[
  {
    "table_name": "company_dim"
  },
  {
    "table_name": "job_postings_fact"
  },
  {
    "table_name": "skills_job_dim"
  },
  {
    "table_name": "skills_dim"
  }
]
```
-**View table structure**:
-**Check the number of rows and columns**:
