class CheckVersionRequest {
  final List<CheckVersionRequestDetail> versions;

  CheckVersionRequest({
    required this.versions,
  });

  factory CheckVersionRequest.fromJson(Map<String, dynamic> json) => CheckVersionRequest(
        versions: json["versions"] != null
            ? List<CheckVersionRequestDetail>.from(
                json["versions"].map((x) => CheckVersionRequestDetail.fromJson(x)),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {"versions": List<dynamic>.from(versions.map((x) => x.toJson()))};
}

class CheckVersionRequestDetail {
  final String key;
  final int value;

  CheckVersionRequestDetail({
    required this.key,
    required this.value,
  });

  factory CheckVersionRequestDetail.fromJson(Map<String, dynamic> json) => CheckVersionRequestDetail(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
