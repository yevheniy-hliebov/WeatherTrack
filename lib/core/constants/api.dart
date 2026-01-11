class Api {
  Api._();
  
  static final WeatherApi weather = WeatherApi();
  static final GeoApi geo = GeoApi();
}

class WeatherApi {
  final String url = 'https://api.openweathermap.org/data/2.5';
  final String key = '0699f5c9c9ace6e052d698e4cafb5f94';
}

class GeoApi {
  final String url = 'https://wft-geo-db.p.rapidapi.com/v1/geo';
  final String xRapidapiKey =
      'f022988565mshb4dbbf2192fed75p1d2abfjsn70f421a6ae81';
  final String population = '500000';
}
