USE PortfolioProject_COVID;
GO

-- 1. Drop the table if it exists from a previous attempt
IF OBJECT_ID('CovidVaccinations') IS NOT NULL
    DROP TABLE CovidVaccinations;
GO

-- 2. Create the temporary table with safe VARCHAR types for ALL columns
-- The column list matches your new combined data.
CREATE TABLE CovidVaccinations (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date_text VARCHAR(15), 
    new_tests VARCHAR(50),
    total_tests VARCHAR(50),
    total_tests_per_thousand VARCHAR(50),
    new_tests_per_thousand VARCHAR(50),
    new_tests_smoothed VARCHAR(50),
    new_tests_smoothed_per_thousand VARCHAR(50),
    positive_rate VARCHAR(50),
    tests_per_case VARCHAR(50),
    tests_units VARCHAR(50),
    total_vaccinations VARCHAR(50),
    people_vaccinated VARCHAR(50),
    people_fully_vaccinated VARCHAR(50),
    new_vaccinations VARCHAR(50),
    new_vaccinations_smoothed VARCHAR(50),
    total_vaccinations_per_hundred VARCHAR(50),
    people_vaccinated_per_hundred VARCHAR(50),
    people_fully_vaccinated_per_hundred VARCHAR(50),
    new_vaccinations_smoothed_per_million VARCHAR(50),
    stringency_index VARCHAR(50),
    population_density VARCHAR(50),
    median_age VARCHAR(50),
    aged_65_older VARCHAR(50),
    aged_70_older VARCHAR(50),
    gdp_per_capita VARCHAR(50),
    extreme_poverty VARCHAR(50),
    cardiovasc_death_rate VARCHAR(50),
    diabetes_prevalence VARCHAR(50),
    female_smokers VARCHAR(50),
    male_smokers VARCHAR(50),
    handwashing_facilities VARCHAR(50),
    hospital_beds_per_thousand VARCHAR(50),
    life_expectancy VARCHAR(50),
    human_development_index VARCHAR(50)
);
GO