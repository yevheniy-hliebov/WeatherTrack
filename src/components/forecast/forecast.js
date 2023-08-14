import { useEffect, useState } from 'react'
import { getFormattedTime, kelvinToCelsius } from "../../converters";
import { getForecast } from "./get-forecast";

const Forecast = ({ hCity }) => {
    const [hSelectedDay, setSelectedDay] = new useState(null);
    const [hForecast, setForecast] = new useState(null);
    useEffect(() => {
        if (hCity !== null) {
            getForecast(hCity.latitude, hCity.longitude)
                .then(weatherData => {
                    setForecast(weatherData)
                })
                .catch(error => console.error(error));
        }
    }, [hCity]);
    if (hForecast !== null && hSelectedDay == null) {
        setSelectedDay(getWeek(hForecast.list, hForecast.city.timezone)[0].dateString)
    }

    if (hForecast === null) return null;
    return (
        <>
            <Week hForecast={hForecast} hSelectedDay={hSelectedDay} setSelectedDay={setSelectedDay} />
            <ForecastTable hForecast={hForecast} hSelectedDay={hSelectedDay} />
        </>
    )
}

const Week = ({ hForecast, hSelectedDay, setSelectedDay }) => {
    const weekList = getWeek(hForecast.list, hForecast.city.timezone)
    return (
        <div className="week-list">
            {weekList.map((item, index) => {
                return (
                    <button
                        type="button"
                        className={`week-list__item${hSelectedDay === item.dateString ? ' day-selected' : ''}`}
                        key={index}
                        onClick={() => { setSelectedDay(item.dateString) }}>
                        <div className="week-list__day">{item.day}</div>
                        <div className="week-list__date">{item.dateString}</div>
                    </button>
                )
            })}
        </div>
    )
}

const ForecastTable = ({ hForecast, hSelectedDay }) => {
    return (
        <div className="forecast-table">
            <div className="forecast-table__fields">
                <div className="forecast-table__sunrise-sunset">
                    <div className="forecast-table__sunrise">Sunrise: {getFormattedTime(hForecast.city.sunrise, 'HH:mm', hForecast.city.timezone)}</div>
                    <div className="forecast-table__sunset">Sunset: {getFormattedTime(hForecast.city.sunset, 'HH:mm', hForecast.city.timezone)}</div>
                </div>
                <div className="forecast-table__field">Temperature, °C</div>
                <div className="forecast-table__field">Feels like</div>
                <div className="forecast-table__field">Humidity, %</div>
                <div className="forecast-table__field">Pressure, hPa</div>
                <div className="forecast-table__field">Wind speed, m/s</div>
                <div className="forecast-table__field">Rain vol 3h, mm</div>
                <div className="forecast-table__field">Snow vol 3h, mm</div>
            </div>
            <div className="forecast-table__columns">
                {
                    hForecast.list.filter((item) => {
                        const dateString = getFormattedTime(item.dt, `dd.MM.yyyy`, hForecast.city.timezone);
                        return hSelectedDay === dateString
                    }).map((item, index) => {
                        return <HourForecast hourForecast={item} timezone={hForecast.city.timezone} key={index} />
                    })
                }
            </div>
        </div>
    )
}

const HourForecast = ({ hourForecast, timezone }) => {
    return (
        <div className="forecast-table__hour-forecast hour-forecast">
            <div className="hour-forecast__time">{getFormattedTime(hourForecast.dt, 'HH:mm', timezone)}</div>
            <div className="hour-forecast__icon" title={`${hourForecast.weather[0].description} - Clouds ${hourForecast.clouds.all}%`}>
                <img src={`./assets/weather-icons/${hourForecast.weather[0].icon}.svg`} alt={hourForecast.weather[0].main} />
            </div>
            <div className="hour-forecast__temp">{kelvinToCelsius(hourForecast.main.temp)}°</div>
            <div className="hour-forecast__feels-like">{kelvinToCelsius(hourForecast.main.feels_like)}°</div>
            <div className="hour-forecast__humidity">{hourForecast.main.humidity}</div>
            <div className="hour-forecast__pressure">{hourForecast.main.pressure}</div>
            <div className="hour-forecast__wind-speed">{hourForecast.wind.speed}</div>

            <div className="hour-forecast__rain-vol">{"rain" in hourForecast ? ("3h" in hourForecast.rain ? hourForecast.rain['3h'] : '–') : '–'}</div>
            <div className="hour-forecast__snow-vol">{"snow" in hourForecast ? ("3h" in hourForecast.snow ? hourForecast.snow['3h'] : '–') : '–'}</div>
        </div>
    )
}

const getWeek = (list, timezone) => {
    let listDate = list.map((item) => {
        const dateString = getFormattedTime(item.dt, `dd.MM.yyyy`, timezone)
        const dayObject = {
            day: getFormattedTime(item.dt, `DD`, timezone),
            dateString: dateString
        }
        return dayObject
    });
    const uniqueItems = [...new Set(listDate.map(item => JSON.stringify(item)))].map(item => JSON.parse(item));
    listDate = Array.from(uniqueItems);
    return listDate;
}

export default Forecast