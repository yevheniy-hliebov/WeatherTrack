const SearchHistory = ({ hHistoryCities, setHistoryCities, setCity }) => {
    function ChooseCity(e, index) {
        console.log(index);
        setCity(hHistoryCities.list[index]);
        setHistoryCities({ index: index, list: hHistoryCities.list })
    }


    if (hHistoryCities.list[hHistoryCities.list.length - 2] === "") return;
    return (
        <div className="search-history">
            <div className="search-history__title">City search history:</div>
            <div className="search-history__cities">
                {hHistoryCities.list.map((city, index) => {
                    if (city === '') return null;
                    return (
                        <div className="search-history__city" key={index}>
                            <button
                                className={"search-history__button" + (hHistoryCities.index === index ? " _checked" : '')}
                                
                                onClick={(e) => ChooseCity(e, index)}>
                                {city.name + ', ' + city.countryCode}
                            </button>
                        </div>
                    )
                })}
            </div>
        </div>
    )
}

export default SearchHistory
