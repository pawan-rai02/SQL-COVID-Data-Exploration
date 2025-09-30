USE PortfolioProject_COVID;
GO

-- Drop the table to start fresh
IF OBJECT_ID('CovidDeaths') IS NOT NULL
    DROP TABLE CovidDeaths;
GO

-- Recreate the table with *all* columns as safe VARCHAR/BIGINT types
CREATE TABLE CovidDeaths (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date_text VARCHAR(15), 
    population VARCHAR(50), -- Changed from BIGINT
    total_cases VARCHAR(50), -- Changed from BIGINT
    new_cases VARCHAR(50), -- Changed from INT
    new_cases_smoothed VARCHAR(50), -- Changed from FLOAT
    total_deaths VARCHAR(50), -- Changed from BIGINT
    new_deaths VARCHAR(50), -- Changed from INT
    new_deaths_smoothed VARCHAR(50), -- Changed from FLOAT
    -- Change all remaining numeric/float columns to VARCHAR(50)
    total_cases_per_million VARCHAR(50), 
    new_cases_per_million VARCHAR(50), 
    new_cases_smoothed_per_million VARCHAR(50), 
    total_deaths_per_million VARCHAR(50), 
    new_deaths_per_million VARCHAR(50), 
    new_deaths_smoothed_per_million VARCHAR(50), 
    reproduction_rate VARCHAR(50), 
    icu_patients VARCHAR(50), 
    icu_patients_per_million VARCHAR(50), 
    hosp_patients VARCHAR(50), 
    hosp_patients_per_million VARCHAR(50), 
    weekly_icu_admissions VARCHAR(50), 
    weekly_icu_admissions_per_million VARCHAR(50), 
    weekly_hosp_admissions VARCHAR(50), 
    weekly_hosp_admissions_per_million VARCHAR(50)
);
GO