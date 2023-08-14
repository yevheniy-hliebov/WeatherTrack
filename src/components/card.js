import CurrentWeather from "./current/current-weather";
import Forecast from "./forecast/forecast";

const Card = ({ hCity, hTab, setTab }) => {
    
    return (
        <div className="card">
            <div className="card__header">
                <div className="card__city">
                    <div className="card__city-icon">
                        <img src="./assets/location.svg" alt="icon-location" />
                    </div>
                    {hCity.name}, {hCity.countryCode}</div>
                <div className="card__tabs">
                    <TabButton label="Current" hTab={hTab} setTab={setTab} />
                    <TabButton label="Forecast" hTab={hTab} setTab={setTab} />
                </div>
                <div className="card__content">
                    { hTab === 'current' ? (<CurrentWeather hCity={hCity} />) : null }
                    { hTab === 'forecast' ? (<Forecast hCity={hCity}/>) : null }
                </div>
            </div>
        </div>
    )
}

const TabButton = ({ label, hTab, setTab }) => {
    return (
        <button
            type="button"
            className={`card__tab ${hTab === label.toLowerCase() ? 'tab-selected' : ''}`}
            onClick={() => setTab(label.toLowerCase())}>
            {label}
        </button>
    )
}

export default Card