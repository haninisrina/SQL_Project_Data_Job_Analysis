# 📊 Analysis
## For numbers 1 to 5, I will focus on data analysts in remote jobs to help understand the landscape of remote-friendly data analyst jobs, enabling professionals to apply for opportunities regardless of their location, making it possible to work for companies in different countries while staying in their home country.<br /> 

### 1. Top-Paying Data Job 
**❓ Question to answer:** </br>
<p> What are the top-paying data analyst jobs?</p>

**📊 What to Analyze:** </br>
<p> 1. The top 10 highest-paying Data Analyst roles that are available remotely
and what company they are from<br /> 
    2. Focuses on job postings with specified salaries (remove nulls) </p>

**🎯 Objective:** </br>
<p> Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility </p>

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
**📝 Result:**
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

**🔍 Key Insights**  </br>
📌 **Leadership Roles Pay More** – Director and Principal positions dominate the top salaries, highlighting the value of leadership and expertise. </br>
📌 **Mantys Leads with $650K** – The highest-paying role far exceeds others, likely due to executive responsibilities or performance-based pay. </br>
📌 **Top Industries: Tech, Finance & Telecom** – Companies like Meta, AT&T, SmartAsset, and Pinterest offer top salaries, emphasizing the importance of analytics in user insights, finance, and operations. </br>

## 2. Top-Paying Data Skills
**❓ Question to answer:** </br>
<p> What are the skills required for the top-paying Data Analyst jobs? </p>

**📊 What to Analyze:** </br>
<p> 1. Using the first query that shows the top-paying jobs, we will look at the skills required for these jobs </br>
2. This will help us understand what skills we need to developskills, helping job seekers understand which skills to develop that align with top salaries </p>

**🎯 Objective:** </br> 
<p> Provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries </p>

```sql
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id= skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
**📝 Result:** Full results are available in the file [2.top_paying_jobs_skills.csv] (2. top_paying_jobs_skills.csv)<br /> 

**🔍 Key Insights** </br>
<p> 📌 The top skills by frequency are SQL (8 occurrences), Python (7), and Tableau (6).
These skills appear most frequently across different job listings.</p>


### 3. Top-Demanded Skills for Data Analyst Remote Job
**❓ Question to answer:** </br>
<p> What are the most skills are required for data analyst jobs?</p> 

**📊 What to Analyze:** </br>
<p> Identify the top 5 in-demand skills for a data analyst in a remote job.</p> 

**🎯 Objective:** </br>
<p> Helping job seekers in the data analyst field understand which skills to develop based on job market. This insight allows job seekers to focus on acquiring the right technical and analytical competencies that align with industry needs.  </p> 

```sql
SELECT 
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND  job_location= 'Anywhere'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

