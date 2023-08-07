import React, { useState } from "react";
import { AsyncPaginate } from "react-select-async-paginate";
import { GEO_API_URL, geoPopulation, geoApiOptions } from "../../api";
import { customStyles } from "./custom-style";


const Search = ({ onSearchChange }) => {
    const [hSearch, setSearch] = new useState(null);
    if (hSearch) {
        localStorage.setItem("city", hSearch.value ?? null);
    }

    const handleOnChange = (searchData) => {
        setSearch(searchData);
        onSearchChange(searchData);
    }

    const handleLoadOptions = (inputValue) => {
        return fetch(`${GEO_API_URL}/cities?minPopulation=${geoPopulation}&namePrefix=${inputValue}`, geoApiOptions)
            .then(response => response.json())
            .then(response => {
                let responseData = []
                if ('data' in response && 'metadata' in response && Array.isArray(response.data) && response.data.length > 0) {
                    responseData = response.data;
                }
                const options = responseData.map(city => ({
                    value: JSON.stringify(city),
                    label: `${city.name}, ${city.countryCode}`,
                }));
                return { options };
            })
            .catch(err => console.error(err));
    }



    return (
        <div className="search-wrapper">
            <AsyncPaginate
                className="search-bar"
                placeholder='Search city...'

                debounceTimeout={1200}
                value={hSearch}
                onChange={handleOnChange}
                loadOptions={handleLoadOptions}
                styles={customStyles}
            />
        </div>
    )
}

export default Search;