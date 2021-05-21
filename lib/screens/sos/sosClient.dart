import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firestoreSos.dart';

class SosClientPage extends StatefulWidget {
  const SosClientPage({Key key}) : super(key: key);

  @override
  _SosClientPageState createState() => _SosClientPageState();
}

class _SosClientPageState extends State<SosClientPage> {

  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference Sos = FirebaseFirestore.instance.collection('Sos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido de Socorro',style: TextStyle(fontSize: 25, color: Colors.black)
        ),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();

          },
          icon: Icon(Icons.arrow_back_ios,

            color: Colors.black,
          ),
        ),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(

            child: SizedBox(height: 30,),

          ),

          FutureBuilder<DocumentSnapshot>(
            future: Sos.doc(uid).get(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data.exists) {
                return Container(child: Column(children: [Text("Sem nenhum pedido de socorro"),],),);
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();
                return Container(

                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 15.0),
                            child: Container(

                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage("${data['Foto']}"),
                                  )
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Text(data['Nome'], style:
                                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),


                                    SizedBox(height: 20),

                                  ],
                                ),
                                SizedBox(height: 5,),
                                Text('Data: '+data['Data'], style: TextStyle(fontSize: 16, color: Colors.black),),
                                SizedBox(height: 5,),
                                Text('Hora: '+data['Hora'], style: TextStyle(fontSize: 16, color: Colors.black),),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {


                              FirestoreSosDelete(uid);

                              //Navigator.of(context).pushReplacementNamed('/home');
                            },
                            child: Text('Apagar'),

                          )

                        ],
                      ),

                    ],
                  ),
                );
              }

              return Text("loading");
            },
          ),

        ],
      ),
    );
  }
}


