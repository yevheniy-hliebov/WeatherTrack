import { WHEATHER_API_URL, WHEATHER_API_KEY } from '../../api'
/**
 * Fetches the forecast weather data based on the provided latitude and longitude.
 *
 * @param {number} lat - Latitude of the location.
 * @param {number} lon - Longitude of the location.
 * @returns {Promise<object>} A Promise that resolves to the JSON response containing current weather data.
 * @throws {Error} If the fetching process encounters an error or the response is not in JSON format.
 */
export const getForecast = (lat, lon) => {
    return fetch(`${WHEATHER_API_URL}/forecast?lat=${lat}&lon=${lon}&appid=${WHEATHER_API_KEY}`)
        .then(response => response.json())
}