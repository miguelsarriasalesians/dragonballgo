List<BallModel> listToBalls(List<dynamic> list) {
  return List<BallModel>.generate(list.length, (int index) {
    return BallModel.fromJson(list[index]);
  });
}

class BallModel {
  final int id;
  final DateTime pickedDate;
  final String image;
  final double latitude;
  final double longitude;
  final bool picked;
  final String info;

  BallModel(
      {this.image,
      this.latitude,
      this.longitude,
      this.id,
      this.pickedDate,
      this.picked,
      this.info});

  BallModel.fromJson(Map<String, dynamic> json)
      : id = json["num"],
        latitude = json["latitude"],
        longitude = json["longitude"],
        picked = json["picked"],
        pickedDate = json.containsKey("pickedDate")
            ? DateTime.parse(json["pickedDate"])
            : null,
        image = json.containsKey("image") ? json["image"] : null,
        info = json["info"];
}
