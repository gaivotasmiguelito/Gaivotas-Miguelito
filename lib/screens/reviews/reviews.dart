import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/home/homeClient.dart';
import 'package:flutter_app/screens/reviews/add_review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/services/firestoreReviews.dart';

class Reviews extends StatefulWidget {
  @override
  _ReviewsState createState() => _ReviewsState();
}
enum Opcoes {Editar, Apagar }
class _ReviewsState extends State<Reviews> {

  CollectionReference utilizadores = FirebaseFirestore.instance.collection('Utilizadores');
  CollectionReference reviews = FirebaseFirestore.instance.collection('Reviews');
  String uid = FirebaseAuth.instance.currentUser.uid;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //final _firestore = FirebaseFirestore.instance;
  //final _auth = FirebaseAuth.instance;
  //String reviewText;
  //String _userName = FirebaseAuth.instance.currentUser.displayName;
  var selecao;

  Future<void> _homeNavigation() async {

    try {

      FirebaseFirestore.instance
          .collection("Utilizadores")
          .doc(FirebaseAuth.instance.currentUser.uid.toString())
          .get()
          .then((DocumentSnapshot snapshot) {
        if (snapshot['Funcao'] == "Admin") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePageClient()));
        }
      });
    } catch (e) {
      print(e.message);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _homeNavigation();
          },
          icon: Icon(Icons.arrow_back_outlined
            ,
            size: 30,
            color: Colors.white,),


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
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: 40, color: Colors.teal),
                  SizedBox(width: 5),
                  Text("3,342", style: TextStyle(fontSize: 30, color: Colors.teal, fontWeight: FontWeight.bold),),
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
                return Text("Nome: ${data['Nome']} \nConteudo: ${data['Conteudo']}");
              }

              return Text("loading");
            },
          ),



          Flexible(
            child: new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Reviews').where('Conteudo', isNotEqualTo: '').snapshots(),
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
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
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


                        SizedBox(height: 20),

                        ],
                      ),
                    new Text(document['Conteudo'], style: TextStyle(fontSize: 16, color: Colors.black),),
                  ],
                    ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          String _id = document.id;

                          FirestoreReviewDelete(_id);



                          //Navigator.of(context).pushReplacementNamed('/home');
                        },
                        child: Text('Apagar'),

                      )

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


