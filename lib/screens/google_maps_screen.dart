import 'package:dragonballgo/objects/ball_model.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/screens/choose_image_screen.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'listBalls_screen.dart';

class GoogleMapScreen extends StatefulWidget {
  final List<BallModel> listOfBalls;

  GoogleMapScreen({this.listOfBalls});

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  String _scanBarcode = 'Unknown';
  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;
  LatLng _initialcameraposition = LatLng(41.39432620402562, 2.1280503535672906);
  Location _location = Location();
  SessionManager manager = new SessionManager();
  Map<String, dynamic> balls;
  List<BallModel> ballsList;

  @override
  void initState() {
    super.initState();
    setCustomMarker();
    ballsList = widget.listOfBalls;
    // _markers = generateMarkers(ballsList);
    //Generate markers from this ballsList
    // generateMarkers(ballsList);

    // setState(() {
    //   getBalls().then((ballsList) => generateMarkers(ballsList));
    // });
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);

      var resp = await PickBall(barcodeScanRes);
      if (resp.statusCode == 201) {
        // Obtain a list of the available cameras on the device.

        NavigationManager(context).openScreen(ImageUpload());
      } else {}
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/unknown_ball_pk.png');
  }

  void _onMapCreated(GoogleMapController controller) async {
    // ballsList = await getBalls();
    controller.setMapStyle(Utils.mapStyle);
    _location.onLocationChanged.listen((l) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });

    // setState(() {
    for (int i = 0; i < ballsList.length; i++) {
      BallModel currentBallModel = ballsList[i];
      Marker marker = Marker(
          onTap: () {
            Future.delayed(Duration(milliseconds: 1200))
                .then((value) => scanBarcodeNormal());
          },
          markerId: MarkerId("id-${currentBallModel.id.toString()}"),
          position:
              LatLng(currentBallModel.latitude, currentBallModel.longitude),
          icon: mapMarker,
          infoWindow: InfoWindow(
              title: "Bola Numero ${currentBallModel.id.toString()}",
              snippet: "Cerca de "));
      setState(() {
        _markers.add(marker);
      });
    }

    //
    //   _markers.add(
    //     Marker(
    //         markerId: MarkerId('id-1'),
    //         position: LatLng(41.39262194039931, 2.1250778061462774),
    //         icon: mapMarker,
    //         infoWindow: InfoWindow(
    //           title: 'Bola Numero 1',
    //           snippet: 'Cerca de Don Bosco',
    //         )),
    //   );
    //   _markers.add(
    //     Marker(
    //         markerId: MarkerId('id-2'),
    //         position: LatLng(41.39751272297607, 2.1315177853781297),
    //         icon: mapMarker,
    //         infoWindow: InfoWindow(
    //           title: 'Bola Numero 2',
    //           snippet: 'Cerca de Via Augusta',
    //         )),
    //   );
    //   _markers.add(
    //     Marker(
    //         markerId: MarkerId('id-3'),
    //         position: LatLng(41.397475259744816, 2.123277412360181),
    //         icon: mapMarker,
    //         infoWindow: InfoWindow(
    //           title: 'Bola Numero 3',
    //           snippet: 'Cerca de Carrer Gran de Sarrià',
    //         )),
    //   );
    //   _markers.add(
    //     Marker(
    //         markerId: MarkerId('id-4'),
    //         position: LatLng(41.391101826371646, 2.1234163629342926),
    //         icon: mapMarker,
    //         infoWindow: InfoWindow(
    //           title: 'Bola Numero 4',
    //           snippet: 'Cerca del Hospital Cima',
    //         )),
    //   );
    //   _markers.add(
    //     Marker(
    //         markerId: MarkerId('id-5'),
    //         position: LatLng(41.39439790578477, 2.1322252026710737),
    //         icon: mapMarker,
    //         infoWindow: InfoWindow(
    //           title: 'Bola Numero 5',
    //           snippet: 'Cerca de General Mitre',
    //         )),
    //   );
    //   _markers.add(
    //     Marker(
    //         markerId: MarkerId('id-6'),
    //         position: LatLng(41.39640754861234, 2.127872044618878),
    //         icon: mapMarker,
    //         infoWindow: InfoWindow(
    //           title: 'Bola Numero 6',
    //           snippet: 'Cerca de unas pistas de deporte',
    //         )),
    //   );
    //   _markers.add(
    //     Marker(
    //         markerId: MarkerId('id-7'),
    //         position: LatLng(41.39086266121324, 2.1290207026776984),
    //         icon: mapMarker,
    //         infoWindow: InfoWindow(
    //           title: 'Bola Numero 7',
    //           snippet: 'Cerca del Hospital de Barcelona',
    //         )),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          GoogleMap(
            mapToolbarEnabled: false,
            compassEnabled: false,
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: _initialcameraposition,
              zoom: 15,
            ),
            myLocationEnabled: true,
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              height: 60,
              child: Image(image: AssetImage('assets/images/logo.png')),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
              child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child:
                      Image(image: AssetImage('assets/images/allBalls.png'))),
              onTap: () {
                NavigationManager(context).openScreenAsNew(ListBallsScreen(
                  listOfBalls: this.ballsList,
                ));
              },
            ),
          ),
        ]),
      ),
    );
  }

  Future<List<BallModel>> getBalls() async {
    String token = await manager.getToken();

    // Map<String, dynamic> balls = await FetchBalls(
    // latitude: 6.17790967, longitude: 16.17790967, token: token);

    // List<dynamic> list = balls.values.toList();
    List<BallModel> ballsList =
        List<BallModel>.generate(balls["body"].length, (int index) {
      Map currentBall = balls["body"][index];
      return BallModel(
          id: currentBall["num"],
          latitude: currentBall["latitude"],
          longitude: currentBall["longitude"],
          pickedDate:
              currentBall.containsKey("date") ? currentBall["date"] : null,
          image:
              currentBall.containsKey("image") ? currentBall["image"] : null);
    });
    return ballsList;
  }

  Set<Marker> generateMarkers(List<BallModel> ballsList) {
    Set<Marker> markers = {};
    for (int i = 0; i < ballsList.length; i++) {
      BallModel currentBallModel = ballsList[i];
      Marker marker = Marker(
          markerId: MarkerId("id-${currentBallModel.id}"),
          position:
              LatLng(currentBallModel.latitude, currentBallModel.longitude),
          icon: mapMarker,
          infoWindow: InfoWindow(
              title: "Bola Numero ${currentBallModel.id}",
              snippet: "Cerca de "));
      _markers.add(marker);
      bool added = markers.add(marker);

      print("Marker $i - Added: $added");
    }
    return markers;
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
