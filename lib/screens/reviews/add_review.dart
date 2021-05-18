import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/home/review.dart';
import 'package:flutter_app/screens/reviews/reviews.dart';

class AddReview extends StatefulWidget {
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  String _userName = FirebaseAuth.instance.currentUser.displayName; 
  String _review;
  CollectionReference ref = FirebaseFirestore.instance.collection('Reviews');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _createReview() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      Map <String, dynamic> data = {
        "Conteudo": _review.toString(),
        "Nome": _userName
      };

      FirebaseFirestore.instance.collection("Reviews").add(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xff403d8c),
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
                      keyboardType: TextInputType.text,
                      validator: (input){
                        if(input.isEmpty){

                          return 'Insira a sua mensagem!';
                        }
                      } ,
                      onSaved: (input) => _review =input,
                     // minLines: 4,
                      maxLines: 20,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Descreva a sua viagem",
                        hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
                    onPressed: () async {
                  await _createReview();
                  if (_review.isNotEmpty) return Navigator.push(context, MaterialPageRoute(builder: (context)=> Reviews()));
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
                          await _createReview();
                          if (_review.isNotEmpty) return Navigator.push(context, MaterialPageRoute(builder: (context)=> Reviews()));
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
