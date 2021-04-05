import 'package:google_maps_flutter/google_maps_flutter.dart';

class BallModel {
  final int id;
  final String pickedDate;
  final String image;
  final double latitude;
  final double longitude;
  final BitmapDescriptor bitmapDescriptor;
  final MarkerId markerId;
  final InfoWindow infoWindow;
  final bool picked;

  BallModel(
      {this.bitmapDescriptor,
      this.infoWindow,
      this.image,
      this.markerId,
      this.latitude,
      this.longitude,
      this.id,
      this.pickedDate,
      this.picked});
}
