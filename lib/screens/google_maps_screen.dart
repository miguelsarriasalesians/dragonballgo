import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;
  LatLng _initialcameraposition = LatLng(41.39432620402562, 2.1280503535672906);
  Location _location = Location();

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/unknown_ball_pk.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyle);
    _location.onLocationChanged.listen((l) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId('id-1'),
            position: LatLng(41.39262194039931, 2.1250778061462774),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: 'Bola Numero 1',
              snippet: 'Cerca de Don Bosco',
            )),
      );
      _markers.add(
        Marker(
            markerId: MarkerId('id-2'),
            position: LatLng(41.39751272297607, 2.1315177853781297),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: 'Bola Numero 2',
              snippet: 'Cerca de Via Augusta',
            )),
      );
      _markers.add(
        Marker(
            markerId: MarkerId('id-3'),
            position: LatLng(41.397475259744816, 2.123277412360181),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: 'Bola Numero 3',
              snippet: 'Cerca de Carrer Gran de Sarrià',
            )),
      );
      _markers.add(
        Marker(
            markerId: MarkerId('id-4'),
            position: LatLng(41.391101826371646, 2.1234163629342926),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: 'Bola Numero 4',
              snippet: 'Cerca del Hospital Cima',
            )),
      );
      _markers.add(
        Marker(
            markerId: MarkerId('id-5'),
            position: LatLng(41.39439790578477, 2.1322252026710737),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: 'Bola Numero 5',
              snippet: 'Cerca de General Mitre',
            )),
      );
      _markers.add(
        Marker(
            markerId: MarkerId('id-6'),
            position: LatLng(41.39640754861234, 2.127872044618878),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: 'Bola Numero 6',
              snippet: 'Cerca de unas pistas de deporte',
            )),
      );
      _markers.add(
        Marker(
            markerId: MarkerId('id-7'),
            position: LatLng(41.39086266121324, 2.1290207026776984),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: 'Bola Numero 7',
              snippet: 'Cerca del Hospital de Barcelona',
            )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          GoogleMap(
            mapToolbarEnabled: false,
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: _initialcameraposition,
              zoom: 15,
            ),
            myLocationEnabled: true,
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: ModalSheet(
              child: Container(
                height: 50,
                width: 100,
                color: Colors.yellow,
              ),
              screenToNavigate: LoginScreen(),
            ),
          )
        ]),
      ),
    );
  }
}

class ModalSheet extends StatefulWidget {
  @override
  _ModalSheetState createState() => _ModalSheetState();
  final Widget child;
  final Widget screenToNavigate;

  ModalSheet({@required this.child, @required this.screenToNavigate});
}

class _ModalSheetState extends State<ModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: widget.child,
        onTap: () {
          showModalBottomSheet<void>(
              context: context,
              barrierColor: Colors.transparent,
              builder: (BuildContext context) => widget.screenToNavigate);
        },
      ),
    );
  }
}

class Utils {
  static String mapStyle = '''
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#523735"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#c9b2a6"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#dcd2be"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#ae9e90"
      }
    ]
  },
  {
    "featureType": "administrative.neighborhood",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#93817c"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a5b076"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#447530"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#fdfcf8"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f8c967"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#e9bc62"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e98d58"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#db8555"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#806b63"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8f7d77"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#b9d3c2"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#92998d"
      }
    ]
  }
]
  ''';
}
