import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/homeClient.dart';
import 'package:flutter_app/screens/map/timer.dart';
import 'package:flutter_app/screens/sos/sosClient.dart';
import 'package:flutter_app/services/firestoreSos.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';



class MapPageClient extends StatefulWidget {
  const MapPageClient({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPageClient> {
  final _isHours = true;


  GoogleMapController mapController;
  Set<Marker> markers = new Set<Marker>();
  double lat = 40.45055321730234;
  double long = -8.797889649868011;

  String _uname = FirebaseAuth.instance.currentUser.displayName;

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


void _onMapCreated (GoogleMapController controller) {
  mapController = controller;
 ;
  LatLng porto = LatLng(40.451351526181575, -8.801396302878857);
  final Marker marker = Marker(
    markerId: new MarkerId("porto"),
    position: porto,
    infoWindow: InfoWindow(
      title: "Gaivotas Miguelito",
      snippet: "Ponto de Partida",
    )
  );
  setState(() {
    markers.add(marker);
  });
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
      body: Column(
        children: [
          Container(
          height: MediaQuery.of(context).size.height / 1.45,
            child: GoogleMap(
              //mapType: MapType.hybrid,
              onMapCreated: _onMapCreated,
              onCameraMove: (data) {
                print(data);
              },
              onTap: (position) {
                print(position);
                print("hello");
              },
              initialCameraPosition: CameraPosition(
                target:LatLng(lat, long),
                zoom:15.50,
              ),
              markers: markers,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                TimePage(),
                Padding(
                  padding: const EdgeInsets.only(top:24.0, left: 7),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.centerRight,
                        shape: CircleBorder(),
                        primary: Colors.red
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width/3.6,
                      height: MediaQuery.of(context).size.height/11,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Text(
                        'SOS',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    onPressed: () {
                      _showDialog();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
