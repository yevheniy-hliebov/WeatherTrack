class AtmosphericPressure {
  final int pressure;
  final int seaLevel;
  final int groundLevel;

  AtmosphericPressure({
    required this.pressure,
    required this.seaLevel,
    required this.groundLevel,
  });

  factory AtmosphericPressure.fromJson(Map<String, dynamic> json) {
    return AtmosphericPressure(
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      groundLevel: json['grnd_level'],
    );
  }

  String get pressureString => '$pressure hPa';

  @override
  String toString() => 'AtmosphericPressure(p: $pressure, sea: $seaLevel, grnd: $groundLevel)';
}
