select * from CovidDeaths;

--select * from CovidVaccinations
--order by 3,4

--Select date that we are going to be using
select Location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
order by 1,2

--Calculate deaths percentage in all regions
select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_percentage
from CovidDeaths
Order by 1,2

--Select a Particular location for death percentage
select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_percentage
from CovidDeaths
Where location like '%India%'
Order by 1,2

--Total cases vs population
--Shows what percentage of population got covid
select Location, date, total_cases, population, (total_cases/population)*100 as Death_percentage
from CovidDeaths
Where location like '%India%'
Order by 1,2

--Looking at the countries with Highest infection rate compared to population
select Location, population, MAX(total_cases) as MaxInfectionCount, Max(total_cases/population)*100 as Death_percentage
from CovidDeaths
Group by Location, population
Order by Death_percentage desc

--Countries with highest death count per population
select Location, Max(cast(total_deaths as int))as MaxTotalDeaths
From CovidDeaths
Where continent is not null
Group by Location
Order by MaxTotalDeaths desc

--Let break things by continent
select location, Max(cast(total_deaths as int))as MaxTotalDeaths
From CovidDeaths
Where continent is null
Group by location
Order by MaxTotalDeaths desc

--Global Records
select date, Sum(new_cases)as total_NewCases, Sum(cast(new_deaths as int))as Total_NewDeaths,
Sum(cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
from CovidDeaths
Where continent is not null
Group by date
order by 1,2

--Total Cases
select Sum(new_cases)as total_NewCases, Sum(cast(new_deaths as int))as Total_NewDeaths,
Sum(cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
from CovidDeaths
Where continent is not null
--Group by date
order by 1,2

--Join two datasets CovidDeaths and CovidVaccinations
select *
from CovidDeaths
join CovidVaccinations
on CovidDeaths.location = CovidVaccinations.location
and CovidDeaths.date = CovidVaccinations.date 

--Looking at total population vs vaccinations
select CovidDeaths.location, CovidDeaths.date, CovidVaccinations.new_vaccinations
from CovidDeaths
join CovidVaccinations
on CovidDeaths.location = CovidVaccinations.location
and CovidDeaths.date = CovidVaccinations.date 