```
**📝 Result:**

| skills    | demand_count |
|-----------|-------------|
| SQL       | 7,291       |
| Excel     | 4,611       |
| Python    | 4,330       |
| Tableau   | 3,745       |
| Power BI  | 2,609       |


**🔍 Key Insights**</br>
<p> 📌 SQL (7,291 job postings) → Still the #1 SkillSQL remains the most in-demand skill for data analysts, proving that database querying and management are fundamental in this field.Although demand has decreased compared to previous data, SQL remains a must-have skill for any data analyst.</p>
📌 Excel (4,611 job postings) → Excel’s Relevance ContinuesDespite the rise of programming languages, Excel remains crucial for quick data analysis, reporting, and financial modeling.Companies still rely heavily on Excel, solidifying its place as a top skill for data analysts. </p>
📌Python (4,330 job postings) → Essential for Automation & Data ProcessingPython maintains a strong position, highlighting its importance for data manipulation, automation, and advanced analytics.Its demand is close to Excel, reinforcing its growing necessity in the field. </p>
📌 Tableau (3,745 job postings) → Leading in Data VisualizationTableau remains the top visualization tool, emphasizing the continued need for interactive dashboards and visual analytics.Companies continue to prioritize BI tools, making Tableau a must-have for data storytelling. </p>
📌Power BI (2,609 job postings) → A Strong Competitor to TableauPower BI maintains high demand, especially in organizations using Microsoft’s ecosystem.The demand for both Tableau & Power BI suggests that visualization skills are essential for analysts.</p> 

### 4. Top-Paying Skills for Data Analyst
**❓ Question to answer:** </br>
<p> What are the top skills based on salary in a remote job?</p> 

**📊 What to Analyze:** </br>
<p> Identify the top 25 skills for data analyst based on salary in a remote job </p> 

**🎯 Objective:** </br>
<p> reveals how different skills impact salary levels for Data Analysts in a remote job and helps identify the most financially rewarding skills to acquire or improve </p> 

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
**📝 Result:**

| skills         | avg_salary |
|---------------|------------|
| PySpark       | 208,172    |
| Bitbucket     | 189,155    |
| Couchbase     | 160,515    |
| Watson        | 160,515    |
| DataRobot     | 155,486    |
| GitLab        | 154,500    |
| Swift         | 153,750    |
| Jupyter       | 152,777    |
| Pandas        | 151,821    |
| Elasticsearch | 145,000    |
| Golang        | 145,000    |
| NumPy         | 143,513    |
| Databricks    | 141,907    |
| Linux         | 136,508    |
| Kubernetes    | 132,500    |
| Atlassian     | 131,162    |
| Twilio        | 127,000    |
| Airflow       | 126,103    |
| Scikit-learn  | 125,781    |
| Jenkins       | 125,436    |
| Notion        | 125,000    |
| Scala         | 124,903    |
| PostgreSQL    | 123,879    |
| GCP           | 122,500    |
| MicroStrategy | 121,619    |

**🔍 Key Insights High-Paying Skills for Remote Data Analysts**  </br>
<p>
📌 Big Data & Cloud Dominate – PySpark ($208K) & Databricks ($141K) highlight demand for big data processing & cloud expertise.</br>
📌 AI & ML Pay Well – Watson ($160K), DataRobot ($155K), and Scikit-learn ($125K) show AI-driven analytics is lucrative.</br>
📌 DevOps & Version Control Matter – Bitbucket ($189K), GitLab ($154K), and Jenkins ($125K) prove workflow automation & collaboration tools are key.</br>
📌 NoSQL & Advanced DB Skills Rewarded – Couchbase ($160K), Elasticsearch ($145K), and PostgreSQL ($123K) signal value in modern database tech.</br>
📌 Cross-Functional Coding Adds Value – Swift ($153K), Golang ($145K), and Scala ($124K) highlight demand for scripting & backend integration.</br>
💡 Bottom Line: To maximize remote earnings, focus on big data, cloud, AI, and automation.</p>

### 5. Optimal Skills for Data Analyst
**❓ Question to answer:**<br /> 
<p> What are the optimal skills to learn (high demand and high-paying skill) </p>

**📊 What to Analyze:**  <br /> 
<p> Identify the top high demand skills and associated with high average salariesfor data analyst role </p>

**🎯 Objective:**<br /> 
<p> Reveals skills that offer job security (high demand) and financial benefits (high salaries). Offering strategic insights for career development in data analysis</p> 

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
**📝 Result:**
| skill_id | skills      | demand_count | avg_salary ($) |
|----------|------------|--------------|---------------:|
| 8        | go         | 27           | 115,320        |
| 234      | confluence | 11           | 114,210        |
| 97       | hadoop     | 22           | 113,193        |
| 80       | snowflake  | 37           | 112,948        |
| 74       | azure      | 34           | 111,225        |
| 77       | bigquery   | 13           | 109,654        |
| 76       | aws        | 32           | 108,317        |
| 4        | java       | 17           | 106,906        |
| 194      | ssis       | 12           | 106,683        |
| 233      | jira       | 20           | 104,918        |
| 79       | oracle     | 37           | 104,534        |
| 185      | looker     | 49           | 103,795        |
| 2        | nosql      | 13           | 101,414        |
| 1        | python     | 236          | 101,397        |
| 5        | r          | 148          | 100,499        |
| 78       | redshift   | 16           | 99,936         |
| 187      | qlik       | 13           | 99,631         |
| 182      | tableau    | 230          | 99,288         |
| 197      | ssrs       | 14           | 99,171         |
| 92       | spark      | 13           | 99,077         |
| 13       | c++        | 11           | 98,958         |
| 186      | sas        | 63           | 98,902         |
| 7        | sas        | 63           | 98,902         |
| 61       | sql server | 35           | 97,786         |
| 9        | javascript | 20           | 97,587         |

**🔍 Key Insights on High-Demand & High-Paying Data Analyst Skills**  </br>
📌 High-Demand Programming Languages  </br>
<p> Python (236) and R (148) are the most sought-after languages.
Their average salaries ($101K for Python, $100K for R) suggest they are essential but widely available skills. </p> 
📌 Cloud Tools & Big Data Technologies </br>
<p> Snowflake, Azure, AWS, and BigQuery are in high demand, with competitive salaries ($108K–$112K). </p>
This highlights the growing reliance on cloud computing and big data in analytics.
📌 Business Intelligence & Visualization  </br>
<p> Tableau (230) and Looker (49) emphasize the need for BI and visualization.
With salaries around $99K–$103K, these tools are crucial for extracting actionable insights. </p>
📌 Database Technologies </br>
<p> Oracle, SQL Server, NoSQL remain fundamental, with salaries $97K–$104K.
Strong database expertise is still highly valuable in data management. </p>

## For the numbers 6 and 8, I will focus on data analysis in Indonesia to help job seekers in Indonesia to understand the job market so that it gives a greater chance of being employed.

### 6. Top-Demanded Skills for Data Analyst in Indonesia
**❓ Question to answer:** </br>
<p>What are the most frequently required skills for Data Analyst roles in Indonesia? </p>

**📊 What to Analyze:** </br>
<p>Identify the top skills mentioned in job postings </p>

**🎯 Objective:** </br>
<p> Helps Indonesian job seekers prioritize the skills they need to learn and understand whether they need to acquire new tools such as SQL, Python, Power BI, or Tableau. </br>

```sql
SELECT 
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND  job_location= 'Indonesia'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
;

