const Header = ({ children }) => {
    return (
        <header className="header">
            <div className="header__container">
                <div className="header__content">
                    <div className="logo">WeatherTrack</div>
                    {children}
                </div>
            </div>
        </header>
    )
}

export default Header