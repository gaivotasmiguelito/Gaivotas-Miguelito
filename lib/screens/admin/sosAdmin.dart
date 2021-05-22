import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firestoreSos.dart';

class SosAdmin extends StatefulWidget {
  const SosAdmin({Key key}) : super(key: key);

  @override
  _SosAdminState createState() => _SosAdminState();
}

class _SosAdminState extends State<SosAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 25,),

          Flexible(
            child: new StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Sos').orderBy('Hora',descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: new Text('A carregar Reviews...'));
                return new ListView(

                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new SafeArea(
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.green,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${document['Foto']}"),
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

                                        Text(document['Nome'], style:
                                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                        ),


                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Text('Data: '+document['Data'] , style: TextStyle(fontSize: 15, color: Colors.black),),
                                    SizedBox(height: 5,),
                                    Text('Hora: '+document['Hora'], style: TextStyle(fontSize: 15, color: Colors.black),),


                                  ],
                                ),
                              ),
                              MaterialButton(
                                  onPressed: () {

                                    String idSos= '${document.id}';
                                    FirestoreSosDelete(idSos);


                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                          'Apagar'
                                      ),


                                    ],
                                  )
                              ),
                              SizedBox(height: 5),

                            ],
                          ),
                        ),

                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),



        ],
      ),
    );
  }
}
