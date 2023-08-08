import React, { useEffect, useState } from "react";
import Search from "./components/seacrh/search";
import { getCurrentWeather } from "./components/current-card/get-current-weather";
import CurrentWeather from "./components/current-card/current-weather";
import { getForecast } from "./components/current-card/get-forecast";

export default function App() {
  const [hCity, setCity] = new useState(localStorage.getItem("city") !== null ? JSON.parse(localStorage.getItem("city")) : null);
  const [hCurrentWeather, setCurrentWeather] = new useState(null);
  const [hForecast, setForecast] = new useState(null);

  const onHandleSearchChange = (searchData) => {
    const city = JSON.parse(searchData.value)
    setCity(city);
  }

  useEffect(() => {
    if (hCity !== null) {
      getCurrentWeather(hCity.latitude, hCity.longitude)
        .then(weatherData => {
          setCurrentWeather(weatherData)

          getForecast(hCity.latitude, hCity.longitude)
            .then(forecastData => {
              setForecast(forecastData);
            })
            .catch(error => console.error(error));
        })
        .catch(error => console.error(error));
    }
  }, [hCity]);

  return (
    <>
      <div className="bg">
        <img src="./assets/bg.jpg" alt="bg" />
      </div>
      <div className="short-container">
        <div className="logo">WeatherTrack</div>
        <Search onSearchChange={onHandleSearchChange} />
        {
          (hCity !== null && hCurrentWeather !== null) && (
            <>
              <CurrentWeather hCity={hCity} hCurrentWeather={hCurrentWeather} hForecast={hForecast} />
            </>
          )
        }
        <div className="links">
          {'APIs: '}
          <a href="https://openweathermap.org" className="link" target="_blank">openweathermap.org</a>
          {', '}
          <a href="https://rapidapi.com/wirefreethought/api/geodb-cities" className="link" target="_blank">GeoDB Cities</a>
        </div>
      </div>
    </>
  )
}