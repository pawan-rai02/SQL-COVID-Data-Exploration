-- Covid_Views.sql
-- Views for repeated analysis and dashboards

-- Drop if already exists
IF OBJECT_ID('dbo.PercentPopulationVaccinated', 'V') IS NOT NULL
    DROP VIEW dbo.PercentPopulationVaccinated;
GO

-- View: Vaccination progress by location
CREATE VIEW dbo.PercentPopulationVaccinated AS
SELECT
    d.continent,
    d.location,
    d.date,
    d.population,
    v.new_vaccinations,
    SUM(CAST(v.new_vaccinations AS INT)) 
        OVER (PARTITION BY d.location ORDER BY d.date) AS total_vaccinations_upto_date,
    ROUND(
        (CAST(
            SUM(CAST(v.new_vaccinations AS INT)) 
                OVER (PARTITION BY d.location ORDER BY d.date) AS FLOAT
        ) / d.population) * 100, 4
    ) AS percent_population_vaccinated
FROM CovidDeaths d
JOIN CovidVaccinations v
    ON d.date = v.date
   AND d.location = v.location
WHERE d.continent IS NOT NULL;
GO

-- Quick test
SELECT * FROM dbo.PercentPopulationVaccinated;
