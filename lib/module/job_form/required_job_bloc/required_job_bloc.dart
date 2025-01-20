import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rtracker/realm/job_order_dao.dart';
import 'package:rtracker/realm/schemas.dart';

part 'required_job_event.dart';
part 'required_job_state.dart';

class RequiredJobBloc extends Bloc<RequiredJobEvent, RequiredJobState> {
  RequiredJobBloc() : super(RequiredJobInitial()) {
    on<RequiredJobEvent>((event, emit) {
      if (event is LoadRequiredJob){
        emit(RequiredJobLoading());
        final listRequiredJobs = JobOrderDao.checkSameMidJobToday();
        emit(RequiredJobLoaded(data: listRequiredJobs));
      }
    });
  }
}
