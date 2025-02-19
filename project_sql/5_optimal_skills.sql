WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS skill_count
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Engineer'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
    GROUP BY 
        skills_dim.skill_id
), avarage_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avarage_salary
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Engineer'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
    GROUP BY 
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skill_count,
    avarage_salary
FROM
    skills_demand
    INNER JOIN avarage_salary ON skills_demand.skill_id = avarage_salary.skill_id
WHERE
    skill_count > 10
ORDER BY
    avarage_salary DESC,
    skill_count DESC
    
LIMIT
    25



    -- Or here is optimized version

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
    25