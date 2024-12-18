class GetAppVersionResponseDetail {
  final int id_primary;
  final int id_versi_aplikasi;
  final String versi_aplikasi;
  final int id_tipe_edc;
  final int android;
  final int vendor_id;
  final int version;

  GetAppVersionResponseDetail({
    required this.id_primary,
    required this.id_versi_aplikasi,
    required this.versi_aplikasi,
    required this.id_tipe_edc,
    required this.android,
    required this.vendor_id,
    required this.version,
  });

  factory GetAppVersionResponseDetail.fromJson(Map<String, dynamic> json) {
    return GetAppVersionResponseDetail(
      id_primary: json['id_primary'],
      id_versi_aplikasi: json['id_versi_aplikasi'],
      versi_aplikasi: json['versi_aplikasi'],
      id_tipe_edc: json['id_tipe_edc'],
      android: json['android'],
      vendor_id: json['vendor_id'],
      version: json['version'],
    );
  }
}
