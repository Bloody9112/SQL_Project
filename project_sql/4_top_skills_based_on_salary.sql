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
/*
 Here is a breakdown of the results for top paying skills based on salary:
 - Low-level programming languages like Assembly ($192.5K) and Rust ($172.8K) are among the highest-paying.
 - MongoDB ($182.2K) and Neo4j ($166.5K) highlight the demand for NoSQL and graph databases, which are essential in modern data architectures.
 - Julia ($160.5K) and MXNet ($157.5K) are specialized ML and AI tools, indicating that expertise in cutting-edge machine learning frameworks is well-compensated.
 - JQuery ($151.6K), a somewhat outdated web technology, still ranks in the top 20, indicating that legacy web applications continue to provide well-paying opportunities.
 
 
 [
 {
 "skills": "assembly",
 "avarage_salary": "192500"
 },
 {
 "skills": "mongo",
 "avarage_salary": "182223"
 },
 {
 "skills": "ggplot2",
 "avarage_salary": "176250"
 },
 {
 "skills": "rust",
 "avarage_salary": "172819"
 },
 {
 "skills": "clojure",
 "avarage_salary": "170867"
 },
 {
 "skills": "perl",
 "avarage_salary": "169000"
 },
 {
 "skills": "neo4j",
 "avarage_salary": "166559"
 },
 {
 "skills": "solidity",
 "avarage_salary": "166250"
 },
 {
 "skills": "graphql",
 "avarage_salary": "162547"
 },
 {
 "skills": "julia",
 "avarage_salary": "160500"
 },
 {
 "skills": "splunk",
 "avarage_salary": "160397"
 },
 {
 "skills": "bitbucket",
 "avarage_salary": "160333"
 },
 {
 "skills": "zoom",
 "avarage_salary": "159000"
 },
 {
 "skills": "kubernetes",
 "avarage_salary": "158190"
 },
 {
 "skills": "numpy",
 "avarage_salary": "157592"
 },
 {
 "skills": "fastapi",
 "avarage_salary": "157500"
 },
 {
 "skills": "mxnet",
 "avarage_salary": "157500"
 },
 {
 "skills": "redis",
 "avarage_salary": "157000"
 },
 {
 "skills": "trello",
 "avarage_salary": "155000"
 },
 {
 "skills": "jquery",
 "avarage_salary": "151667"
 }
 ]
 
 */