import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/constant.dart';

part 'start_job_event.dart';
part 'start_job_state.dart';

class StartJobBloc extends Bloc<StartJobEvent, StartJobState> {
  StartJobBloc() : super(StartJobInitial(readOnly: true)) {
    on<StartJobEvent>((event, emit) {
      if (event is ChangeStatus){
        bool status = false;
        if (event.readOnly){
          status = true;
        } else {
          if (event.status == Progress.start){
            status = false;
          } else {
            status = true;
          }
        }
        emit(StartJobInitial(readOnly: status));
      }
    });
  }
}
