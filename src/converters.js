/**
  * Converts temperature from Kelvin to Celsius.
  * @param {number} kelvin - Temperature in Kelvin.
  * @returns {number} Temperature in Celsius.
  */
export function kelvinToCelsius(kelvin) {
  const celsius = Math.round(kelvin - 273.15);
  return celsius;
}

/**
   * Converts a string so that each word starts with an uppercase letter.
   * @param {string} str - String to convert.
   * @returns {string} A string in which each word begins with an uppercase letter.
   */
export function capitalizeWords(str) {
  const words = str.split(' ');
  const capitalizedWords = words.map(word => {
    return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
  });
  return capitalizedWords.join(' ');
}

/**
 * Converts a degree value to a wind direction string.
 * @param {number} deg - The degree value representing the wind direction (0 to 360).
 * @returns {string} The wind direction as a string (e.g., 'N', 'NE', 'E', etc.).
 */
export function degreesToDirection(deg) {
  const directions = [
    'N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE',
    'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW'
  ];
  const index = Math.round(deg / 22.5) % 16;
  return directions[index];
}


/**
 * Function to format time based on the provided template.
 *
 * @param {number} unix - Unix time, represents the number of milliseconds that have passed since January 1, 1970.
 * @param {string} mask - Time formatting template. Supports the following tokens:
 *                        - yyyy: year (e.g., 2023)
 *                        - MM: month (01-12)
 *                        - MMM: month abbreviation (e.g., Jan, Feb)
 *                        - dd: day of the month (01-31)
 *                        - HH: hour (00-23)
 *                        - mm: minute (00-59)
 *                        - ss: second (00-59)
 *                        - DDD: day of the week (e.g., Monday, Mon)
 * @returns {string} A string representing the formatted time according to the provided template.
 */
export function getFormattedTime(unix, mask, timezone = 0) {
  let date = new Date(unix * 1000);

  let utc = new Date(date.getUTCFullYear(), date.getUTCMonth(),
    date.getUTCDate(), date.getUTCHours(),
    date.getUTCMinutes(), date.getUTCSeconds());
  let timezonedDate = new Date(utc.getTime() + timezone * 1000);
  date = timezonedDate

  // let date_utc = Date.UTC(date.getUTCFullYear(), date.getUTCMonth(),
  // date.getUTCDate(), date.getUTCHours(),
  // date.getUTCMinutes(), date.getUTCSeconds());

  // date = date_utc;

  const dayOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  const monthAbbr = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  const tokens = {
    yyyy: date.getFullYear(),
    MM: String(date.getMonth() + 1).padStart(2, '0'),
    MONTH: monthAbbr[date.getMonth()],
    dd: String(date.getDate()).padStart(2, '0'),
    HH: String(date.getHours()).padStart(2, '0'),
    mm: String(date.getMinutes()).padStart(2, '0'),
    ss: String(date.getSeconds()).padStart(2, '0'),
    DAY: dayOfWeek[date.getDay()],
    DD: dayOfWeek[date.getDay()].substr(0, 3)
  };

  let result = mask;
  for (const token in tokens) {
    result = result.replace(token, tokens[token]);
  }

  return result;
}



/**
 * Function to convert a given timezone to the number of hours ahead or behind GMT.
 *
 * @param {string} timezone - The timezone to convert (e.g., 'America/New_York', 'Europe/London').
 * @returns {string} A string representing the timezone offset in the format of '(GMT+h)' if it's ahead of GMT,
 *                   or 'GMT-h' if it's behind GMT, or '(GMT)' if the timezone is GMT.
 * @throws {Error} If the provided timezone is invalid or not supported by the system.
 */
export function getTimezoneOffset(timezone) {
  const timezoneHours = timezone / 3600;
  if (timezoneHours === 0) {
    return '(GMT)';
  } else if (timezoneHours >= 0) {
    return `(GMT+${timezoneHours})`;
  } else {
    return `(GMT${timezoneHours})`;
  }
}

