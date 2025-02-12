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

- **View table structure**:
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

## 2.Assessing Data Quality
- **Check missing values per column**
```sql
SELECT column_name, null_count
FROM (
    SELECT unnest(array[
        'company_id', 'name', 'link', 'link_google', 'thumbnail'
    ]) AS column_name,
    unnest(array[
        (SELECT COUNT(*) FROM company_dim WHERE company_id IS NULL),
        (SELECT COUNT(*) FROM company_dim WHERE name IS NULL),
        (SELECT COUNT(*) FROM company_dim WHERE link IS NULL),
        (SELECT COUNT(*) FROM company_dim WHERE link_google IS NULL),
        (SELECT COUNT(*) FROM company_dim WHERE thumbnail IS NULL)
    ]) AS null_count
) AS subquery
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

- **Check for duplicate records (based on all columns)**
- **Check for duplicate values in a specific column**
- **Count unique values in a column**


