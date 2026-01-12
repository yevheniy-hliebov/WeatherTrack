import 'package:weathertrack/common/models/city_model.dart';
import 'package:weathertrack/common/models/coordinate.dart';

class CityFixtures {
  static final mockResponse = {
    'data': <dynamic>[
      {
        'id': 3350606,
        'name': 'Aixirivall',
        'countryCode': 'AD',
        'latitude': 42.46245,
        'longitude': 1.50209,
      },
      {
        'id': 3216144,
        'name': 'Aixovall',
        'countryCode': 'AD',
        'latitude': 42.47635833,
        'longitude': 1.48949167,
      },
    ],
  };

  static final List<CityModel> mockCities = CityModel.fromJsonList(
    mockResponse['data']!,
  );

  static final List<CityModel> mockHistory = List.generate(5, (i) {
    return CityModel(
      id: i + 10,
      name: 'City $i',
      countryCode: 'FC',
      coordinates: Coordinate(latitude: i * 1.1, longitude: i * 2.2),
    );
  });
}
