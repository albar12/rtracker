class SendJobOrderTrainingMaterial {
  final String id;
  final bool value;

  SendJobOrderTrainingMaterial({
    required this.id,
    required this.value,
  });

  Map<String, dynamic> toJson() => {"id": id, "value": value};
}
