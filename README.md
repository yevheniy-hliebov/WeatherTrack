# WeatherTrack

## Introduction

WeatherTrack is a website that I developed to expand my portfolio and highlight my web development skills. The project emphasizes my proficiency in technologies such as React.js, HTML, CSS (utilizing the SCSS preprocessor), JavaScript, and API integration through sample requests. The core aim of the project is to create a valuable user experience by providing real-time weather information for cities.  

## Features

### API Integration

The project demonstrates my adeptness in working with APIs by integrating two distinct APIs:

- **GeoDB Cities API:** This API enables users to search for cities with populations exceeding 500,000, adding depth to the application's city selection feature.
- **OpenWeatherMap API:** By leveraging this API, the project retrieves real-time weather data based on the selected city's coordinates (latitude and longitude).

### Dynamic Weather Display

Upon selecting a city, the application dynamically retrieves and presents weather data, including:

- Current weather conditions
- Temperature
- Feels-like temperature
- Other pertinent information

The website is designed to be both visually appealing and informative.

### Hourly Weather Forecast

WeatherTrack offers users an hourly weather forecast, empowering them to plan their activities efficiently. The forecast provides essential data, such as time, temperature and weather conditions.

### Weather Details

The application offers an in-depth view of weather conditions by providing additional information:

- Cloud cover percentage
- Humidity levels
- Wind speed and direction
- Atmospheric pressure
- Rain/Snow Volume <i>(where available)</i>

These details collectively contribute to a comprehensive understanding of the selected city's weather.

### Responsive Design

WeatherTrack's user-friendly interface is designed with responsiveness as a priority. The application ensures a seamless and enjoyable experience across diverse devices and screen sizes.

## Purpose

WeatherTrack serves as a valuable tool for users to access real-time weather information for cities, enabling them to make informed decisions and plan activities based on accurate weather forecasts. Beyond showcasing my mastery of front-end development with React.js and CSS, this project underscores my ability to integrate APIs, manage dynamic data, and create meaningful user interactions.

Feel free to explore the project and experience the seamless integration of technology and user-centric design.

## Technologies Used

- React.js
- HTML
- CSS (SCSS)
- JavaScript
- GeoDB Cities API
- OpenWeatherMap API

## Usage

1. Clone this repository.
2. Navigate to the project directory.
3. Install dependencies using `npm install`.
4. Run using `npm start`.

## Build
1. Run using `npm run build`.
2. Сheck in index.html for the correct connection of a certain file, in particular main.css, main.js, etc., because the 'build' command sometimes incorrectly writes links to files

## Q&A
- Why did not find the city? - Probably the number of the city's population is less than the value of geoPopulation (in src/api.js), by default geoPopulation = 500000, for reduce load: Queries with fewer results can reduce server load and speed up API response.

## Contributions

Contributions are welcome! If you identify any issues or have suggestions for improvement, please consider submitting a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
