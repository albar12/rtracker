class GetJobOrderTiming {
  final DateTime? departure;
  final String? departureCoordinate;
  final DateTime? visit;
  final String? visitCoordinate;
  final DateTime? start;
  final String? startCoordinate;
  final DateTime? pause;
  final String? pauseCoordinate;
  final DateTime? finish;
  final String? finishCoordinate;

  GetJobOrderTiming({
    required this.departure,
    required this.departureCoordinate,
    required this.visit,
    required this.visitCoordinate,
    required this.start,
    required this.startCoordinate,
    required this.pause,
    required this.pauseCoordinate,
    required this.finish,
    required this.finishCoordinate,
  });

  factory GetJobOrderTiming.fromJson(Map<String, dynamic> json) => GetJobOrderTiming(
        departure: DateTime.tryParse(json["departure"] ?? ''),
        departureCoordinate: json["departureCoordinate"],
        visit: DateTime.tryParse(json["visit"] ?? ''),
        visitCoordinate: json["visitCoordinate"],
        start: DateTime.tryParse(json["start"] ?? ''),
        startCoordinate: json["startCoordinate"],
        pause: DateTime.tryParse(json["pause"] ?? ''),
        pauseCoordinate: json["pauseCoordinate"],
        finish: DateTime.tryParse(json["finish"] ?? ''),
        finishCoordinate: json["finishCoordinate"],
      );
}
