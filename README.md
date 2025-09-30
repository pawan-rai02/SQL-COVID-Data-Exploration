# SQL-COVID-Data-Exploration

This project explores global COVID-19 data using SQL.  
It covers **case trends, deaths, infection rates, and vaccinations**, and also provides reusable views for dashboards.  

---

## 📂 File Structure

###  `covid_case_analysis.sql`
- Analyzes **cases, deaths, and infection rates**.
- Key insights:
  - Likelihood of dying if infected (country-level).
  - Percentage of population infected.
  - Countries with the highest infection rates.
  - Countries and continents with the highest death counts.
  - Global daily and overall case/death trends.

---

###  `covid_vaccination_analysis.sql`
- Focuses on **vaccinations vs population**.
- Includes:
  - CTE-based vaccination analysis.
  - Temp table for percent population vaccinated.
  - Running total of vaccinations over time.

---

### 3. `covid_views.sql`
- Contains **reusable SQL views** for dashboards and analysis.
- Example:
  - `PercentPopulationVaccinated` view showing cumulative vaccination % by location and date.

---

## 🚀 How to Use
1. Run scripts in the following order for best results:
   - `Covid_Case_Analysis.sql`
   - `Covid_Vaccination_Analysis.sql`
   - `Covid_Views.sql`
2. Use the created **views** for reporting or BI tools (e.g., Power BI, Tableau).

---

## 📊 Data Sources
- `CovidDeaths` table  
- `CovidVaccinations` table  

Both tables are assumed to be pre-loaded from a reliable dataset (such as [Our World in Data](https://ourworldindata.org/coronavirus)).

---

## 🔑 Notes
- Scripts use **window functions**, **CTEs**, **temp tables**, and **views** for flexibility.
- Designed for **SQL Server**. Small adjustments may be needed for other SQL dialects.
