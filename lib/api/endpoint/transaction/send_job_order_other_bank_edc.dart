class SendJobOrderOtherBankEdc {
  final String id;
  final bool value;

  SendJobOrderOtherBankEdc({
    required this.id,
    required this.value,
  });

  Map<String, dynamic> toJson() => {"id": id, "value": value};
}
