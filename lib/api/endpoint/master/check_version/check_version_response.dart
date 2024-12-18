class CheckVersionResponse {
  CheckVersionResponse({
    required this.versions,
  });

  final List<String?> versions;

  factory CheckVersionResponse.fromJson(Map<String, dynamic> json) =>
      CheckVersionResponse(
        versions: json["versions"] != null
            ? List<String?>.from(json["versions"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "versions": List<dynamic>.from(versions.map((x) => x)),
      };
}
