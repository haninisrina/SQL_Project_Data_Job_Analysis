
/* Top-Paying Skills for Data Analyst
Question to answer: What are the top skills based on salary?
Objective: reveals how different skills impact salary levels for Data Analysts and 
helps identify the most financially rewarding skills to acquire or improve
What to Analyze: 
- Identify the top 25 skills for data analyst based on salary

*/

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
 

 /*

Insights on Top-Paying Skills for Data Analysts
📌High-Paying Skills are Cloud & Big Data-Focused:
PySpark ($208K), Databricks ($141K), and GCP ($122K) show that cloud computing and big data processing are highly valued.
These skills are essential for handling large-scale data in distributed environments.

📌Version Control & DevOps Tools are Gaining Importance:
Bitbucket ($189K), GitLab ($154K), and Jenkins ($125K) highlight the need for DevOps and CI/CD knowledge in data roles.
Companies prefer data analysts who can collaborate on code efficiently.

📌Data Science & AI Tools Are In-Demand:
DataRobot ($155K), Scikit-learn ($125K), and Watson ($160K) indicate that AI/ML skills drive salaries higher.
Employers value automation and advanced analytics capabilities.

📌Programming Languages Beyond Python Are Rewarding:
Golang ($145K) and Scala ($124K) are among the high-paying skills, showing demand for performance-oriented languages in data engineering.

📌Data Engineering & Infrastructure Skills are Key:
Elasticsearch ($145K), Kubernetes ($132K), and Airflow ($126K) suggest a strong focus on managing data pipelines and search technologies.

Key Takeaways:
💰 Big Data & Cloud Skills (PySpark, Databricks, GCP) Lead in Salary
🔧 DevOps & CI/CD Tools (Bitbucket, GitLab, Jenkins) Are Valuable
📊 AI & ML Tools (DataRobot, Scikit-learn, Watson) Boost Salaries
🚀 Languages Beyond Python (Golang, Scala) Are Rewarding

[
  {
    "skills": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "watson",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skills": "swift",
    "avg_salary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skills": "pandas",
    "avg_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skills": "golang",
    "avg_salary": "145000"
  },
  {
    "skills": "numpy",
    "avg_salary": "143513"
  },
  {
    "skills": "databricks",
    "avg_salary": "141907"
  },
  {
    "skills": "linux",
    "avg_salary": "136508"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skills": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skills": "twilio",
    "avg_salary": "127000"
  },
  {
    "skills": "airflow",
    "avg_salary": "126103"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skills": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skills": "notion",
    "avg_salary": "125000"
  },
  {
    "skills": "scala",
    "avg_salary": "124903"
  },
  {
    "skills": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skills": "gcp",
    "avg_salary": "122500"
  },
  {
    "skills": "microstrategy",
    "avg_salary": "121619"
  }
]
*/
