USE PortfolioProject_COVID;
GO

-- 1. Add a new, properly-typed DATE column
ALTER TABLE CovidDeaths
ADD date_final DATE;
GO

-- 2. Convert the text date (DD-MM-YYYY) and populate the new column
-- Format code 105 is used to convert DD-MM-YYYY to the SQL DATE type.
UPDATE CovidDeaths
SET date_final = TRY_CONVERT(DATE, date_text, 105);
GO

-- 3. Check for any dates that failed conversion (they will be NULL)
SELECT date_text FROM CovidDeaths WHERE date_final IS NULL AND date_text IS NOT NULL;






-- 1. DROP the final table if it exists, for a clean start
IF OBJECT_ID('CovidDeaths_Final') IS NOT NULL
    DROP TABLE CovidDeaths_Final;
GO

-- 2. CREATE the new, final table with the correct data types
CREATE TABLE CovidDeaths_Final (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE, -- This is the final date column
    population BIGINT,
    total_cases BIGINT,
    new_cases INT,
    new_cases_smoothed FLOAT,
    total_deaths BIGINT,
    new_deaths INT,
    new_deaths_smoothed FLOAT,
    total_cases_per_million FLOAT,
    new_cases_per_million FLOAT,
    new_cases_smoothed_per_million FLOAT,
    total_deaths_per_million FLOAT,
    new_deaths_per_million FLOAT,
    new_deaths_smoothed_per_million FLOAT,
    reproduction_rate FLOAT,
    icu_patients INT,
    icu_patients_per_million FLOAT,
    hosp_patients INT,
    hosp_patients_per_million FLOAT,
    weekly_icu_admissions FLOAT,
    weekly_icu_admissions_per_million FLOAT,
    weekly_hosp_admissions FLOAT,
    weekly_hosp_admissions_per_million FLOAT
);
GO

-- 3. INSERT data from the temporary table into the final table
-- We use TRY_CAST and TRY_CONVERT to safely handle bad data by converting it to NULL
INSERT INTO CovidDeaths_Final 
    (iso_code, continent, location, date, population, total_cases, new_cases, new_cases_smoothed, 
    total_deaths, new_deaths, new_deaths_smoothed, total_cases_per_million, new_cases_per_million, 
    new_cases_smoothed_per_million, total_deaths_per_million, new_deaths_per_million, new_deaths_smoothed_per_million, 
    reproduction_rate, icu_patients, icu_patients_per_million, hosp_patients, hosp_patients_per_million, 
    weekly_icu_admissions, weekly_icu_admissions_per_million, weekly_hosp_admissions, weekly_hosp_admissions_per_million)
SELECT 
    iso_code, 
    continent, 
    location, 
    date_final, -- Assuming you completed the date conversion in the previous step
    TRY_CAST(population AS BIGINT),
    TRY_CAST(total_cases AS BIGINT),
    TRY_CAST(new_cases AS INT),
    TRY_CAST(new_cases_smoothed AS FLOAT),
    TRY_CAST(total_deaths AS BIGINT),
    TRY_CAST(new_deaths AS INT),
    TRY_CAST(new_deaths_smoothed AS FLOAT),
    TRY_CAST(total_cases_per_million AS FLOAT),
    TRY_CAST(new_cases_per_million AS FLOAT),
    TRY_CAST(new_cases_smoothed_per_million AS FLOAT),
    TRY_CAST(total_deaths_per_million AS FLOAT),
    TRY_CAST(new_deaths_per_million AS FLOAT),
    TRY_CAST(new_deaths_smoothed_per_million AS FLOAT),
    TRY_CAST(reproduction_rate AS FLOAT),
    TRY_CAST(icu_patients AS INT),
    TRY_CAST(icu_patients_per_million AS FLOAT),
    TRY_CAST(hosp_patients AS INT),
    TRY_CAST(hosp_patients_per_million AS FLOAT),
    TRY_CAST(weekly_icu_admissions AS FLOAT),
    TRY_CAST(weekly_icu_admissions_per_million AS FLOAT),
    TRY_CAST(weekly_hosp_admissions AS FLOAT),
    TRY_CAST(weekly_hosp_admissions_per_million AS FLOAT)
FROM 
    CovidDeaths;
GO

-- 4. VERIFY the result and clean up the temporary table
SELECT TOP 10 * FROM CovidDeaths_Final ORDER BY date, location;
GO

-- Drop the temporary table now that the data is clean
DROP TABLE CovidDeaths;
GO



-- Rename the table from CovidDeaths_Final to just CovidDeaths
EXEC sp_rename 'CovidDeaths_Final', 'CovidDeaths';
GO

-- Optional: Verify the rename (should show the new table name)
SELECT TOP 5 * FROM CovidDeaths;