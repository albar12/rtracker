class GetOtherBankEdcResponseDetail {
  final String id;
  final String name;
  final int version;

  GetOtherBankEdcResponseDetail({
    required this.id,
    required this.name,
    required this.version,
  });

  factory GetOtherBankEdcResponseDetail.fromJson(Map<String, dynamic> json) => GetOtherBankEdcResponseDetail(
        id: json["id"].toString(),
        name: json["name"],
        version: json["version"],
      );
}
