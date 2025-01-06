import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:rtracker/module/job_list/job_list_event.dart';
import 'package:rtracker/module/job_list/job_list_state.dart';
import 'package:rtracker/realm/job_order_dao.dart';
import 'package:rtracker/realm/schemas.dart';

class JobListBloc extends Bloc<JobListEvent, JobListState> {
  JobListBloc() : super(JobListInitial()) {
    on<JobListLoad>(load);
    on<SyncFinishedJo>(syncFinishedJo);
  }

  FutureOr<void> load(JobListLoad event, Emitter<JobListState> emit) async {
    List<JobOrder> jobOrders = JobOrderDao.list(
      finished: event.finished,
      jobOrderFilter: event.jobOrderFilter,
    );

    emit(
      JobListLoaded(
        jobOrders: jobOrders,
      ),
    );
  }

  FutureOr<void> syncFinishedJo(SyncFinishedJo event, Emitter<JobListState> emit) async {
    emit(LoadingSync());
    try {
      Response response = await ApiManager().syncFinishedJo(
        ids: event.ids,
      );
      if (response.statusCode == 200 && response.data != null){
        List<dynamic> jsonResponse = response.data;
        JobOrderDao.updateSyncList(List<String>.from(jsonResponse));
        emit(FinishedSync());
      } else {
        emit(FailedSync());
      }
    } catch (e){
      emit(FailedSync());
    }
  }
}
