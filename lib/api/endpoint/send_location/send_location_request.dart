class SendLocationRequest {
  final String longitude;
  final String latitude;

  SendLocationRequest({
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toJson() => {"longitude": longitude, "latitude": latitude};
}
