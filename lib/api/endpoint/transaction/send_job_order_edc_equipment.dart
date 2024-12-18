class SendJobOrderEdcEquipment {
  final String name;
  final int quantity;

  SendJobOrderEdcEquipment({
    required this.name,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {"name": name, "quantity": quantity};
}
