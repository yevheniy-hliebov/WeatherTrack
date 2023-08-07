const CurrentWeather = ({ hCity, hCurrentWeather}) => {
    return (
        <>
            <div className="current-weather">
                {console.log(hCity)}
                <div className="current-weather__city">{hCity.name}</div>
                <div className="current-weather__country">{hCity.country}</div>
                <div className="current-weather__temp">{hCurrentWeather.main.temp}</div>
                <div className="current-weather__feels-like">{hCity.name}</div>
            </div>
        </>
    )
}

export default CurrentWeather