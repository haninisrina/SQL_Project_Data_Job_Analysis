# Analysis
## For numbers 1 to 5, I will focus on data analysts in remote jobs to help understand the landscape of remote-friendly data analyst jobs, enabling professionals to apply for opportunities regardless of their location, making it possible to work for companies in different countries while staying in their home country.<br /> 
### 1. Top-Paying Data Job
- **Question to answer:** What are the top-paying data analyst jobs?<br /> 
- **What to Analyze:** <br /> 
1. The top 10 highest-paying Data Analyst roles that are available remotely
and what company they are from<br /> 
2. Focuses on job postings with specified salaries (remove nulls)<br /> 
- **Objective:** Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility <br />
```sql 
SELECT 
    job_id,
    job_title,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Result:
| job_id   | job_title                                      | job_title_short | job_location | job_schedule_type | salary_year_avg | job_posted_date       | company_name                                  |
|---------|-----------------------------------------------|----------------|--------------|-------------------|----------------|----------------------|----------------------------------------------|
| 226942  | Data Analyst                                  | Data Analyst   | Anywhere     | Full-time         | 650000.0       | 2023-02-20 15:13:33  | Mantys                                       |
| 547382  | Director of Analytics                        | Data Analyst   | Anywhere     | Full-time         | 336500.0       | 2023-08-23 12:04:42  | Meta                                         |
| 552322  | Associate Director- Data Insights           | Data Analyst   | Anywhere     | Full-time         | 255829.5       | 2023-06-18 16:03:12  | AT&T                                         |
| 99305   | Data Analyst, Marketing                     | Data Analyst   | Anywhere     | Full-time         | 232423.0       | 2023-12-05 20:00:40  | Pinterest Job Advertisements                 |
| 1021647 | Data Analyst (Hybrid/Remote)                | Data Analyst   | Anywhere     | Full-time         | 217000.0       | 2023-01-17 00:17:23  | Uclahealthcareers                            |
| 168310  | Principal Data Analyst (Remote)             | Data Analyst   | Anywhere     | Full-time         | 205000.0       | 2023-08-09 11:00:01  | SmartAsset                                   |
| 731368  | Director, Data Analyst - HYBRID            | Data Analyst   | Anywhere     | Full-time         | 189309.0       | 2023-12-07 15:00:13  | Inclusively                                  |
| 310660  | Principal Data Analyst, AV Performance Analysis | Data Analyst   | Anywhere     | Full-time         | 189000.0       | 2023-01-05 00:00:25  | Motional                                     |
| 1749593 | Principal Data Analyst                      | Data Analyst   | Anywhere     | Full-time         | 186000.0       | 2023-07-11 16:00:05  | SmartAsset                                   |
| 387860  | ERM Data Analyst                            | Data Analyst   | Anywhere     | Full-time         | 184000.0       | 2023-06-09 08:01:04  | Get It Recruit - Information Technology      |


## 2. Top-Paying Data Skills
- **Question to answer:** What are the skills required for the top-paying Data Analyst jobs?
- **What to Analyze:** <br />
 1. Using the first query that shows the top-paying jobs, we will look at the skills required for these jobs
 2. This will help us understand what skills we need to developskills, helping job seekers understand which skills to develop that align with top salaries 
- **Objective:**  Provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
 <br /> 

## 3. Top-Demanded Skills for Data Analyst Remote Job
- **Question to answer:** What are the most skills are required for data analyst jobs?
- **What to Analyze:** Identify the top 5 in-demand skills for a data analyst in a remote job.
- **Objective:** Helping job seekers in the data analyst field understand which skills to develop based on job market. This insight allows job seekers to focus on acquiring the right technical and analytical competencies that align with industry needs.  <br /> 

## 4. Top-Paying Skills for Data Analyst
- **Question to answer:** What are the top skills based on salary in a remote job?
- **What to Analyze:** Identify the top 25 skills for data analyst based on salary in a remote job
- **Objective:** reveals how different skills impact salary levels for Data Analysts in a remote job and 
helps identify the most financially rewarding skills to acquire or improve <br /> 

## 5. Optimal Skills for Data Analyst
- **Question to answer:**What are the optimal skills to learn (high demand and high-paying skill)
- **What to Analyze:**  Identify the top high demand skills and associated with high average salariesfor data analyst role
- **Objective:** reveals skills that offer job security (high demand) and financial benefits (high salaries).
Offering strategic insights for career development in data analysis<br /> 



## For the numbers 6 and 7, I will focus on data analysis in Indonesia to help job seekers in Indonesia to understand the job market so that it gives a greater chance of being employed.

## 6. Top-Demanded Skills for Data Analyst in Indonesia
- **Question to answer:** What are the most frequently required skills for Data Analyst roles in Indonesia?
- **What to Analyze:** Identify the top skills mentioned in job postings
- **Objective:** Helps Indonesian job seekers prioritize the skills they need to learn and understand whether they need to acquire new tools such as SQL, Python, Power BI, or Tableau.

## 7. Companies Hiring the Most Data Analysts in Indonesia 
- **Question to answer:** Which companies in Indonesia have the highest number of job postings for Data Analysts?
- **What to Analyze:** The top hiring companies, whether they are startups, tech firms, or large corporations, and any hiring trends.
- **Objective:** Helps job seekers target their applications toward companies that frequently hire Data Analysts, increasing their chances of securing a job.