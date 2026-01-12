import 'package:weathertrack/common/models/city_model.dart';

class CityFixtures {
  static final mockResponse = {
    'data': <dynamic>[
      {
        'id': 3350606,
        'wikiDataId': 'Q24668',
        'type': 'CITY',
        'city': 'Aixirivall',
        'name': 'Aixirivall',
        'country': 'Andorra',
        'countryCode': 'AD',
        'region': 'Sant Julià de Lòria',
        'regionCode': '06',
        'latitude': 42.46245,
        'longitude': 1.50209,
        'population': 0,
      },
      {
        'id': 3216144,
        'wikiDataId': 'Q24656',
        'type': 'CITY',
        'city': 'Aixovall',
        'name': 'Aixovall',
        'country': 'Andorra',
        'countryCode': 'AD',
        'region': 'Sant Julià de Lòria',
        'regionCode': '06',
        'latitude': 42.47635833,
        'longitude': 1.48949167,
        'population': 0,
      },
    ],
  };

  static final List<CityModel> mockCities = CityModel.fromJsonList(
    mockResponse['data']!,
  );

  static final List<CityModel> mockHistory = List.generate(5, (i) {
    return CityModel(
      id: i + 10,
      wikiDataId: 'Q${i + 11}',
      type: 'CITY',
      city: 'City $i',
      name: 'City $i',
      country: 'FakeCountry',
      countryCode: 'FC',
      region: 'City $i region',
      regionCode: '$i',
      latitude: i * 1.1,
      longitude: i * 2.2,
      population: 1 * 5000,
    );
  });
}
