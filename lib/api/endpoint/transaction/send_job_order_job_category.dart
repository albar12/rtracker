class SendJobOrderJobCategory {
  final String id;
  final bool value;

  SendJobOrderJobCategory({
    required this.id,
    required this.value,
  });

  Map<String, dynamic> toJson() => {"id": id, "value": value};
}
