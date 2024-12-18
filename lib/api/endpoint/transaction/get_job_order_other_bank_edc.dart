class GetJobOrderOtherBankEdc {
  final String id;
  final String name;
  final bool value;

  GetJobOrderOtherBankEdc({
    required this.id,
    required this.name,
    required this.value,
  });

  factory GetJobOrderOtherBankEdc.fromJson(Map<String, dynamic> json) => GetJobOrderOtherBankEdc(
        id: json["id"],
        name: json["name"],
        value: json["value"],
      );
}
