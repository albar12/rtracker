import 'package:bloc/bloc.dart';
import 'package:rtracker/module/job_filter/bloc/job_filter_event.dart';
import 'package:rtracker/module/job_filter/bloc/job_filter_state.dart';
import 'package:rtracker/realm/base_office_dao.dart';
import 'package:rtracker/realm/document_status_dao.dart';
import 'package:rtracker/realm/job_type_dao.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/realm/service_point_dao.dart';
import 'package:rtracker/realm/vendor_dao.dart';

class JobFilterBloc extends Bloc<JobFilterEvent, JobFilterState> {
  JobFilterBloc() : super(JobFilterInitial()) {
    on<JobFilterStarted>(_onJobFilterStarted);
    on<JobFilterVendorBaseOfficeSelected>(_onJobFilterVendorBaseOfficeSelected);
  }

  _onJobFilterStarted(JobFilterStarted event, Emitter<JobFilterState> emit) {
    emit(JobFilterLoading());

    try {
      List<Vendor> vendors = VendorDao.all();
      List<BaseOffice> baseOffices = BaseOfficeDao.all();
      List<DocumentStatus> documentStatuses = DocumentStatusDao.all();

      emit(JobFilterLoaded(vendors, baseOffices, documentStatuses));
    } catch (e) {
      print(e);
    }
  }

  _onJobFilterVendorBaseOfficeSelected(
    JobFilterVendorBaseOfficeSelected event,
    Emitter<JobFilterState> emit,
  ) {
    try {
      List<ServicePoint> servicePoints = ServicePointDao.all(
        vendorId: event.vendorId,
        baseOfficeId: event.baseOfficeId,
      );

      List<JobType> jobTypes = JobTypeDao.all(vendorId: event.vendorId);

      emit(JobFilterOthersLoaded(servicePoints, jobTypes));
    } catch (e) {
      print(e);
    }
  }
}
