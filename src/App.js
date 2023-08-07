import React, { useEffect, useState } from "react";
import Search from "./components/seacrh/search";
import Header from "./components/header/header";
import { getCurrentWeather } from "./components/current-card/get-current-weather";
import { cureentWeather } from "./data/data-current-weather";
import WeatherContent from "./components/weather-content/weather-content";
import CurrentWeather from "./components/current-card/current-weather";

export default function App() {
    const [hCity, setCity] = new useState(localStorage.getItem("city") !== null ? JSON.parse(localStorage.getItem("city")) : null);
    // const [hCurrentWeather, setCurrentWeather] = new useState(null);
    const [hCurrentWeather, setCurrentWeather] = new useState(cureentWeather);

    const onHandleSearchChange = (searchData) => {
        setCity(searchData.value);
    }

    // useEffect(() => {
    //     if (hCity !== null) {
    //         getCurrentWeather(hCity.latitude, hCity.longitude)
    //             .then(weatherData => setCurrentWeather(weatherData))
    //             .catch(error => console.error(error));
    //     }
    // }, [hCity]);

    return (
        <>
            <Header>
                <Search onSearchChange={onHandleSearchChange} />
            </Header>
            <WeatherContent>
                <CurrentWeather hCity={hCity} hCurrentWeather={hCurrentWeather} />
            </WeatherContent>
        </>
    )
}