class LoginRequest {
  LoginRequest({
    required this.username,
    required this.password,
    required this.imei,
    required this.token,
    required this.latitude,
    required this.longitude,
  });

  final String username;
  final String password;
  final String imei;
  final String token;
  final String latitude;
  final String longitude;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        username: json["username"],
        password: json["password"],
        imei: json["imei"],
        token: json["token"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "imei": imei,
        "token": token,
        "latitude": latitude,
        "longitude": longitude,
      };
}
