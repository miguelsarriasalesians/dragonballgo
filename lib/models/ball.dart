import 'dart:convert';

List<BallModel> jsonToBalls(String str) =>
    List<BallModel>.from(json.decode(str).map((x) => BallModel.fromJSON(x)));

String ballsToJson(List<BallModel> balls) => json.encode(balls);

class BallModel {
  final int num;
  final DateTime updatedAt;
  final double latitude;
  final double longitude;

  BallModel({this.num, this.updatedAt, this.latitude, this.longitude});

  factory BallModel.fromJSON(Map<String, dynamic> json) {
    return BallModel(
        num: int.parse(json["num"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latitude: double.parse(json["latitude"]),
        longitude: double.parse(json["longitude"]));
  }

  Map<String, dynamic> toJson() => {
        "num": num,
        "updatedAt": updatedAt.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
      };
}
