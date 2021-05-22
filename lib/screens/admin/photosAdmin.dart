import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firestorePhoto.dart';

class PhotosAdmin extends StatefulWidget {
  const PhotosAdmin({Key key}) : super(key: key);

  @override
  _PhotosAdminState createState() => _PhotosAdminState();
}

class _PhotosAdminState extends State<PhotosAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          Text('Fotos não validadas:'),

          Flexible(
            child: new StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Fotos').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: new Text('A carregar fotos...'));
                return new ListView(

                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new SafeArea(
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                          width: MediaQuery.of(context).size.width,
                          // color: Colors.green,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${document['Url']}"),

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



                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    MaterialButton(
                                        onPressed: () {

                                          String idPhoto = '${document.id}';
                                          FirestorePhotoDelete(idPhoto);


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

Widget Valido(){
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 25,),

        Flexible(
          child: new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Fotos').where('Valido',isEqualTo: 'Sim').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Center(child: new Text('A carregar fotos...'));
              return new ListView(

                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new SafeArea(
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        width: MediaQuery.of(context).size.width,
                        // color: Colors.green,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage("${document['Url']}"),

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



                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  MaterialButton(
                                      onPressed: () {

                                        String idPhoto = '${document.id}';
                                        FirestorePhotoDelete(idPhoto);


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
                                  MaterialButton(
                                      onPressed: () {

                                        String idPhoto = '${document.id}';
                                        FirestorePhotoNaoValidar(idPhoto);


                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                              'Não validar'
                                          ),


                                        ],
                                      )
                                  ),

                                ],
                              ),
                            ),
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

Widget NaoValido(){
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 25,),

        Flexible(
          child: new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Fotos').where('Valido',isEqualTo: 'Nao').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Center(child: new Text('A carregar fotos...'));
              return new ListView(

                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new SafeArea(
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        width: MediaQuery.of(context).size.width,
                        // color: Colors.green,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage("${document['Url']}"),

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



                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  MaterialButton(
                                      onPressed: () {

                                        String idPhoto = '${document.id}';
                                        FirestorePhotoDelete(idPhoto);


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
                                  MaterialButton(
                                      onPressed: () {

                                        String idPhoto = '${document.id}';
                                        FirestorePhotoValidar(idPhoto);


                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                              'Validar'
                                          ),


                                        ],
                                      )
                                  ),
                                  SizedBox(height: 5),


                                ],
                              ),
                            ),
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
