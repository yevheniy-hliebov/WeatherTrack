import 'package:flutter/material.dart';
import 'package:weathertrack/core/di/service_locator.dart';
import 'package:weathertrack/core/theme/theme.dart';
import 'package:weathertrack/core/theme/components/system_ui_style.dart';
import 'package:weathertrack/features/city_history/data/city_history_repository.dart';
import 'package:weathertrack/features/city_history/presentation/providers/city_history_provider.dart';
import 'package:weathertrack/features/city_search/data/city_search_repository.dart';
import 'package:weathertrack/features/city_search/presentation/providers/city_search_provider.dart';
import 'package:provider/provider.dart';
import 'package:weathertrack/features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  SystemUiStyle.configure();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherTrack App',
      theme: AppTheme.theme,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CitySearchProvider(
              CitySearchRepository(),
              debounceDuration: const Duration(seconds: 1),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => CityHistoryProvider(
              CityHistoryRepository(prefs: getIt<SharedPreferences>()),
            ),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
