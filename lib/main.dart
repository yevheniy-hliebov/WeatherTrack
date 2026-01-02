import 'package:flutter/material.dart';
import 'package:weathertrack/core/theme/theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherTrack App',
      theme: AppTheme.theme,
      home: const Scaffold(body: Center(child: Text('WeatherTrack'))),
    );
  }
}
