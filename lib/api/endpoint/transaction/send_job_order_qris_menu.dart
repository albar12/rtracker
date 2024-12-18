class SendJobOrderQrisMenu {
  final String id;
  final bool value;

  SendJobOrderQrisMenu({
    required this.id,
    required this.value,
  });

  Map<String, dynamic> toJson() => {"id": id, "value": value};
}
