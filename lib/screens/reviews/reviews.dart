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
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            //_homeNavigation();
            Navigator.of(context).pop();
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
          SizedBox(height: 30,),

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


