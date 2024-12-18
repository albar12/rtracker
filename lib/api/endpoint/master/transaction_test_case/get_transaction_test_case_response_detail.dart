class GetTransactionTestCaseResponseDetail {
  final String id;
  final String jobTypeId;
  final String name;
  final String amount;
  final int version;

  GetTransactionTestCaseResponseDetail({
    required this.id,
    required this.jobTypeId,
    required this.name,
    required this.amount,
    required this.version,
  });

  factory GetTransactionTestCaseResponseDetail.fromJson(
    Map<String, dynamic> json,
  ) =>
      GetTransactionTestCaseResponseDetail(
        id: json["id"].toString(),
        jobTypeId: json["jobTypeId"].toString(),
        name: json["name"],
        amount: json["amount"],
        version: json["version"],
      );
}
