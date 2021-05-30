import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/screens/map/timer.dart';
import 'package:flutter_app/services/firestoreSos.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';



void main() => runApp(MapPageClient());


class MapPageClient extends StatefulWidget {
  MapPageClient({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MapPageClientState createState() => _MapPageClientState();
}


class _MapPageClientState extends State<MapPageClient> {

  var porto;
  String _uname = FirebaseAuth.instance.currentUser.displayName;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;


  _callNumber() async{
    const number = '919191919'; //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }



  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red[100],
          title: const Text(
            'Pedido de Socorro',style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 30,
            color: Colors.black,
          ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(height: 30),
                MaterialButton(
                    height: 60,
                    onPressed: () {
                      _callNumber();

                    },
                    color: Colors.black12,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text(
                          'GNR', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        ),
                        Icon(
                            Icons.local_police,
                            size: 40),
                      ],
                    )
                ),
                SizedBox(height: 20),
                MaterialButton(
                    height: 60,
                    onPressed: () {
                      _callNumber();

                    },
                    color: Colors.black12,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text(
                          'Bombeiros', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        ),
                        Icon(
                            Icons.fire_extinguisher,
                            size: 40),

                      ],
                    )
                ),
                SizedBox(height: 20),
                MaterialButton(
                    height: 60,
                    onPressed: () {
                      FirestoreCreateSos(_uname,);


                    },
                    color: Colors.black12,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text(
                          'Empresa', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        ),
                        Icon(

                            Icons.directions_boat_outlined,
                            size: 40),

                      ],
                    )
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
                height: 60,
                onPressed: () {
                  Navigator.of(context).pop();

                },

                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 30,color: Colors.black,),

                  ],
                )
            ),

          ],
        );
      },
    );
  }



  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(40.45055321730234, -8.797889649868011),
    zoom: 15.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/boat.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("boat"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));

      final Marker markere = Marker(
          markerId: new MarkerId("porto"),
          position: porto,
          infoWindow: InfoWindow(
            title: "Gaivotas Miguelito",
            snippet: "Ponto de Partida",
          )
      );

    }
    );
  }

  void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              zoom: 16.00)));
          updateMarkerAndCircle(newLocalData, imageData);
          print(LatLng(newLocalData.latitude, newLocalData.longitude));
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            children: [

              Container(

                height: MediaQuery.of(context).size.height / 1.50,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: initialLocation,
                  markers: Set.of((marker != null) ? [marker] : []),
                  circles: Set.of((circle != null) ? [circle] : []),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                ),

              ),
              Row(
                children: [
                  TimePage(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:10.0, left: 5),
                    child: MaterialButton(
                      color: Colors.red,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                      onPressed: () {
                        _showDialog();
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_alert,
                            color: Colors.white,
                            size: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.only (bottom: 8),
                            child: Text(
                              'SOS',
                              style: TextStyle(fontSize:25, color:Colors.white),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top:25.0),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
    child: Icon(Icons.location_searching),
    onPressed: () {
    getCurrentLocation();
    }),
          ),
        ),
    );
  }
}
