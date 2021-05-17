import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/reviews/add_review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews extends StatefulWidget {
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {

  //final _firestore = FirebaseFirestore.instance;
  //final _auth = FirebaseAuth.instance;
  //String reviewText;
  //String _userName = FirebaseAuth.instance.currentUser.displayName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
      body: Container(
        child: new StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('Reviews').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(child: new Text('Loading...'));
    return new ListView(
    children: snapshot.data.docs.map((DocumentSnapshot document) {
    return new Card(
    child:  Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
        // color: Colors.green,
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 10.0),
        child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
        border: Border.all(color: Colors.lightBlue, width: 2.0),
        color: Colors.lightBlue,
        ),
        child: Image.asset("assets/images/av.png", alignment: Alignment.bottomCenter),
        ),
        ),
        Container(
        height: 150,
        width: MediaQuery.of(context).size.width / 1.25,
        // color: Colors.blue,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Text(document['Nome'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
        Spacer(),
        Icon(Icons.more_vert_outlined, size: 30, color: Colors.black,),
        ],
        ),
        new Text(document['Conteudo'], style: TextStyle(fontSize: 16, color: Colors.black),),
        ],
        ),
        ),

        ],
        ),
        ),
        );
    }).toList(),
    );
    },

    ),
      ),

    );


    //REVIEWS - TEMPLATE



  }
  Widget _ReviewCont(_titulo, _subtitulo){
    return  Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      // color: Colors.green,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue, width: 2.0),
                color: Colors.lightBlue,
              ),
              child: Image.asset("assets/images/av.png", alignment: Alignment.bottomCenter),
            ),
          ),
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width / 1.35,
            // color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(_titulo, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
                    Spacer(),
                    Icon(Icons.more_vert_outlined, size: 36, color: Colors.black,),
                  ],
                ),
                Text(_subtitulo, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


