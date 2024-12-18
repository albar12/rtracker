class SendJobOrderEdcFeatureTestCase {
  final String id;
  final bool value;

  SendJobOrderEdcFeatureTestCase({
    required this.id,
    required this.value,
  });

  Map<String, dynamic> toJson() => {"id": id, "value": value};
}
