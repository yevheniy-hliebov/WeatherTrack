class Wind {
  final double speed;
  final double deg;
  final double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] as num?)?.toDouble() ?? 0,
      deg: (json['deg'] as num?)?.toDouble() ?? 0,
      gust: (json['gust'] as num?)?.toDouble() ?? 0,
    );
  }

  static const _directions = [
    'N',
    'NNE',
    'NE',
    'ENE',
    'E',
    'ESE',
    'SE',
    'SSE',
    'S',
    'SSW',
    'SW',
    'WSW',
    'W',
    'WNW',
    'NW',
    'NNW',
  ];

  String get direction {
    if (speed == 0) return 'Calm';
    final index = (deg / 22.5).round() % 16;
    return _directions[index];
  }

  @override
  String toString() {
    return 'Wind(speed: $speed, deg: $deg, gust: $gust, direction: $direction)';
  }
}
