USE PortfolioProject_COVID;
GO

-- A. Add and populate the final DATE column
-- We use TRY_CONVERT to handle the DD-MM-YYYY format (code 105)
ALTER TABLE CovidVaccinations
ADD date_final DATE;
GO

UPDATE CovidVaccinations
SET date_final = TRY_CONVERT(DATE, date_text, 105);
GO

-- B. Convert ALL columns to their final data types using TRY_CAST
-- This must be done for every single column that was loaded as VARCHAR
-- The column list matches your file's combined data.

-- IMPORTANT: This is a multi-step conversion, running UPDATE on the table itself
-- to safely change the data types without losing data.

-- 1. Convert BIGINT columns
UPDATE CovidVaccinations SET new_tests = TRY_CAST(new_tests AS BIGINT);
UPDATE CovidVaccinations SET total_tests = TRY_CAST(total_tests AS BIGINT);
UPDATE CovidVaccinations SET total_vaccinations = TRY_CAST(total_vaccinations AS BIGINT);
UPDATE CovidVaccinations SET people_vaccinated = TRY_CAST(people_vaccinated AS BIGINT);
UPDATE CovidVaccinations SET people_fully_vaccinated = TRY_CAST(people_fully_vaccinated AS BIGINT);

-- 2. Convert INT columns
UPDATE CovidVaccinations SET new_vaccinations = TRY_CAST(new_vaccinations AS INT);

-- 3. Convert FLOAT columns (using TRY_CAST)
UPDATE CovidVaccinations SET total_tests_per_thousand = TRY_CAST(total_tests_per_thousand AS FLOAT);
UPDATE CovidVaccinations SET new_tests_per_thousand = TRY_CAST(new_tests_per_thousand AS FLOAT);
UPDATE CovidVaccinations SET new_tests_smoothed = TRY_CAST(new_tests_smoothed AS FLOAT);
UPDATE CovidVaccinations SET new_tests_smoothed_per_thousand = TRY_CAST(new_tests_smoothed_per_thousand AS FLOAT);
UPDATE CovidVaccinations SET positive_rate = TRY_CAST(positive_rate AS FLOAT);
UPDATE CovidVaccinations SET tests_per_case = TRY_CAST(tests_per_case AS FLOAT);
UPDATE CovidVaccinations SET total_vaccinations_per_hundred = TRY_CAST(total_vaccinations_per_hundred AS FLOAT);
UPDATE CovidVaccinations SET people_vaccinated_per_hundred = TRY_CAST(people_vaccinated_per_hundred AS FLOAT);
UPDATE CovidVaccinations SET people_fully_vaccinated_per_hundred = TRY_CAST(people_fully_vaccinated_per_hundred AS FLOAT);
UPDATE CovidVaccinations SET new_vaccinations_smoothed_per_million = TRY_CAST(new_vaccinations_smoothed_per_million AS FLOAT);
UPDATE CovidVaccinations SET stringency_index = TRY_CAST(stringency_index AS FLOAT);
UPDATE CovidVaccinations SET population_density = TRY_CAST(population_density AS FLOAT);
UPDATE CovidVaccinations SET median_age = TRY_CAST(median_age AS FLOAT);
UPDATE CovidVaccinations SET aged_65_older = TRY_CAST(aged_65_older AS FLOAT);
UPDATE CovidVaccinations SET aged_70_older = TRY_CAST(aged_70_older AS FLOAT);
UPDATE CovidVaccinations SET gdp_per_capita = TRY_CAST(gdp_per_capita AS FLOAT);
UPDATE CovidVaccinations SET extreme_poverty = TRY_CAST(extreme_poverty AS FLOAT);
UPDATE CovidVaccinations SET cardiovasc_death_rate = TRY_CAST(cardiovasc_death_rate AS FLOAT);
UPDATE CovidVaccinations SET diabetes_prevalence = TRY_CAST(diabetes_prevalence AS FLOAT);
UPDATE CovidVaccinations SET female_smokers = TRY_CAST(female_smokers AS FLOAT);
UPDATE CovidVaccinations SET male_smokers = TRY_CAST(male_smokers AS FLOAT);
UPDATE CovidVaccinations SET handwashing_facilities = TRY_CAST(handwashing_facilities AS FLOAT);
UPDATE CovidVaccinations SET hospital_beds_per_thousand = TRY_CAST(hospital_beds_per_thousand AS FLOAT);
UPDATE CovidVaccinations SET life_expectancy = TRY_CAST(life_expectancy AS FLOAT);
UPDATE CovidVaccinations SET human_development_index = TRY_CAST(human_development_index AS FLOAT);
GO

-- C. Drop the original text date column
ALTER TABLE CovidVaccinations
DROP COLUMN date_text;
GO

-- D. Rename the final date column from date_final to just 'date'
EXEC sp_rename 'CovidVaccinations.date_final', 'date', 'COLUMN';
GO

-- E. Verify the result
SELECT TOP 10 * FROM CovidVaccinations ORDER BY date, location;