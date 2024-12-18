class GetJobOrderEosUpdateStatus {
  final String id;
  final String name;

  GetJobOrderEosUpdateStatus({
    required this.id,
    required this.name,
  });

  factory GetJobOrderEosUpdateStatus.fromJson(Map<String, dynamic> json) => GetJobOrderEosUpdateStatus(
        id: json["id"],
        name: json["name"],
      );
}
