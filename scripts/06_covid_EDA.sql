-------------------------------------------------------
-- COVID-19 Data Exploration & Analysis
-- Using CovidDeaths and CovidVaccinations tables
-------------------------------------------------------

-----------------------------
-- Basic data selection
-----------------------------
SELECT 
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM CovidDeaths d
WHERE continent IS NOT NULL;


-----------------------------
-- Total cases vs. total deaths
-- Likelihood of dying if infected (India)
-----------------------------
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    population,
    ROUND((CAST(total_deaths AS float) / NULLIF(CAST(total_cases AS float), 0)) * 100, 4) 
        AS death_percentage
FROM CovidDeaths d
WHERE location = 'India'
ORDER BY date;


-----------------------------
-- Total cases vs. population
-- % of population infected (India)
-----------------------------
SELECT 
    location,
    date,
    total_cases,
    population,
    ROUND((CAST(total_cases AS float) / population) * 100, 7) 
        AS infection_rate
FROM CovidDeaths d
WHERE location = 'India'
ORDER BY location, date;


-----------------------------
-- Highest infection rate by country
-----------------------------
SELECT 
    location,
    population,
    MAX(total_cases) AS highest_infection_count,
    ROUND(CAST(MAX(total_cases) AS float) / population * 100, 5) 
        AS infection_rate
FROM CovidDeaths d
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY infection_rate DESC;


-----------------------------
-- Highest death count per population
-----------------------------
SELECT
    location, 
    MAX(total_deaths) AS total_death_count,
    ROUND(CAST(MAX(total_deaths) AS float) / population, 4) 
        AS death_percentage
FROM CovidDeaths d
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY total_death_count DESC;


-----------------------------
-- Death count by continent
-----------------------------
SELECT
    continent,
    MAX(total_deaths) AS total_death_count
FROM CovidDeaths d
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC;


-----------------------------
-- Global daily totals
-----------------------------
SELECT
    date,
    SUM(new_cases)  AS total_cases,
    SUM(new_deaths) AS total_deaths,
    ROUND(CAST(SUM(new_deaths) AS float) / NULLIF(SUM(new_cases), 0) * 100, 4) 
        AS death_percentage
FROM CovidDeaths d
GROUP BY date
ORDER BY date;


-----------------------------
-- Global overall totals
-----------------------------
SELECT
    SUM(new_cases)  AS total_cases,
    SUM(new_deaths) AS total_deaths,
    ROUND(CAST(SUM(new_deaths) AS float) / NULLIF(SUM(new_cases), 0) * 100, 4) 
        AS death_percentage
FROM CovidDeaths d;


-----------------------------
-- Population vs. vaccinations
-----------------------------
SELECT
    d.continent,
    d.location,
    d.date,
    d.population,
    v.new_vaccinations,
    SUM(CAST(v.new_vaccinations AS int)) 
        OVER (PARTITION BY d.location ORDER BY d.date) AS total_vaccinations_upto_date
FROM CovidDeaths d
JOIN CovidVaccinations v
    ON d.date = v.date
   AND d.location = v.location
WHERE d.continent IS NOT NULL
ORDER BY d.location, d.date;


-----------------------------
-- Population vs. vaccinations using CTE
-----------------------------
WITH PopVsVac AS
(
    SELECT
        d.continent,
        d.location,
        d.date,
        d.population,
        v.new_vaccinations,
        SUM(CAST(v.new_vaccinations AS int)) 
            OVER (PARTITION BY d.location ORDER BY d.date) AS total_vaccinations_upto_date
    FROM CovidDeaths d
    JOIN CovidVaccinations v
        ON d.date = v.date
       AND d.location = v.location
    WHERE d.continent IS NOT NULL
)
SELECT 
    *,
    ROUND((CAST(total_vaccinations_upto_date AS float) / population) * 100, 4) 
        AS percent_population_vaccinated
FROM PopVsVac;


-----------------------------
-- Temp table: PercentPopulationVaccinated
-----------------------------
IF OBJECT_ID('tempdb..#PercentPopulationVaccinated') IS NOT NULL
    DROP TABLE #PercentPopulationVaccinated;

SELECT
    d.continent,
    d.location,
    d.date,
    d.population,
    v.new_vaccinations,
    SUM(CAST(v.new_vaccinations AS int)) 
        OVER (PARTITION BY d.location ORDER BY d.date) AS total_vaccinations_upto_date,
    ROUND(
        (CAST(
            SUM(CAST(v.new_vaccinations AS int)) 
                OVER (PARTITION BY d.location ORDER BY d.date) AS float
        ) / d.population) * 100, 4
    ) AS percent_population_vaccinated
INTO #PercentPopulationVaccinated
FROM CovidDeaths d
JOIN CovidVaccinations v
    ON d.date = v.date
   AND d.location = v.location
WHERE d.continent IS NOT NULL;

SELECT * FROM #PercentPopulationVaccinated;


-----------------------------
-- View: PercentPopulationVaccinated
-----------------------------
IF OBJECT_ID('dbo.PercentPopulationVaccinated', 'V') IS NOT NULL
    DROP VIEW dbo.PercentPopulationVaccinated;
GO

CREATE VIEW dbo.PercentPopulationVaccinated
AS
SELECT
    d.continent,
    d.location,
    d.date,
    d.population,
    v.new_vaccinations,
    SUM(CAST(v.new_vaccinations AS int)) 
        OVER (PARTITION BY d.location ORDER BY d.date) AS total_vaccinations_upto_date,
    ROUND(
        (CAST(
            SUM(CAST(v.new_vaccinations AS int)) 
                OVER (PARTITION BY d.location ORDER BY d.date) AS float
        ) / d.population) * 100, 4
    ) AS percent_population_vaccinated
FROM CovidDeaths d
JOIN CovidVaccinations v
    ON d.date = v.date
   AND d.location = v.location
WHERE d.continent IS NOT NULL;
GO

SELECT * FROM dbo.PercentPopulationVaccinated;
