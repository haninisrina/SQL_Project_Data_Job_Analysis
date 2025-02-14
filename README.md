# Introduction
This capstone project was developed as part of Luke Barousse’s SQL course. While the course provides a tutorial for this capstone project, I have made several modifications to tailor it to my own analysis. With the goal of better understanding and navigating the job market, particularly in the field of data analytics. The primary focus is to equip individuals with the essential skills and insights needed to succeed in this competitive industry. By analyzing industry trends and potential employers, this project aims to provide valuable resources and guidance for aspiring data analysts.  It explores the most in-demand and high-paying skills to help identify the best job opportunities in data analytics. Through a series of SQL queries, this project investigates crucial aspects such as the most in-demand skills, salary trends, and the relationship between demand and compensation in the data analytics field. <br /> 
# Dataset
The data used serves as the foundation for this analysis, offering detailed information on job titles, salaries, locations, and key skills. 
# Tools & Language 
- **SQL**: Used for querying and analyzing job posting data.  
- **PostgreSQL**: A database management system utilized for storing and managing job posting data.  
- **Visual Studio Code**: A code editor employed for writing and executing SQL queries.  
- **Git & GitHub**: Used for version control, project tracking, and sharing scripts and analyses.
# Quick Exploratory Data Analysis (EDA) 
## 1. Understanding Data Structure 
- **Check available tables**:
```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';
```
Result: 

| table_name         |
|---------------------|
| company_dim        |
| job_postings_fact  |
| skills_job_dim     |
| skills_dim         |

- **Check Table Schema & Data Types**:
```sql
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'company_dim';
```
Result:
| column_name  | data_type |
|-------------|-----------|
| company_id  | integer   |
| name        | text      |
| link        | text      |
| link_google | text      |
| thumbnail   | text      |

```sql
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'job_postings_fact';
```
Result:
| column_name              | data_type                        |
|--------------------------|---------------------------------|
| job_id                   | integer                         |
| company_id               | integer                         |
| job_work_from_home       | boolean                         |
| job_posted_date          | timestamp without time zone     |
| job_no_degree_mention    | boolean                         |
| job_health_insurance     | boolean                         |
| salary_year_avg          | numeric                         |
| salary_hour_avg          | numeric                         |
| search_location          | text                            |
| salary_rate              | text                            |
| job_title_short          | character varying               |
| job_title                | text                            |
| job_location             | text                            |
| job_via                  | text                            |
| job_schedule_type        | text                            |
| job_country              | text                            |

```sql
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'skill_job_dim';
```
Result:
| column_name | data_type |
|------------|-----------|
| job_id     | integer   |
| skill_id   | integer   |

```sql
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'skill_dim';
```
Result:
| column_name | data_type |
|------------|-----------|
| skill_id   | integer   |
| skills     | text      |
| type       | text      |


- **Show Sample Data**:
SELECT * FROM job_postings_fact LIMIT 10;
Result:
SELECT * FROM job_postings_fact LIMIT 10;
Result:
SELECT * FROM job_postings_fact LIMIT 10;
Result:
SELECT * FROM job_postings_fact LIMIT 10;
Result:

- **Check the number of rows**:
```sql
SELECT COUNT(*) AS total_rows FROM company_dim;
```
Result:
| total_rows |
|------------|
| 140033     |

```sql
SELECT COUNT(*) AS total_rows FROM job_postings_fact;
```
Result:
| total_rows |
|------------|
| 787686     |

```sql
SELECT COUNT(*) AS total_rows FROM skills_job_dim;
```
Result:
| total_rows |
|------------|
| 3669604    |

```sql
SELECT COUNT(*) AS total_rows FROM skills_dim;
```
Result:
| total_rows |
|------------|
| 259     |

## 2. Assessing Data Quality
- **Check missing values per column**
```sql
SELECT attname AS column_name, 
       (SELECT COUNT(*) FROM company_dim WHERE row_to_json(company_dim) ->> attname IS NULL) AS null_count
FROM pg_stats 
WHERE tablename = 'company_dim'
ORDER BY null_count DESC;
```
Result:
| column_name  | null_count |
|-------------|------------|
| link        | 86001      |
| thumbnail   | 58921      |
| link_google | 24         |
| name        | 1          |
| company_id  | 0          |

