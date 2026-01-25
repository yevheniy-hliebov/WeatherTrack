class WeatherCondition {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    final rawDescription = json['description'] as String? ?? '';

    final formattedDescription = rawDescription.isNotEmpty
        ? rawDescription[0].toUpperCase() + rawDescription.substring(1)
        : '';

    return WeatherCondition(
      id: (json['id'] as num?)?.toInt() ?? 0,
      main: json['main'] as String? ?? '',
      description: formattedDescription,
      icon: json['icon'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return 'WeatherCondition(id: $id, main: $main, description: $description, icon: $icon)';
  }
}
