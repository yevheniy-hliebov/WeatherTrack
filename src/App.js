import React, { useEffect, useState } from "react";
import Search from "./components/seacrh/search";
import SearchHistory from "./components/seacrh/search-history";
import Card from "./components/card";

const storedHistoryCities = localStorage.getItem("historyCities");
const parsedHistoryCities = storedHistoryCities ? JSON.parse(storedHistoryCities) : null;
const defaultList = new Array(5).fill("");

export default function App() {
    const [hCity, setCity] = new useState(parsedHistoryCities ? parsedHistoryCities.list[parsedHistoryCities.index] : null);
    const [hHistoryCities, setHistoryCities] = useState({
        index: parsedHistoryCities?.index ?? 4,
        list: parsedHistoryCities?.list ?? defaultList
    });
    const [hTab, setTab] = new useState('current');

    // --------------------------------------------------------------------------------------------------------------------------------------

    const onHandleSearchChange = (searchData) => {
        const city = JSON.parse(searchData.value)
        setCity(city);

        const history = cyclicShiftLeft(hHistoryCities.list, city);
        const historyCities = {
            index: 4,
            list: history
        }
        setHistoryCities(historyCities);
    }

    useEffect(() => {
        if (hHistoryCities.list[hHistoryCities.list.length - 1] !== '') {
            localStorage.setItem("historyCities", JSON.stringify(hHistoryCities) ?? null);
        }
    }, [hHistoryCities])

    return (
        <>
            <div className="bg">
                <img src="./assets/bg.jpg" alt="bg" />
            </div>
            <div className="short-container">
                <div className="logo">WeatherTrack</div>
                <div className="search-bar">
                    <Search onSearchChange={onHandleSearchChange} />
                    <SearchHistory hHistoryCities={hHistoryCities} setHistoryCities={setHistoryCities} setCity={setCity} />
                </div>
                <Card
                    hCity={hCity}
                    hTab={hTab}
                    setTab={setTab} />
                <Links />
            </div>
        </>
    )
}

const Links = () => {
    return (
        <div className="links">
            APIs:
            <a href="https://openweathermap.org" className="link" target="_blank">openweathermap.org</a>,
            <a href="https://rapidapi.com/wirefreethought/api/geodb-cities" className="link" target="_blank">GeoDB Cities</a>
        </div>
    )
}

function cyclicShiftLeft(arr, newValue) {
    const shiftedArray = [...arr.slice(1), newValue];
    return shiftedArray;
}