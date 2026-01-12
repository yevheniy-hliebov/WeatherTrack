import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathertrack/common/widgets/search_text_field.dart';
import 'package:weathertrack/common/models/city_model.dart';
import 'package:weathertrack/features/city_search/presentation/providers/city_search_provider.dart';

class CitySearchBar extends StatelessWidget {
  final void Function(CityModel city)? onSelect;
  const CitySearchBar({super.key, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CitySearchProvider>();

    return SearchTextField<CityModel>(
      hintText: 'Search city...',
      isLoading: provider.state.isLoading,
      displaySuggestionText: (item) => item.nameAndCountryCode,
      displaySelectionText: (item) => item.name,
      suggestions: provider.state.cities,
      onChanged: (query) => provider.onQueryChanged(query),
      onSelect: onSelect,
      errorMessage: provider.state.errorMessage,
    );
  }
}

final data = [
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
  {
    'id': 3406038,
    'wikiDataId': 'Q4699394',
    'type': 'CITY',
    'city': 'Aixàs',
    'name': 'Aixàs',
    'country': 'Andorra',
    'countryCode': 'AD',
    'region': 'Sant Julià de Lòria',
    'regionCode': '06',
    'latitude': 42.48638889,
    'longitude': 1.46722222,
    'population': 0,
  },
  {
    'id': 397,
    'wikiDataId': 'Q1863',
    'type': 'CITY',
    'city': 'Andorra la Vella',
    'name': 'Andorra la Vella',
    'country': 'Andorra',
    'countryCode': 'AD',
    'region': 'Andorra la Vella',
    'regionCode': '07',
    'latitude': 42.5,
    'longitude': 1.5,
    'population': 22151,
  },
  {
    'id': 3360277,
    'wikiDataId': 'Q24475',
    'type': 'CITY',
    'city': 'Ansalonga',
    'name': 'Ansalonga',
    'country': 'Andorra',
    'countryCode': 'AD',
    'region': 'Ordino',
    'regionCode': '05',
    'latitude': 42.568443,
    'longitude': 1.521571,
    'population': 0,
  },
  {
    'id': 3406038,
    'wikiDataId': 'Q4699394',
    'type': 'CITY',
    'city': 'Aixàs',
    'name': 'Aixàs',
    'country': 'Andorra',
    'countryCode': 'AD',
    'region': 'Sant Julià de Lòria',
    'regionCode': '06',
    'latitude': 42.48638889,
    'longitude': 1.46722222,
    'population': 0,
  },
];