```sql
SELECT attname AS column_name, 
       (SELECT COUNT(*) FROM job_postings_fact WHERE row_to_json(job_postings_fact) ->> attname IS NULL) AS null_count
FROM pg_stats 
WHERE tablename = 'job_postings_fact'
ORDER BY null_count DESC;
```
Result: 
| column_name            | null_count |
|------------------------|------------|
| salary_hour_avg       | 777021      |
| salary_year_avg       | 765652      |
| salary_rate           | 754586      |
| job_schedule_type     | 12705       |
| job_location         | 1053        |
| job_country          | 52          |
| job_via             | 9           |
| job_title           | 1           |
| search_location     | 0           |
| company_id         | 0           |
| job_title_short     | 0           |
| job_work_from_home  | 0           |
| job_id             | 0           |
| job_posted_date    | 0           |
| job_no_degree_mention | 0        |
| job_health_insurance | 0        |

```sql
SELECT attname AS column_name, 
       (SELECT COUNT(*) FROM skills_job_dim WHERE row_to_json(skills_job_dim) ->> attname IS NULL) AS null_count
FROM pg_stats 
WHERE tablename = 'skills_job_dim'
ORDER BY null_count DESC;
```
Result:
| column_name | null_count |
|------------|------------|
| job_id     | 0          |
| skill_id   | 0          |

```sql
SELECT attname AS column_name, 
       (SELECT COUNT(*) FROM skills_dim WHERE row_to_json(skills_dim) ->> attname IS NULL) AS null_count
FROM pg_stats 
WHERE tablename = 'skills_dim'
ORDER BY null_count DESC;
```
Result:
| column_name | null_count |
|------------|------------|
| skill_id   | 0          |
| skills     | 0          |
| type       | 0          |

- **Count unique values in each column**
The unique value analysis (n_distinct) provides insights into the distribution of distinct values in each column of the tables. 
```sql
SELECT attname AS column_name, n_distinct
FROM pg_stats
WHERE tablename = 'company_dim'
ORDER BY n_distinct DESC;
```
Result:
| column_name | n_distinct   |
|------------|-------------|
| link       | -0.18682025 |
| thumbnail  | -0.21062893 |
| link_google | -0.99986666 |
| company_id | -1          |
| name       | -1          |

🔍 Key Findings and Interpretation: <br /> 
📌 The company_id and name columns have n_distinct = -1
→ PostgreSQL considers all values ​​in these columns to be unique, which is common for Primary Keys (company_id) or different company names.

📌 The link_google column has n_distinct = -0.9998
→ Almost all rows have unique values ​​in this column, such as Google URLs that are unique to each entity.

📌 The link and thumbnail columns have lower n_distinct (-0.1868 and -0.2106)
→ More frequent repeating values, such as multiple companies may have the same thumbnail or link.

```sql
SELECT attname AS column_name, n_distinct
FROM pg_stats
WHERE tablename = 'jobs_posting_fact'
ORDER BY n_distinct DESC;
```
Result:
| column_name             | n_distinct   |
|-------------------------|-------------|
| company_id             | 30160       |
| job_title             | 30092       |
| job_location          | 3976        |
| job_via              | 1525        |
| salary_year_avg      | 466         |
| salary_hour_avg      | 277         |
| search_location      | 141         |
| job_country          | 135         |
| job_schedule_type    | 27          |
| job_title_short      | 10          |
| salary_rate         | 3           |
| job_health_insurance | 2           |
| job_no_degree_mention | 2          |
| job_work_from_home   | 2           |
| job_posted_date      | -0.5715932  |
| job_id              | -1          |

🔍 Key Findings and Interpretation:<br /> 
📌 job_id has n_distinct = -1
→ All values are unique, confirming job_id as the Primary Key.

📌 company_id has n_distinct = 30,160
→ Matches company_dim, meaning most job postings come from distinct companies.

📌 job_title (30,092 unique) vs. job_title_short (10 unique)
→ Job titles are highly diverse, but job_title_short groups them into 10 broader categories.

📌 job_location (3,976), search_location (141), job_country (135)
→ job_location is where the job is offered, while search_location is the employer’s posting location.
→ job_country is a standardized version of search_location.

📌 job_via has n_distinct = 1,525
→ Represents job posting platforms like LinkedIn or Trabajo.org.

