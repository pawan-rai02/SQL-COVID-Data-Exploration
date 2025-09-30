-- Covid_Vaccination_Analysis.sql
-- Analyzing vaccinations vs population

------------------------------------------------------
-- Population vs Vaccinations (base join)
------------------------------------------------------
SELECT
    d.continent,
    d.location,
    d.date,
    d.population,
    v.new_vaccinations,
    SUM(CAST(v.new_vaccinations AS INT)) 
        OVER (PARTITION BY d.location ORDER BY d.date) AS total_vaccinations_upto_date
FROM CovidDeaths d
JOIN CovidVaccinations v
    ON d.date = v.date
   AND d.location = v.location
WHERE d.continent IS NOT NULL
ORDER BY d.location, d.date;

------------------------------------------------------
-- Using CTE for readability
------------------------------------------------------
WITH PopVsVac AS (
    SELECT
        d.continent,
        d.location,
        d.date,
        d.population,
        v.new_vaccinations,
        SUM(CAST(v.new_vaccinations AS INT)) 
            OVER (PARTITION BY d.location ORDER BY d.date) AS total_vaccinations_upto_date
    FROM CovidDeaths d
    JOIN CovidVaccinations v
        ON d.date = v.date
       AND d.location = v.location
    WHERE d.continent IS NOT NULL
)
SELECT 
    *,
    ROUND((CAST(total_vaccinations_upto_date AS FLOAT) / population) * 100, 4) AS percent_population_vaccinated
FROM PopVsVac;

------------------------------------------------------
-- Using Temp Table for repeated analysis
------------------------------------------------------
IF OBJECT_ID('tempdb..#PercentPopulationVaccinated') IS NOT NULL
    DROP TABLE #PercentPopulationVaccinated;

SELECT
    d.continent,
    d.location,
    d.date,
    d.population,
    v.new_vaccinations,
    SUM(CAST(v.new_vaccinations AS INT)) 
        OVER (PARTITION BY d.location ORDER BY d.date) AS total_vaccinations_upto_date,
    ROUND((CAST(SUM(CAST(v.new_vaccinations AS INT)) 
        OVER (PARTITION BY d.location ORDER BY d.date) AS FLOAT) / d.population) * 100, 4) 
        AS percent_population_vaccinated
INTO #PercentPopulationVaccinated
FROM CovidDeaths d
JOIN CovidVaccinations v
    ON d.date = v.date
   AND d.location = v.location
WHERE d.continent IS NOT NULL;

SELECT * FROM #PercentPopulationVaccinated;
