import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/reviews/add_review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews extends StatefulWidget {
  @override
  _ReviewsState createState() => _ReviewsState();
}
enum Opcoes {Editar, Apagar }
class _ReviewsState extends State<Reviews> {

  //final _firestore = FirebaseFirestore.instance;
  //final _auth = FirebaseAuth.instance;
  //String reviewText;
  //String _userName = FirebaseAuth.instance.currentUser.displayName;
  var selecao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
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
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                border: Border.all(color: Colors.lightBlue, width: 5.0),
                                color: Colors.lightBlue,
                                   ),
                              child: Image.asset("assets/images/av.png", alignment: Alignment.bottomCenter),
                            ),
                          ),
                  Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width / 1.45,
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
                          PopupMenuButton<Opcoes>(
                            onSelected: (Opcoes result) { setState(() { selecao = result; }); },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<Opcoes>>[
                          const PopupMenuItem<Opcoes>(
                            value: Opcoes.Editar,
                            child: Center(child: Text('Editar')),
                          ),
                      const PopupMenuItem<Opcoes>(
                        value: Opcoes.Apagar,
                        child: Center(child: Text('Apagar')),
                       ),
                            ],
                              child: Icon(Icons.more_vert_outlined, size: 25, color: Colors.black,)),
                        ],
                      ),
                    new Text(document['Conteudo'], style: TextStyle(fontSize: 16, color: Colors.black),),
                  ],
                    ),
                      ),
             /*         Container(
                        child: Divider(
                          height: 50,
                          thickness: 52,
                        ),
                      ),*/
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


