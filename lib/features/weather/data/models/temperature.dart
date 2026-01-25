class Temperature {
  final double temp;
  final double feelsLike;
  final double min;
  final double max;

  Temperature({
    required this.temp,
    required this.feelsLike,
    required this.min,
    required this.max,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) {
    double parseValue(dynamic value) {
      return (value as num?)?.toDouble() ?? 0.0;
    }

    return Temperature(
      temp: parseValue(json['temp']),
      feelsLike: parseValue(json['feels_like']),
      min: parseValue(json['temp_min']),
      max: parseValue(json['temp_max']),
    );
  }

  String get tempString => '${temp.round()}°';
  String get feelsLikeString => '${feelsLike.round()}°';

  @override
  String toString() => 'Temperature(temp: ${temp.round()}°C)';
}
