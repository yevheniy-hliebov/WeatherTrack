import { useEffect, useState } from "react";
import { degreesToDirection, kelvinToCelsius, getFormattedTime, getTimezoneOffset } from "../../converters"
import { getCurrentWeather } from "./get-current-weather";

const CurrentWeather = ({ hCity }) => {
    const [hCurrentWeather, setCurrentWeather] = new useState(null);
    useEffect(() => {
        if (hCity !== null) {
            getCurrentWeather(hCity.latitude, hCity.longitude)
                .then(weatherData => {
                    setCurrentWeather(weatherData)
                })
                .catch(error => console.error(error));
        }
    }, [hCity]);

    if (hCurrentWeather === null) return
    return (
        <>
            <div className="current-weather">
                <div className="current-weather__temps-desc">
                    <div className="current-weather__temps">
                        <div className="current-weather__temp">{kelvinToCelsius(hCurrentWeather.main.temp)}°</div>
                        <div className="current-weather__feels-like-temp" title="The human perception of weather">Feels like: {kelvinToCelsius(hCurrentWeather.main.feels_like)}°C</div>
                    </div>
                    <div className="current-weather__desc">
                        <div className="current-weather__desc-icon">
                            <img src={`./assets/weather-icons/${hCurrentWeather.weather[0].icon}.svg`} alt={hCurrentWeather.weather[0].description} />
                        </div>
                        <div className="current-weather__desc-text">
                            {hCurrentWeather.weather[0].description}
                        </div>
                    </div>
                </div>
                {/* <HourlyList hCurrentWeather={hCurrentWeather} hForecast={hForecast} /> */}
                <div className="current-weather__details-block">
                    <div className="current-weather__details-label">Details</div>
                    <div className="current-weather__details">
                        <Detail value={hCurrentWeather.clouds.all + '%'} label={'Cloud'} />
                        <Detail value={hCurrentWeather.main.humidity + '%'} label={'Humidity'} />
                        <Detail value={hCurrentWeather.wind.speed + 'm/s'} label={'Wind speed'} />
                        <Detail value={degreesToDirection(hCurrentWeather.wind.deg)} label={'Wind direction'} />
                        <Detail value={hCurrentWeather.main.pressure + 'hPa'} label={'Pressure'} />
                        {"rain" in hCurrentWeather && <Detail value={hCurrentWeather.rain["1h"] + 'mm'} label={'Rain vol 1h'} />}
                        {"snow" in hCurrentWeather && <Detail value={hCurrentWeather.snow["1h"] + 'mm'} label={'Snow vol 1h'} />}
                    </div>
                </div>
                <div className="current-weather__dt-weather">
                    {getFormattedTime(hCurrentWeather.dt, `Last update: HH:mm dd.MM.yyyy ${getTimezoneOffset(hCurrentWeather.timezone)}`, hCurrentWeather.timezone)}
                </div>
            </div>
        </>
    )
}

const Detail = ({ value, label }) => {
    return (
        <div className="current-weather__detail-info detail-info">
            <div className="detail-info__value">{value}</div>
            <div className="detail-info__label">{label}</div>
        </div>
    )
}

export default CurrentWeather