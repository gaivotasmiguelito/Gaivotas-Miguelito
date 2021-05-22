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
enum Opcoes {Editar, Apagar }

class _ReviewsClientState extends State<ReviewsClient> {
  var selecao;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddReview()));
                },
                icon: Icon(Icons.add,
                  size: 38,
                  color: Colors.blueAccent,),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:20.0, top: 10),
                child: Center(
                  child: Container(
                    child: Image(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                    ),
                    width: MediaQuery.of(context).size.width / 1.5 ,
                  ),
                ),
              ),
              SizedBox(),
              SizedBox(),
              SizedBox(),
              SizedBox(),
            ],
          ),
          Flexible(
            child: FutureBuilder<DocumentSnapshot>(
              future: reviews.doc(uid).get(),
              builder:
                  (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                if (snapshot.hasError) {
                  return Text("Algo correu mal!");
                }

                if (snapshot.hasData && !snapshot.data.exists) {
                  return Text("Sem nenhuma review");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  return SafeArea(
                    child:  Container(
                      height: MediaQuery.of(context).size.height/ 6,
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data['Nome'], style:
                                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                        ),
                                        Text(data['Data']+' '+data['Hora'], style: TextStyle(fontSize: 16, color: Colors.black54),
                                        ),
                                        SizedBox(height: 5),
                                        Text(data['Conteudo'], style: TextStyle(fontSize: 18, color: Colors.black),),
                                      ],
                                    ),
                                    PopupMenuButton(
                                      onSelected: (Opcoes result) { setState(() { selecao = result; }); },
                                      itemBuilder: (BuildContext context) => <PopupMenuEntry<Opcoes>>[
                                        const PopupMenuItem(
                                          value: Opcoes.Editar,
                                          child: Center(child: Text('Editar')),
                                        ),
                                        const PopupMenuItem(
                                          value: Opcoes.Apagar,
                                          child: MaterialButton(
                                              child: Center(child: Text('Apagar'))),
                                        ),
                                  ],
                                ),
                            ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Text("loading");
              },
            ),

          ),
          Divider(height: 10,thickness: 1, color: Colors.black,),


          //TODAS AS REVIEWS
          Flexible(
            child:  StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Reviews').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: Text('A carregar Reviews...'));
                return ListView(

                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return SafeArea(
                      child:  Padding(
                        padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 8.0),
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
                                child: Expanded(
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
                                      Text(document['Data']+' '+document['Hora'], style: TextStyle(fontSize: 16, color: Colors.black54),),
                                      SizedBox(height: 5),
                                      Text(document['Conteudo'], style: TextStyle(fontSize: 18, color: Colors.black),),
                                      SizedBox(height: 25),
                                    ],
                                  ),
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
