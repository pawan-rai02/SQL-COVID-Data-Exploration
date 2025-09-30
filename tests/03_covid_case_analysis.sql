-- Covid_Case_Analysis.sql
-- Analyzing COVID-19 cases, deaths, and infection/death rates by country, continent, and globally

-- Select base data for analysis
SELECT 
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM CovidDeaths
WHERE continent IS NOT NULL;

------------------------------------------------------
-- Total cases vs total deaths (India)
-- Shows likelihood of dying if infected
------------------------------------------------------
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    population,
    ROUND((CAST(total_deaths AS FLOAT) / NULLIF(total_cases, 0)) * 100, 4) AS death_percentage
FROM CovidDeaths
WHERE location = 'India'
ORDER BY date;

------------------------------------------------------
-- Total cases vs population (India)
-- Percentage of population infected
------------------------------------------------------
SELECT 
    location,
    date,
    total_cases,
    population,
    ROUND((CAST(total_cases AS FLOAT) / population) * 100, 7) AS infection_rate
FROM CovidDeaths
WHERE location = 'India'
ORDER BY date;

------------------------------------------------------
-- Countries with highest infection rate
------------------------------------------------------
SELECT 
    location,
    population,
    MAX(total_cases) AS highest_infection_count,
    ROUND(CAST(MAX(total_cases) AS FLOAT) / population * 100, 5) AS infection_rate
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY infection_rate DESC;

------------------------------------------------------
-- Countries with highest death count per population
------------------------------------------------------
SELECT
    location, 
    MAX(total_deaths) AS total_death_count,
    ROUND(CAST(MAX(total_deaths) AS FLOAT) / population, 4) AS death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY total_death_count DESC;

------------------------------------------------------
-- Continent-level death count
------------------------------------------------------
SELECT
    continent,
    MAX(total_deaths) AS total_death_count
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC;

------------------------------------------------------
-- Global daily and overall numbers
------------------------------------------------------
-- By date
SELECT
    date,
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    ROUND(CAST(SUM(new_deaths) AS FLOAT) / NULLIF(SUM(new_cases), 0) * 100, 4) AS death_percentage
FROM CovidDeaths
GROUP BY date
ORDER BY date;

-- Overall
SELECT
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    ROUND(CAST(SUM(new_deaths) AS FLOAT) / NULLIF(SUM(new_cases), 0) * 100, 4) AS death_percentage
FROM CovidDeaths;
