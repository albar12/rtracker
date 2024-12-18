class SendJobOrderTransactionTestCase {
  final String id;
  final bool value;

  SendJobOrderTransactionTestCase({
    required this.id,
    required this.value,
  });

  Map<String, dynamic> toJson() => {"id": id, "value": value};
}