```
**📝 Result:**

| skills    | demand_count |
|-----------|-------------|
| sql       | 58       |
| excel     | 48      |
| python    | 33       |
| tableau   | 25       |
| sas  | 18       |

**🔍 Key Insights:** </br>
📌 SQL is the most sought-after skill, highlighting the importance of database management.</br>
📌 Despite advanced tools, Excel remains a key requirement.</br>
📌  🐍: With 33 mentions, Python is a must-have skill for automation and analytics.</br>
📌 Tableau and SAS emphasize the growing demand for business intelligence expertise.</br>
 💡 Bottom Line:Employers in Indonesia seek a mix of data processing (`SQL`, `Python`) and visualization (`Excel`, `Tableau`, `SAS`). 🚀 **Mastering these skills will increase your chances of landing a Data Analyst role in Indonesia!**


## 7. Companies Hiring the Most Data Analysts in Indonesia 
**❓ Question to answer:** </br>
<p> Which companies in Indonesia have the highest number of job postings for Data Analysts? </p>

**📊 What to Analyze:** </br>
<p> The top hiring companies, whether they are startups, tech firms, or large corporations, and any hiring trends. </p>

**🎯 Objective:** </br>
<p> Helps job seekers target their applications toward companies that frequently hire Data Analysts, increasing their chances of securing a job. </p>

```sql
SELECT 
    company.company_id,
    company.name,
    COUNT(*)
FROM job_postings_fact AS job
RIGHT JOIN company_dim AS company 
    ON job.company_id= company.company_id
