import { degreesToDirection, kelvinToCelsius, getFormattedTime, getTimezoneOffset } from "../../converters"

const CurrentWeather = ({ hCity, hCurrentWeather }) => {
  return (
    <>
      <div className="current-weather">
        <h2 className="current-weather__title">Current weather</h2>
        <div className="current-weather__dt-weather">
          <div className="current-weather__dt-weather-time">{getFormattedTime(hCurrentWeather.dt, 'HH:mm')}</div>
          <div className="current-weather__dt-weather-date">{getFormattedTime(hCurrentWeather.dt, 'DAY, dd MONTH yyyy') + ` ${getTimezoneOffset(hCurrentWeather.timezone)}`}</div>
        </div>
        <div className="current-weather__temps">
          <div className="current-weather__temp">{kelvinToCelsius(hCurrentWeather.main.temp)}°</div>
          <div className="current-weather__feels-like-temp" title="The human perception of weather">Feels like: {kelvinToCelsius(hCurrentWeather.main.feels_like)}°C</div>
        </div>
        <div className="current-weather__desc">
          <div className="current-weather__desc-icon">
            <img src={`./assets/weather-icons/${hCurrentWeather.weather[0].icon}.svg`} alt={hCurrentWeather.weather[0].description} />
          </div>
          <div className="current-weather__desc-text">{hCurrentWeather.weather[0].description}</div>
        </div>
        <ul className="current-weather__list-info">
          <li className="current-weather__item-info" title="Wind speed & direction">
            <div className="current-weather__item-info-icon">
              <svg width="20" height="21" viewBox="0 0 20 21" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path fillRule="evenodd" clipRule="evenodd" d="M8.75009 7.37148L8.75009 7.3678L5.21212 7.36776L8.60584 6.14146L8.60547 6.14045C8.67047 6.12406 8.73772 6.11823 8.80466 6.12322C8.81349 6.12388 8.82231 6.12473 8.83113 6.12576L8.83126 6.12578C8.92317 6.1366 9.01153 6.16772 9.08995 6.21687L9.08996 6.21688C9.16838 6.26603 9.23491 6.33199 9.28473 6.41L9.28481 6.41013C9.33462 6.48814 9.36647 6.57624 9.37809 6.66807L9.37811 6.66825C9.3897 6.76012 9.38074 6.85341 9.35188 6.94139L9.35185 6.94146C9.32297 7.02947 9.2749 7.10995 9.21111 7.17708L9.21105 7.17714C9.14728 7.24425 9.06939 7.29635 8.98302 7.32967L8.98286 7.32973C8.97473 7.33286 8.96656 7.33582 8.95833 7.3386C8.89125 7.36129 8.82083 7.3724 8.75009 7.37148ZM2.5 7.01849V8.61783L8.73723 8.6179C8.97411 8.62056 9.20972 8.57819 9.43141 8.49267L9.43158 8.4926C9.60034 8.42748 9.75828 8.33841 9.90072 8.22854C9.97657 8.17003 10.048 8.10562 10.1144 8.03578L10.1144 8.03572C10.3054 7.83472 10.4493 7.59378 10.5358 7.33033L10.5358 7.33026C10.6223 7.06682 10.6491 6.78745 10.6144 6.51235L10.6144 6.51217C10.5797 6.23706 10.4843 5.97311 10.3351 5.7394L10.3351 5.73927C10.1859 5.50553 9.98657 5.30788 9.75163 5.16062L9.75162 5.16061C9.66997 5.10944 9.58473 5.06479 9.49669 5.02696C9.3314 4.95593 9.15625 4.90892 8.97658 4.88779L8.97645 4.88778C8.70877 4.85633 8.43754 4.88311 8.18132 4.96618L8.18113 4.96565L8.16195 4.97258L8.15969 4.97334L8.15943 4.97343L8.15945 4.97348L2.5 7.01849ZM2.5 12.3738V13.6578L10.7536 16.5941L10.7535 16.5944C11.0522 16.7136 11.3735 16.7654 11.6945 16.7461C11.818 16.7387 11.9402 16.7209 12.0599 16.693C12.2516 16.6483 12.4369 16.5778 12.6107 16.483C12.893 16.329 13.1379 16.1145 13.3279 15.855C13.5179 15.5955 13.6483 15.2972 13.7098 14.9815C13.7714 14.6657 13.7625 14.3403 13.684 14.0284C13.6054 13.7164 13.459 13.4257 13.2552 13.1768C13.1298 13.0237 12.9845 12.8887 12.8236 12.7752C12.7232 12.7044 12.6166 12.6419 12.505 12.5887C12.2152 12.4504 11.8985 12.3777 11.5774 12.3757V12.3738L2.5 12.3738ZM11.5689 13.6239L6.13444 13.6239L11.2401 15.4403L11.2397 15.4416C11.361 15.4864 11.4904 15.5055 11.6197 15.4978C11.7572 15.4895 11.8911 15.4511 12.012 15.3851C12.1329 15.3191 12.2378 15.2273 12.3191 15.1162C12.4005 15.005 12.4564 14.8773 12.4827 14.7421C12.5091 14.6069 12.5053 14.4675 12.4716 14.334C12.438 14.2004 12.3753 14.0759 12.288 13.9693C12.2008 13.8628 12.0911 13.7768 11.9668 13.7175C11.8427 13.6582 11.707 13.6271 11.5695 13.6262L11.5689 13.6262L11.5689 13.626L11.5689 13.6239ZM14.3863 7.53007L14.3857 7.53038L13.771 6.44198L13.7703 6.44072L13.7715 6.44002C14.1044 6.25219 14.4758 6.14317 14.8574 6.12136C14.9127 6.11819 14.968 6.11688 15.0233 6.11739C15.3494 6.12043 15.6723 6.18728 15.9737 6.31475C16.3261 6.46382 16.6396 6.69182 16.8901 6.98118C17.1405 7.27054 17.3212 7.61355 17.4183 7.98378C17.5153 8.35401 17.5261 8.74158 17.4498 9.11663C17.3735 9.49169 17.2122 9.84423 16.9782 10.1471C16.7782 10.406 16.5296 10.6228 16.247 10.7855C16.1991 10.8131 16.1502 10.8391 16.1004 10.8635C15.7568 11.032 15.3791 11.1193 14.9965 11.1188V11.1186H2.5V9.86858H14.9983L14.9983 9.86723C15.1894 9.86749 15.378 9.82387 15.5497 9.73972C15.7213 9.65557 15.8713 9.53313 15.9882 9.38184C16.1051 9.23055 16.1857 9.05445 16.2238 8.8671C16.2619 8.67974 16.2565 8.48614 16.208 8.3012C16.1595 8.11625 16.0693 7.94491 15.9442 7.80036C15.819 7.65582 15.6624 7.54192 15.4864 7.46746C15.3103 7.39299 15.1196 7.35994 14.9287 7.37085C14.7381 7.38175 14.5526 7.43622 14.3863 7.53007Z" fill="#272727" />
              </svg>
            </div>
            {hCurrentWeather.wind.speed}m/s {degreesToDirection(hCurrentWeather.wind.deg)}
          </li>
          <li className="current-weather__item-info" title={`Atmospheric pressure on the ${"grnd_level" in hCurrentWeather.main ? 'ground' : 'sea'} level`}>
            <div className="current-weather__item-info-icon">
              <svg width={25} height={25} viewBox="0 0 25 25" fill="none" xmlns="http://www.w3.org/2000/svg">
                <mask id="mask0_43_909" style={{ maskType: "alpha" }} maskUnits="userSpaceOnUse" x={0} y={0} width={25} height={25}>
                  <rect width={25} height={25} fill="#D9D9D9" />
                </mask>
                <g mask="url(#mask0_43_909)">
                  <path d="M12.6414 14.4419C12.5633 14.52 12.4367 14.52 12.3586 14.4419L8.47473 10.5581C8.39663 10.48 8.39663 10.3534 8.47473 10.2752L9.65023 9.09976C9.72833 9.02165 9.85496 9.02165 9.93307 9.09976L11.1169 10.2836C11.2429 10.4096 11.4583 10.3203 11.4583 10.1422V5.85333C11.4583 5.74287 11.5479 5.65333 11.6583 5.65333H13.3416C13.4521 5.65333 13.5416 5.74287 13.5416 5.85333V10.1422C13.5416 10.3203 13.7571 10.4096 13.8831 10.2836L15.0669 9.09976C15.145 9.02165 15.2716 9.02165 15.3497 9.09976L16.5252 10.2752C16.6033 10.3534 16.6033 10.48 16.5252 10.5581L12.6414 14.4419Z" fill="#272727" />
                  <path d="M7.41644 15.825V17.5083C7.41644 17.6188 7.50599 17.7083 7.61644 17.7083H17.3835C17.494 17.7083 17.5835 17.6188 17.5835 17.5083V15.825C17.5835 15.7145 17.494 15.625 17.3835 15.625H7.61644C7.50599 15.625 7.41644 15.7145 7.41644 15.825Z" fill="#272727" />
                </g>
              </svg>
            </div>
            {"grnd_level" in hCurrentWeather.main ? hCurrentWeather.main.grnd_level : hCurrentWeather.main.pressure}hPa
          </li>
          <li className="current-weather__item-info">
            Humidity: {hCurrentWeather.main.humidity}%
          </li>
          <li className="current-weather__item-info">
            Cloudiness: {hCurrentWeather.clouds.all}%
          </li>
          {hCurrentWeather.rain && (
            <li className="current-weather__item-info">
              Rain vol 3h: {hCurrentWeather.rain["3h"]}mm
            </li>
          )}
          {hCurrentWeather.snow && (
            <li className="current-weather__item-info">
              Snow vol 3h: {hCurrentWeather.snow["3h"]}mm
            </li>
          )}
          <li className="current-weather__item-info">
            Visibility: {Math.round(hCurrentWeather.visibility / 1000, 2)}km
          </li>
        </ul>
        <div className="current-weather__location">
          <div className="current-weather__country">{hCity.country}</div>
          <div className="current-weather__city">{hCity.name}</div>
        </div>
      </div>
    </>
  )
}

export default CurrentWeather