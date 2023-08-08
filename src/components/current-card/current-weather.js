import { degreesToDirection, kelvinToCelsius, getFormattedTime, getTimezoneOffset } from "../../converters"

const CurrentWeather = ({ hCity, hCurrentWeather, hForecast }) => {
  const classPreffix = "current-weather"
  return (
    <>
      <div className={classPreffix}>
        <div className={classPreffix + "__title-dt"}>
          <h2 className={classPreffix + "__title"}>Current weather</h2>
          <div className={classPreffix + "__dt-weather"}>
            {getFormattedTime(hCurrentWeather.dt, `Last update: HH:mm dd.MM.yyyy ${getTimezoneOffset(hCurrentWeather.timezone)}`, hCurrentWeather.timezone)}
          </div>
        </div>
        <div className={classPreffix + "__temps-desc"}>
          <div className={classPreffix + "__temps"}>
            <div className={classPreffix + "__temp"}>{kelvinToCelsius(hCurrentWeather.main.temp)}°</div>
            <div className={classPreffix + "__feels-like-temp"} title="The human perception of weather">Feels like: {kelvinToCelsius(hCurrentWeather.main.feels_like)}°C</div>
          </div>
          <div className={classPreffix + "__desc"}>
            {hCurrentWeather.weather[0].description}
          </div>
        </div>
        <HourlyList hCurrentWeather={hCurrentWeather} hForecast={hForecast} />
        <div className={classPreffix + "__details-block"}>
          <div className={classPreffix + "__details-label"}>Details</div>
          <div className={classPreffix + "__details"}>
            <Detail classPreffix={classPreffix} value={hCurrentWeather.clouds.all + '%'} label={'Cloud'} />
            <Detail classPreffix={classPreffix} value={hCurrentWeather.main.humidity + '%'} label={'Humidity'} />
            <Detail classPreffix={classPreffix} value={hCurrentWeather.wind.speed + 'm/s'} label={'Wind speed'} />
            <Detail classPreffix={classPreffix} value={degreesToDirection(hCurrentWeather.wind.deg)} label={'Wind direction'} />
            <Detail classPreffix={classPreffix} value={hCurrentWeather.main.pressure + 'hPa'} label={'Pressure'} />
            {"rain" in hCurrentWeather && <Detail classPreffix={classPreffix} value={hCurrentWeather.rain["3h"] + 'mm'} label={'Rain vol 3h'} />}
            {"snow" in hCurrentWeather && <Detail classPreffix={classPreffix} value={hCurrentWeather.snow["3h"] + 'mm'} label={'Snow vol 3h'} />}
          </div>
        </div>
        <div className={classPreffix + "__location"}>
          <div className={classPreffix + "__country"}>{hCity.country}</div>
          <div className={classPreffix + "__city"}>{hCity.name}</div>
        </div>
      </div>
    </>
  )
}

const Detail = ({ classPreffix, value, label }) => {
  return (
    <div className={classPreffix + "__detail-info detail-info"}>
      <div className="detail-info__value">{value}</div>
      <div className="detail-info__label">{label}</div>
    </div>
  )
}

const HourBlock = ({ time, icon, desc, temp }) => {
  return (
    <div className="hour-block" title={desc}>
      <div className="hour-block__time">{time}</div>
      <div className="hour-block__icon">
        <img src={`./assets/weather-icons/${icon}.svg`} alt={desc} />
      </div>
      <div className="hour-block__temp">{temp}°C</div>
    </div>
  )
}

const HourlyList = ({ hCurrentWeather, hForecast }) => {
  if (hForecast === null) return null
  let listIndex = 0;
  return (
    <ul className="hourly-list">
      {hForecast.list.map((obj) => {
        if (listIndex < 8) {
          listIndex++;
          return <HourBlock
            time={getFormattedTime(obj.dt, 'HH:mm', hForecast.timezone)}
            icon={obj.weather[0].icon}
            desc={obj.weather[0].description}
            temp={kelvinToCelsius(obj.main.temp)}
            key={getFormattedTime(obj.dt, 'HH:mm', hCurrentWeather.timezone)}
          />
        } else return null
      })}
    </ul>
  )
}

export default CurrentWeather