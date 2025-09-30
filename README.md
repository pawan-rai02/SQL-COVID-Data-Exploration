# SQL-COVID-Data-Exploration

This project explores **COVID-19 data** (cases, deaths, and vaccinations) using SQL.  
It includes step-by-step data preparation, analysis, and reusable SQL views for further exploration and BI reporting.

---

## 📂 Repository Structure

### `/tests/`
Contains **modular step-by-step SQL scripts**:
- **01_innit_deaths.sql** – Initial load/setup for CovidDeaths data.  
- **01_innit_vaccinations.sql** – Initial load/setup for CovidVaccinations data.  
- **02_conversion_cleanup_deaths.sql** – Data type conversions and cleanup for deaths table.  
- **02_conversion_cleanup_vaccinations.sql** – Data type conversions and cleanup for vaccinations table.  
- **03_covid_case_analysis.sql** – Analysis of total cases, deaths, and infection rates.  
- **04_covid_vaccination_analysis.sql** – Vaccination progress analysis vs population.  
- **05_covid_views.sql** – Creates reusable SQL views (e.g., `PercentPopulationVaccinated`).  

> These scripts are useful if you want to **test, debug, or learn incrementally**.

---

### `/scripts/`
Contains **combined and final SQL script**:
- **covid_EDA.sql** – End-to-end exploratory data analysis script, merging all key steps:
  - Case and death analysis  
  - Infection and death rates  
  - Vaccination analysis with running totals  
  - Final views for reporting  

> Use this if you just want to **run everything at once**.

---

## 🚀 How to Use

1. **Step-by-step mode**  
   Run scripts in `/tests/` in order:
      01_innit_deaths.sql
      01_innit_vaccinations.sql
      02_conversion_cleanup_deaths.sql
      02_conversion_cleanup_vaccinations.sql
      03_covid_case_analysis.sql
      04_covid_vaccination_analysis.sql
      05_covid_views.sql
   
2. **All-in-one mode**  
Run `/scripts/covid_EDA.sql` for the full workflow.

---

## 📊 Data Sources
- `CovidDeaths`  
- `CovidVaccinations`  

These tables are expected to be pre-loaded from a dataset such as [Our World in Data](https://ourworldindata.org/coronavirus).

---

## 🔑 Notes
- The project uses:
- **Window functions** for running totals
- **CTEs** for readability
- **Temp tables & Views** for reuse
- Scripts are written for **SQL Server**.  
Minor syntax changes may be needed for other SQL flavors.

---

## ✨ Author
**Pawan Rai** (`pawan-rai02`)
