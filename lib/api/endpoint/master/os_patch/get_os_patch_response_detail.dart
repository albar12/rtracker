class GetOsPatchResponseDetail {
  final int id_os_patch;
  final String os_patch_name;
  final int id_versi_aplikasi;
  final int id_tipe_edc;
  final int vendor_id;
  final int version;

  GetOsPatchResponseDetail({
    required this.id_os_patch,
    required this.os_patch_name,
    required this.id_versi_aplikasi,
    required this.id_tipe_edc,
    required this.vendor_id,
    required this.version,
  });

  factory GetOsPatchResponseDetail.fromJson(Map<String, dynamic> json) {
    return GetOsPatchResponseDetail(
      id_os_patch: json['id_os_patch'],
      os_patch_name: json['os_patch_name'],
      id_versi_aplikasi: json['id_versi_aplikasi'],
      id_tipe_edc: json['id_tipe_edc'],
      vendor_id: json['vendor_id'],
      version: json['version'],
    );
  }
}
