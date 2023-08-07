const Footer = ({ updWeatherTime }) => {
  return (
    <footer className="footer">
      <div className="footer__container">
        <div className="footer__links">
          {'APIs: '}
          <a href="https://openweathermap.org" className="link" target="_blank">openweathermap.org</a>
          {', '}
          <a href="https://rapidapi.com/wirefreethought/api/geodb-cities" className="link" target="_blank">GeoDB Cities</a>
        </div>
        {
          updWeatherTime && (
            <div className="footer__udp-info">
              Current weather and forecast updated at {updWeatherTime}
            </div>
          )
        }

      </div>
    </footer>
  )
}

export default Footer