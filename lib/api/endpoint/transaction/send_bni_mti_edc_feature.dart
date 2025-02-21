class SendBniMtiEdcFeature {
  final String id;
  final bool value;

  SendBniMtiEdcFeature({
    required this.id,
    required this.value,
  });

  Map<String, dynamic> toJson() => {"id": id, "value": value};
}