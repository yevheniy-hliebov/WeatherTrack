import React, { useEffect, useState } from "react";
import Search from "./components/seacrh/search";
import Header from "./components/header/header";
import { getCurrentWeather } from "./components/current-card/get-current-weather";
import { cureentWeather } from "./data/data-current-weather";
import WeatherContent from "./components/weather-content/weather-content";
import CurrentWeather from "./components/current-card/current-weather";
import Footer from "./components/footer/footer";
import { getFormattedTime } from "./converters";

export default function App() {
  const [hCity, setCity] = new useState(localStorage.getItem("city") !== null ? JSON.parse(localStorage.getItem("city")) : null);
  const [hCurrentWeather, setCurrentWeather] = new useState(null);
  // const [hCurrentWeather, setCurrentWeather] = new useState(cureentWeather);

  const onHandleSearchChange = (searchData) => {
    const city = JSON.parse(searchData.value)
    setCity(city);
  }

  useEffect(() => {
    if (hCity !== null) {
      getCurrentWeather(hCity.latitude, hCity.longitude)
        .then(weatherData => setCurrentWeather(weatherData))
        .catch(error => console.error(error));
    }
  }, [hCity]);

  return (
    <>
      <Header>
        <Search onSearchChange={onHandleSearchChange} />
      </Header>
      {
        (hCity !== null && hCurrentWeather !== null) && (
          <>
            <WeatherContent>
              <CurrentWeather hCity={hCity} hCurrentWeather={hCurrentWeather} />
            </WeatherContent>
            <Footer updWeatherTime={getFormattedTime(hCurrentWeather.dt, 'HH:mm dd.MM.yyyy')} />
          </>
        )
      }
    </>
  )
}