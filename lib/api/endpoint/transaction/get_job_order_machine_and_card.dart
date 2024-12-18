import 'package:rtracker/api/endpoint/transaction/get_job_order_edc_communication_type.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_edc_type.dart';
import 'package:rtracker/api/endpoint/transaction/get_job_order_provider.dart';

class GetJobOrderMachineAndCard {
  final String simCard;
  final GetJobOrderProvider? provider;
  final String sam;
  final String sam2;
  final String sam3;
  final String sam4;
  final String sam5;
  final String sam6;
  final String sam7;
  final GetJobOrderEdcType? edcType;
  final GetJobOrderEdcCommunicationType? edcCommunicationType;
  final List<String> images;
  final List<String> serialNumberPhotos;

  GetJobOrderMachineAndCard({
    required this.simCard,
    required this.provider,
    required this.sam,
    required this.sam2,
    required this.sam3,
    required this.sam4,
    required this.sam5,
    required this.sam6,
    required this.sam7,
    required this.edcType,
    required this.edcCommunicationType,
    required this.images,
    required this.serialNumberPhotos,
  });

  factory GetJobOrderMachineAndCard.fromJson(Map<String, dynamic> json) => GetJobOrderMachineAndCard(
        simCard: json["simCard"] ?? '',
        provider: json["provider"] != null ? GetJobOrderProvider.fromJson(json["provider"]) : null,
        sam: json["sam"] ?? '',
        sam2: json["sam2"] ?? '',
        sam3: json["sam3"] ?? '',
        sam4: json["sam4"] ?? '',
        sam5: json["sam5"] ?? '',
        sam6: json["sam6"] ?? '',
        sam7: json["sam7"] ?? '',
        edcType: json["edcType"] != null ? GetJobOrderEdcType.fromJson(json["edcType"]) : null,
        edcCommunicationType: json["edcCommunicationType"] != null
            ? GetJobOrderEdcCommunicationType.fromJson(
                json["edcCommunicationType"],
              )
            : null,
        images: json["images"] != null ? List<String>.from(json["images"].map((x) => x)) : [],
        serialNumberPhotos: json["serialNumberPhotos"] != null ? List<String>.from(json["serialNumberPhotos"].map((x) => x)) : [],
      );
}
