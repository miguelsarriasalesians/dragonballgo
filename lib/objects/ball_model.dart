import 'package:google_maps_flutter/google_maps_flutter.dart';

class BallModel {
  final int id;
  final String date;
  final String image;
  final MarkerId markerId;
  final double latitude;
  final double longitude;
  final BitmapDescriptor bitmapDescriptor;
  final InfoWindow infoWindow;

  BallModel(
      {this.bitmapDescriptor,
      this.infoWindow,
      this.image,
      this.markerId,
      this.latitude,
      this.longitude,
      this.id,
      this.date});
}
