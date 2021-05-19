import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/homeClient.dart';
import 'package:flutter_app/screens/sos/sos.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  GoogleMapController mapController;
  Set<Marker> markers = new Set<Marker>();
  double lat = 40.45055321730234;
  double long = -8.797889649868011;

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
      body: Column(
        children: [
          Container(
          height: 500,
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
          
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                primary: Colors.red
            ),
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Text(
                'SOS',
                style: TextStyle(fontSize: 24),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Sos()));
            },
          )


        ],
      )
    );
  }
}
