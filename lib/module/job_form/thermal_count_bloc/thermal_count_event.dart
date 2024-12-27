part of 'thermal_count_bloc.dart';

@immutable
class ThermalCountEvent {}

class UpdateThermalCount extends ThermalCountEvent {
  final List<JobOrderInputPeripheral> list;
  UpdateThermalCount(this.list);
}
