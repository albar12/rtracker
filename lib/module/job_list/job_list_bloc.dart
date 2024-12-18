import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rtracker/module/job_list/job_list_event.dart';
import 'package:rtracker/module/job_list/job_list_state.dart';
import 'package:rtracker/realm/job_order_dao.dart';
import 'package:rtracker/realm/schemas.dart';

class JobListBloc extends Bloc<JobListEvent, JobListState> {
  JobListBloc() : super(JobListInitial()) {
    on<JobListLoad>(load);
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
}
