import 'package:rtracker/helper/formats.dart';

class SendJobOrderTiming {
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

  SendJobOrderTiming({
    this.departure,
    this.departureCoordinate,
    this.visit,
    this.visitCoordinate,
    this.start,
    this.startCoordinate,
    this.pause,
    this.pauseCoordinate,
    this.finish,
    this.finishCoordinate,
  });

  Map<String, dynamic> toJson() => {
        "departure": Formats.isoDateTime(departure),
        "departureCoordinate": departureCoordinate,
        "visit": Formats.isoDateTime(visit),
        "visitCoordinate": visitCoordinate,
        "start": Formats.isoDateTime(start),
        "startCoordinate": startCoordinate,
        "pause": Formats.isoDateTime(pause),
        "pauseCoordinate": pauseCoordinate,
        "finish": Formats.isoDateTime(finish),
        "finishCoordinate": finishCoordinate
      };
}
