
/*
Top-Demanded Skills for Data Analyst in Indonesia
- **Question to answer:** What are the most frequently required skills for Data Analyst roles in Indonesia?
- **What to Analyze:** Identify the top skills mentioned in job postings
- **Objective:** Helps Indonesian job seekers prioritize the skills they need to learn and understand whether they need to acquire new tools such as SQL, Python, Power BI, or Tableau.

*/

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


/*
🔍 Key Insights from the "Skills" Column </br>
## 🔍 Key Insights:
📌 SQL is the most sought-after skill, highlighting the importance of database management.
📌 Despite advanced tools, Excel remains a key requirement.
📌  🐍: With 33 mentions, Python is a must-have skill for automation and analytics.
📌 Tableau and SAS emphasize the growing demand for business intelligence expertise.
 💡 Bottom Line:Employers in Indonesia seek a mix of data processing (`SQL`, `Python`) and visualization (`Excel`, `Tableau`, `SAS`). 🚀 **Mastering these skills will increase your chances of landing a Data Analyst role in Indonesia!**

[
  {
    "skills": "sql",
    "demand_count": "58"
  },
  {
    "skills": "excel",
    "demand_count": "48"
  },
  {
    "skills": "python",
    "demand_count": "33"
  },
  {
    "skills": "tableau",
    "demand_count": "25"
  },
  {
    "skills": "sas",
    "demand_count": "18"
  }
]
*/