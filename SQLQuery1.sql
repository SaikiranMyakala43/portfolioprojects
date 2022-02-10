select *
from portfolioProject..coviddeaths
where continent is not null
order by 3,4;

--select *
--from portfolioProject..covidvaccinations
--order by 3,4;

select Location, date, total_cases, new_cases, total_deaths, population
from portfolioProject..coviddeaths
order by 1,2 

--looking at totalk cases vs total deaths
-- likelihood of dying if you could contact the virus
select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from portfolioProject..coviddeaths
order by 1,2 

--loooking at the total cases vs population
--what percentage of people got covid
select Location, date, total_cases, population, (total_cases/population) as infectionrate
from portfolioProject..coviddeaths
--where location like 'India'
order by 1,2 

--looking at the countries highest infection rate 
select Location, MAX(total_cases), population, MAX((total_cases/population)*100) as infectionrate
from portfolioProject..coviddeaths
--where location like 'India'
group by Location, population
order by infectionrate desc 

--showing the countries with th Highest death count per population

select Location, MAX(cast(total_deaths as int)) as totalDeathCount
from portfolioProject..coviddeaths
--where location like 'India'
where continent is not null
group by Location
order by totalDeathCount desc

--lets break things down by continent 
--showing the continents with the highest death count

select continent, MAX(cast(total_deaths as int)) as totalDeathCount
from portfolioProject..coviddeaths
--where location like 'India'
where continent is not null
group by continent
order by totalDeathCount desc


-- breaking global numbers 

select SUM(new_cases) as total_Cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as deathPercentage
from portfolioProject..coviddeaths
where continent is not null
--group by date
order by 1,2 
--lookit at total populatioin vs vaccinations

select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as rollingPeopleVaccinated
from portfolioProject..coviddeaths dea
join portfolioProject..covidvaccinations vac
    on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
order by 2,3

--Use CTE

with popvsvac(continent, location, date, population,rollingPeopleVaccinated, new_vaccinations )
as
(
select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as rollingPeopleVaccinated
from portfolioProject..coviddeaths dea
join portfolioProject..covidvaccinations vac
    on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select *, (rollingPeopleVaccinated/population)*100
from popvsvac

--temp table
drop table if exists #percentpopulationVaccinated
create table #percentpopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rollingPeopleVaccinated numeric
)
insert into #percentpopulationVaccinated
select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as rollingPeopleVaccinated
from portfolioProject..coviddeaths dea
join portfolioProject..covidvaccinations vac
    on dea.location = vac.location
    and dea.date = vac.date
--where dea.continent is not null
--order by 2,3
select *, (rollingPeopleVaccinated/population)*100
from #percentpopulationVaccinated
--

-- creating view to store data for later  visulaisations


create view percentpopulationVaccinated as
select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as rollingPeopleVaccinated
from portfolioProject..coviddeaths dea
join portfolioProject..covidvaccinations vac
    on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select *
from percentpopulationVaccinated











