class GetJobOrderStatus {
  final String id;
  final String name;
  final String categoryId;
  final String categoryName;
  final DateTime? newVisitDate;

  GetJobOrderStatus({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.newVisitDate,
  });

  factory GetJobOrderStatus.fromJson(Map<String, dynamic> json) => GetJobOrderStatus(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        categoryId: json["categoryId"] ?? '',
        categoryName: json["categoryName"] ?? '',
        newVisitDate: DateTime.tryParse(json["newVisitDate"] ?? ''),
      );
}
