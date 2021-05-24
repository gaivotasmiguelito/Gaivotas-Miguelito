import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/reviews/reviewsClient.dart';
import 'package:intl/intl.dart';


class AddReview extends StatefulWidget {
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  String _userName = FirebaseAuth.instance.currentUser.displayName; 
  String _review;
  CollectionReference ref = FirebaseFirestore.instance.collection('Reviews');

  CollectionReference utilizadores = FirebaseFirestore.instance.collection('Utilizadores');
  CollectionReference reviews = FirebaseFirestore.instance.collection('Reviews');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Future<void> CreateReview() async {
    final formState = _formKey.currentState;

    if(formState.validate()){

      formState.save();

      try {


        FirebaseAuth auth = FirebaseAuth.instance;
        String uid =auth.currentUser.uid;
        var today = new DateTime.now();
        var dateTimeNow = today.add(new Duration(hours: 1));

        String _dateCreation = DateFormat('dd-MM-yyyy').format(dateTimeNow);
        String _timeCreation = DateFormat('HH:mm').format(dateTimeNow);



        utilizadores.doc(uid).get().then((data) {

          String ufoto;
          ufoto= data['Foto'] ;

          reviews
              .doc(uid)
              .set({'Nome':_userName,'Conteudo':_review,'Foto':ufoto,'Data':_dateCreation,'Hora':_timeCreation})
              .then((value) => print("Review criada no Firestore"))
              .catchError((error) => print("Falha a criar uma review no Firestore: $error"));


        });



      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('Nenhum utilizador encontrado para esse e-mail.');
        } else if (e.code == 'wrong-password') {
          print('Password incorreta para este utilizador');

        }
      }

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xff403d8c),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ReviewsClient()));
          },
          icon: Icon(Icons.arrow_back_outlined
            ,
            size: 30,
            color: Colors.white,),


        ),
        centerTitle: true,
        title: Text("Reviews", style: TextStyle(color: Colors.white, fontSize: 24),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.help, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              color: Colors.lightBlue,
              child: Center(
                child: Text("O tempo acabou! Dá-nos a tua \nOpinião",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 5.0),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(150),
                      ],
                      keyboardType: TextInputType.text,
                      validator: (input){
                        if(input.isEmpty){
                          return 'Insira a sua mensagem!';
                        }
                      } ,
                      onSaved: (input) => _review =input,
                      maxLines: 20,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Descreva a sua viagem [max. 150 caracteres]",
                        hintStyle: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
                    onPressed: () async {
                  await CreateReview();
                  if (_review.isNotEmpty) return Navigator.push(context, MaterialPageRoute(builder: (context)=> ReviewsClient()));
                },
              child: Container( // BOTÃO TEMPLATE
                height: 90,
                width: 200,
                child: Center(
                  child: Container(
                    decoration:
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                          await CreateReview();
                          if (_review.isNotEmpty) return Navigator.push(context, MaterialPageRoute(builder: (context)=> ReviewsClient()));
                      },
                      color: Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Submeter Review", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                        ),
                      ),
                    ),

                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
