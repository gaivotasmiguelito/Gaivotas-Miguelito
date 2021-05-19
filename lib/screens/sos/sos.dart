import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class Sos extends StatefulWidget {
  @override
  _SosState createState() => _SosState();

}

class _SosState extends State<Sos> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'Pedido de Socorro',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 40.0,
                      color: Colors.blue,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: SizedBox(
                    height: 20.0,
                    width: 150.0,
                    child: Divider(
                      color: Colors.teal.shade100,
                    ),
                  ),
                ),
                // This is the type used by the popup menu below.


// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
        PopupMenuButton<WhyFarther>(
        onSelected: (WhyFarther result) { setState(() { var _selection = result; }); },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
    const PopupMenuItem<WhyFarther>(
    value: WhyFarther.harder,
    child: Text('Working a lot harder'),
    ),
    const PopupMenuItem<WhyFarther>(
    value: WhyFarther.smarter,
    child: Text('Being a lot smarter'),
    ),
    const PopupMenuItem<WhyFarther>(
    value: WhyFarther.selfStarter,
    child: Text('Being a self-starter'),
    ),
    const PopupMenuItem<WhyFarther>(
    value: WhyFarther.tradingCharter,
    child: Text('Placed in charge of trading charter'),
    ),
    ],
    ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.blueGrey,
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            print("chamada");
                          },
                          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 43.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 60.0),
                                child: Text(
                                  'Bombeiros',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Icon(

                                  Icons.fire_extinguisher,
                                  size: 50),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.blueGrey,
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            print("chamada");
                          },
                          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 43.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 65.0),
                                child: Text(
                                  'Empresa   ',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Icon(
                                  Icons.directions_boat_outlined,
                                  size: 50),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            )),
    );
  }
}

//Navigator.pushNamed(context, 'login');