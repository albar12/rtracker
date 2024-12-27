import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rtracker/realm/schemas.dart';

part 'thermal_count_event.dart';
part 'thermal_count_state.dart';

class ThermalCountBloc extends Bloc<ThermalCountEvent, ThermalCountState> {
  ThermalCountBloc() : super(ThermalCountInitial(0)) {
    on<ThermalCountEvent>((event, emit) {
      if (event is UpdateThermalCount){
        int total = 0;
        for (var element in event.list) {
          if (element.category.contains("Faktur")) {
            total += element.quantity.toInt();
          }
        }
        emit(ThermalCountInitial(total));
      }
    });
  }
}
