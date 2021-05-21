import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/homeClient.dart';


import 'add_review.dart';

class ReviewsClient extends StatefulWidget {
  const ReviewsClient({Key key}) : super(key: key);

  @override
  _ReviewsClientState createState() => _ReviewsClientState();
}

class _ReviewsClientState extends State<ReviewsClient> {

  CollectionReference utilizadores = FirebaseFirestore.instance.collection('Utilizadores');
  CollectionReference reviews = FirebaseFirestore.instance.collection('Reviews');
  String uid = FirebaseAuth.instance.currentUser.uid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            //_homeNavigation();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => HomePageClient()));
          },
          icon: Icon(Icons.arrow_back_ios,

            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Reviews", style: TextStyle(color: Colors.white, fontSize: 24),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.help, size: 30),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding	(
            padding: const EdgeInsets.only(left: 2.0, bottom: 2.0),
            child:  IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddReview()));
              },
              icon: Icon(Icons.add,
                size: 38,
                color: Colors.blueAccent,),
            ),
          ),
          Center(child: Text(
            'Gaivotas Miguelito',
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 40.0,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),


          Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  FutureBuilder<DocumentSnapshot>(
                    future: utilizadores.doc(uid).get(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                      if (snapshot.hasError) {
                      return Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data.exists) {
                      return Text("Sem nenhuma review de momento!");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();
                      return Container(
                        child: Column(
                          children: [
                            Icon(Icons.person, size: 40, color: Colors.blue),
                            SizedBox(width: 5),
                            Text("${data.length}", style: TextStyle(fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      );
                      }

                      return Text("Aguarde");
                    },
                  ),
                ],
              ),
            ),
          ),

          FutureBuilder<DocumentSnapshot>(
            future: reviews.doc(uid).get(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data.exists) {
                return Text("Sem nenhuma review");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();
                return SafeArea(
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 10,
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


                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(data['Data']+' '+data['Hora'], style: TextStyle(fontSize: 16, color: Colors.black),),
                                SizedBox(height: 5),
                                Text(data['Conteudo'], style: TextStyle(fontSize: 16, color: Colors.black),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),
                );
              }

              return Text("loading");
            },
          ),
          SizedBox(height: 20,),

          Divider(height: 10,thickness: 1, color: Colors.black,),

          Flexible(
            child: new StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Reviews').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: new Text('A carregar Reviews...'));
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
                                  width: 50,
                                  height: 50,
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
                                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                        ),


                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(document['Data']+' '+document['Hora'], style: TextStyle(fontSize: 16, color: Colors.black),),
                                    SizedBox(height: 5),
                                    Text(document['Conteudo'], style: TextStyle(fontSize: 16, color: Colors.black),),
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
