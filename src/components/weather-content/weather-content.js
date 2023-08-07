const WeatherContent = ({ children }) => {
    return (
        <main className="main">
            <div className="main__container">
                <div className="weather-content">
                    {children}
                </div>
            </div>
        </main>
    )
}

export default WeatherContent;