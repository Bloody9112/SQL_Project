# 📊 Data Engineer Job Market Analysis  

This project focuses on **Data Engineer** roles, exploring 💰 **top-paying jobs**, 🔥 **in-demand skills**, and 📈 **where high demand meets high salary** in data analytics.  

🔍 **Check SQL queries here:** [project_sql folder](/project_sql/) 

## 🏗 Background

Driven by a quest to navigate the **Data Engineer** job market more effectively, this project was designed to:  

✅ Identify **top-paid** and **in-demand** skills  
✅ Streamline the job search process for others  
✅ Find the **most optimal skills** to learn  

### ❓ Key Questions

1️⃣ What are the **top-paying** data analyst jobs?  
2️⃣ What **skills** are required for these top-paying jobs?  
3️⃣ What **skills** are most in demand for data analysts?  
4️⃣ Which **skills** are associated with higher salaries?  
5️⃣ What are the **most optimal skills** to learn?  

## 🛠 Tools Used  

- **SQL** – for querying job market data  
- **PostgreSQL** – as the database managment system for storing and analyzing job postings
- **VS Code** – for writing and debugging SQL queries 
- **Git & GitHub** – for version control and collaboration
- **ChatGPT** – for insights, query optimization, and analysis 

## 🔍 Analysis Process  

### **1️⃣ Identifying Top-Paying Data Engineer Jobs**  

```sql
SELECT job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Engineer'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 50;
```
📌 **Insight:** The highest-paying **Data Engineer** roles are primarily remote ("Anywhere"), with salaries varying significantly based on company and job type.  

---

### **2️⃣ Extracting Skills for Top-Paying Jobs**  

```sql
WITH top_paying_jobs AS (
    SELECT job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Engineer'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 50
)
SELECT top_paying_jobs.*,
    skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```
📌 **Insight:** The highest-paying **Data Engineer** roles demand skills such as **cloud technologies, NoSQL databases, and machine learning frameworks**.  

---

### **3️⃣ Identifying the Most In-Demand Skills**  

```sql
SELECT skills,
    COUNT(skills_job_dim.job_id) AS skill_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Engineer'
    AND job_location = 'Anywhere'
GROUP BY skills
ORDER BY skill_count DESC
LIMIT 5;
```
📌 **Insight:** The top **5 most in-demand** skills for Data Engineers are:  
1️⃣ **SQL**  
2️⃣ **Python**  
3️⃣ **AWS**  
4️⃣ **Azure**  
5️⃣ **Spark**  

---

### **4️⃣ Analyzing Skills Based on Salary**  

```sql
SELECT skills,
    ROUND(AVG(salary_year_avg), 0) as avarage_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
GROUP BY skills
ORDER BY avarage_salary DESC
LIMIT 20;
```
📌 **Insight:**  
- **Low-level programming languages** like **Assembly ($192.5K)** and **Rust ($172.8K)** are among the highest-paying.  
- **NoSQL databases** (MongoDB, Neo4j) and **ML/AI tools** (Julia, MXNet) offer premium salaries.  
- Some **legacy technologies** (like jQuery) still provide **high earnings** due to demand in maintenance roles.  

---

### **5️⃣ Finding the Most Optimal Skills to Learn**  

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS skill_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avarage_salary
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avarage_salary DESC,
    skill_count DESC
LIMIT
    25;
```
📌 **Insight:**  
- The **most optimal skills** to learn are those with **high salaries & demand**, such as **Kafka, Ruby, Spark, and MongoDB**.  
- Balancing **salary vs. demand** is key to **career growth**. 

## 🎓 What I Learned  

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

## 🎯 Conclusions  

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
