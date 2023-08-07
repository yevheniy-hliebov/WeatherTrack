import { WHEATHER_API_URL, WHEATHER_API_KEY } from '../../api'
/**
 * @param {number} lat
 * @param {number} lon
 */
export const getCurrentWeather = (lat, lon) => {
    return fetch(`${WHEATHER_API_URL}/weather?lat=${lat}&lon=${lon}&appid=${WHEATHER_API_KEY}`)
        .then(response => response.json())
}