WHERE job_country = 'Indonesia' 
GROUP BY company.company_id, company.name
ORDER BY count DESC
LIMIT 10;
```
**📝 Result :** 
| company_id | company_name                     | job_count |
|------------|-------------------------------------|----------|
| 359415     | Posloker                           | 30       |
| 15305      | Grab                               | 27       |
| 3607       | Monroe Consulting Group           | 25       |
| 44929      | Asian Technology Solutions        | 25       |
| 119434     | PT BFI Finance Indonesia Tbk      | 23       |
| 28938      | Accord Innovations                | 22       |
| 44637      | Glints                             | 22       |
| 72638      | Diksha Teknologi Indonesia        | 19       |
| 18296      | GO-JEK                             | 19       |
| 692        | Michael Page                      | 18       |

**🔍 Key Insights:** </br>
📌Top Employers: Posloker, Grab, and Monroe Consulting Group have the most Data Analyst job openings in Indonesia. </br>
📌Diverse Hiring Landscape: Companies range from tech firms (Grab, GO-JEK) to recruitment agencies (Michael Page, Monroe Consulting). </br>
📌Finance & Consulting Demand: Firms like BFI Finance and Asian Technology Solutions actively seek Data Analysts, highlighting strong demand in finance and IT consulting. </br>

**8. Growth of Data-Related Job Roles in Indonesia (2023)**

**❓ Question to Answer:**</br>
<p> How has the demand for data-related job roles in Indonesia changed throughout 2023?</p>

**📊 What to Analyze:**</br>
<p> 1. Quarterly growth trends of key data-related roles. </br>
2. Seasonal hiring patterns for data-related jobs. </br>
3. Differences in hiring trends between emerging and established roles.
4. The demand for junior vs. senior roles. </p>

**🎯 Objective:**</br>
<p> Provide insights into the demand trends for data-related roles in Indonesia to help job seekers make informed career decisions. Understanding hiring trends allows professionals to identify in-demand skills and employers to align recruitment strategies accordingly. </p>

```sql
-- 🔹 Identifying the Most Demanded Data-Related Jobs in Indonesia
SELECT 
    job_title,
    job_title_short,
    COUNT(*)
FROM job_postings_fact AS job
WHERE job_country = 'Indonesia' 
GROUP BY job_title_short, job_title
ORDER BY count DESC

-- 🔹 Growth Analysis: Quarterly Job Posting Trends
WITH job_postings_indonesia AS (
    SELECT 
        job_title_short, 
        EXTRACT(QUARTER FROM job_posted_date::DATE) AS quarter, 
        COUNT(*) AS job_count
    FROM 
        job_postings_fact AS job
    WHERE 
        job_country = 'Indonesia' 
    GROUP BY quarter, job_title_short
),
growth_calculation AS (
    SELECT 
        job_title_short, 
        quarter, 
        job_count,
        LAG(job_count) OVER (PARTITION BY job_title_short ORDER BY quarter) AS prev_quarter_count,
        ROUND(
            100.0 * (job_count - LAG(job_count) OVER (PARTITION BY job_title_short ORDER BY quarter)) 
            / NULLIF(LAG(job_count) OVER (PARTITION BY job_title_short ORDER BY quarter), 0),
            2
        ) AS growth_percentage
    FROM job_postings_indonesia
)

SELECT * FROM growth_calculation;

```
**📝 Result :** 
| company_id | company_name                     | job_count |
|------------|-------------------------------------|----------|
| 359415     | Posloker                           | 30       |
| 15305      | Grab                               | 27       |
| 3607       | Monroe Consulting Group           | 25       |
| 44929      | Asian Technology Solutions        | 25       |
| 119434     | PT BFI Finance Indonesia Tbk      | 23       |
| 28938      | Accord Innovations                | 22       |
| 44637      | Glints                             | 22       |
| 72638      | Diksha Teknologi Indonesia        | 19       |
| 18296      | GO-JEK                             | 19       |
| 692        | Michael Page                      | 18       |

**🔍 Key Insights:**</br>
📌 Growth Rate of Job Postings Per Role </br>
- __Data Analyst__ grew **152.27%** from Q3 (88) to Q4 (222). </br>
- **Software Engineer** saw a **293.18%** increase from Q3 (44) to Q4 (173). </br>
- **Data Engineer** rose by **52.44%** from Q3 (225) to Q4 (343). </br>
- **Cloud Engineer** had the highest percentage growth (**285.71%**), from Q3 (14) to Q4 (54). </br>

📌 Seasonal Hiring Patterns</br>
- **Q4 consistently shows the highest hiring spike** across most roles.
- **Q2 tends to have the lowest number of postings**.

📌 Emerging vs. Established Roles</br>
- **High-demand roles**: Data Engineer, Data Scientist, and Data Analyst show **stable demand**. </br>
- **Emerging roles**: Machine Learning Engineer and Cloud Engineer have **lower job postings** but show **sharp growth in Q4**, suggesting they are gaining traction. </br>

📌 Junior vs. Senior Role Growth</br>
- **Junior and mid-level roles** see much faster growth than Senior Data Analyst, Senior Data Engineer, and Senior Data Scientist roles. </br>
- This suggests companies are prioritizing **hiring entry-level and mid-level talent** rather than focusing on experienced professionals. </br>
