import 'package:rtracker/api/endpoint/transaction/get_job_order_dor_menu.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_eos_update_status.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_marcoll_update_status.dart';

class GetJobOrderEdcUpdate {
  final GetJobOrderDorMenu? dorMenu;
  final GetJobOrderMarcollUpdateStatus? marcollUpdateStatus;
  final GetJobOrderEosUpdateStatus? eosUpdateStatus;

  GetJobOrderEdcUpdate({
    required this.dorMenu,
    required this.marcollUpdateStatus,
    required this.eosUpdateStatus,
  });

  factory GetJobOrderEdcUpdate.fromJson(Map<String, dynamic> json) => GetJobOrderEdcUpdate(
        dorMenu: json["dorMenu"] != null ? GetJobOrderDorMenu.fromJson(json["dorMenu"]) : null,
        marcollUpdateStatus: json["marcollUpdateStatus"] != null
            ? GetJobOrderMarcollUpdateStatus.fromJson(
                json["marcollUpdateStatus"],
              )
            : null,
        eosUpdateStatus: json["eosUpdateStatus"] != null ? GetJobOrderEosUpdateStatus.fromJson(json["eosUpdateStatus"]) : null,
      );
}
