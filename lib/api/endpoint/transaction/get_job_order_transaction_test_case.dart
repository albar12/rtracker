class GetJobOrderTransactionTestCase {
  final String id;
  final String name;
  final String amount;
  final bool value;

  GetJobOrderTransactionTestCase({
    required this.id,
    required this.name,
    required this.amount,
    required this.value,
  });

  factory GetJobOrderTransactionTestCase.fromJson(Map<String, dynamic> json) => GetJobOrderTransactionTestCase(
        id: json["id"],
        name: json["name"],
        amount: json["amount"].toString(),
        value: json["value"],
      );
}
