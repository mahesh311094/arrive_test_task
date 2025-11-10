class IpLookupModel {
  final String ip;
  final double latitude;
  final double longitude;

  IpLookupModel({
    required this.ip,
    required this.latitude,
    required this.longitude,
  });

  factory IpLookupModel.fromJson(Map<String, dynamic> json) {
    final ip = json['ip'].toString();
    final latitude = double.parse(json['latitude'].toString());
    final longitude = double.parse(json['longitude'].toString());
    return IpLookupModel(ip: ip, latitude: latitude, longitude: longitude);
  }

  Map<String, dynamic> toJson() {
    return {'ip': ip, 'latitude': latitude, 'longitude': longitude};
  }
}
