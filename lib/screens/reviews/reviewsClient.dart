import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/homeClient.dart';
import 'package:flutter_app/services/firestoreReviews.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

              SizedBox(),
              SizedBox(),

              Container(
               child: Center(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.cyan,
                  padding: EdgeInsets.only(left: 30,right: 30),
                  child: Text('Review',style: TextStyle
                  (color: Colors.white,fontSize: 15),
                  ),
                  onPressed: _showRatingAppDialog,
                  ),
                ),
              ),

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
                    child:  Padding(
                      padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/4,
                        // color: Colors.green,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 15.0),
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
                              child: Expanded(
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
                                    Text(data['Data']+' '+data['Hora'], style: TextStyle(fontSize: 16, color: Colors.black54),),
                                    SizedBox(height: 15),
                                    RatingBarIndicator(

                                      direction: Axis.horizontal,
                                      rating: data['Avaliacao'],

                                      itemCount: 5,
                                      itemSize: 20,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),

                                    ),
                                    SizedBox(height: 5),
                                    Text(data['Conteudo'], style: TextStyle(fontSize: 18, color: Colors.black),),
                                    SizedBox(height: 25),


                                  ],
                                ),
                              ),
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

                                      SizedBox(height: 15),
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
                                      SizedBox(height: 15),
                                      RatingBarIndicator(

                                        direction: Axis.horizontal,
                                        rating: document['Avaliacao'],

                                        itemCount: 5,
                                        itemSize: 20,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),

                                      ),
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

  void _showRatingAppDialog() {

    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: '',
      message: 'Deixe a sua opinião...',
      image: Image.asset("assets/images/logo.png",height: 150,),
      submitButton: 'Enviar',
      commentHint: 'Deixe o seu comentario...',
      onCancelled: () => print('Cancelado'),
      onSubmitted: (response) {


          CreateReview(response.comment,response.rating.toDouble());


      },
    );

    showDialog(

      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}