📌 Salary & Job Type Insights:
→ job_schedule_type (27 unique) covers Full-time, Part-time, Contractor, etc.
→ salary_rate (3 unique) likely represents yearly, hourly, or contract-based pay.
→ Many missing salary values suggest salaries are often not disclosed.

📌 Binary Columns (True/False):
→ job_work_from_home, job_no_degree_mention, job_health_insurance → Indicate remote work, degree requirements, and health benefits.

📌 job_posted_date has n_distinct = -0.5716
→ Multiple jobs are posted on the same date, suggesting batch uploads

```sql
SELECT attname AS column_name, n_distinct
FROM pg_stats
WHERE tablename = 'skills_job_dim'
ORDER BY n_distinct DESC;
```
Result:
| column_name | n_distinct   |
|------------|-------------|
| skill_id   | 217         |
| job_id     | -0.12514566 |

🔍Key Findings and Interpretation:<br /> 
📌 skill_id has n_distinct = 217
→ There are 217 unique skills linked to job postings.

📌 job_id has n_distinct = -0.1251
→ Many job postings share the same skills, meaning multiple jobs require overlapping skill sets.

```sql
SELECT attname AS column_name, n_distinct
FROM pg_stats
WHERE tablename = 'skills_dim'
ORDER BY n_distinct DESC;
```
Result:
| column_name | n_distinct  |
|------------|------------|
| type       | 10         |
| skills     | -0.972973  |
| skill_id   | -1         |

🔍 Key Findings and Interpretation:<br /> 
📌 type has n_distinct = 10
→ There are 10 unique skill categories or types, likely grouping skills into broader classifications.

📌 skills has n_distinct = -0.973
→ Almost every row has a unique skill name, meaning skill descriptions are highly diverse.

📌 skill_id has n_distinct = -1
→ Each skill has a unique ID, confirming skill_id as a Primary Key for this table.

- **Check for duplicate records (based on all columns)**
```sql
SELECT link, thumbnail, link_google, name, COUNT(*) 
FROM company_dim 
GROUP BY link, thumbnail, link_google, name 
HAVING COUNT(*) > 1;
```
Result:
| link | thumbnail | link_google | name | count |
|------|-----------|-------------|------|-------|
| No data  |


🔍 Key Findings and Interpretation:<br /> 
📌 The query checks for duplicate entries based on link, thumbnail, link_google, and name. Since the result is empty, no duplicate records exist in company_dim with the same combination of these columns.

```sql
SELECT 
    job_work_from_home, job_posted_date, job_no_degree_mention, 
    job_health_insurance, salary_year_avg, salary_hour_avg, 
    search_location, salary_rate, job_title_short, job_title, 
    job_location, job_via, job_schedule_type, job_country, 
    company_id, COUNT(*) 
FROM job_postings_fact 
GROUP BY 
    job_work_from_home, job_posted_date, job_no_degree_mention, 
    job_health_insurance, salary_year_avg, salary_hour_avg, 
    search_location, salary_rate, job_title_short, job_title, 
    job_location, job_via, job_schedule_type, job_country, 
    company_id
HAVING COUNT(*) > 1
ORDER BY company_id;
```
Result: Full results are available in the file [duplicate_records_job_postings_fact.csv](duplicate_records_job_postings_fact.csv)<br /> 
🔍 Key Findings and Interpretation:<br /> 
📌 538 duplicate data records exist in job_postings_fact. 
```sql
SELECT job_id,skill_id, COUNT(*)
FROM skills_job_dim
GROUP BY job_id,skill_id
HAVING COUNT(*) > 1;
```
Result: 
| job_id | skill_id |count |
|------|-----------|-------|
| No data  |

🔍 Key Findings and Interpretation:<br /> 
📌the result is empty, no duplicate records exist in company_dim with the same combination of these columns
```sql
SELECT skill_id,skills,type, COUNT(*)
FROM skills_dim
GROUP BY skill_id,skills,type
HAVING COUNT(*) > 1;
```
Result: 
| skill_id | skills | type | count |
|------|-----------|-------------|-------|
| No data  |

🔍 Key Findings and Interpretation:<br /> 
📌the result is empty, no duplicate records exist in company_dim with the same combination of these columns