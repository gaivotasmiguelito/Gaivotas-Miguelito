import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
            Navigator.pop(context);
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8,
              //color: Colors.black45,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, size: 40, color: Colors.green),
                  SizedBox(width: 8.0),
                  Icon(Icons.star, size: 40, color: Colors.green),
                  SizedBox(width: 8.0),
                  Icon(Icons.star, size: 40, color: Colors.green),
                  SizedBox(width: 8.0),
                  Icon(Icons.star, size: 40, color: Colors.green),
                  SizedBox(width: 8.0),
                  Icon(Icons.star, size: 40, color: Colors.green),
                ],
              ),
            ),
            Form(
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
            MaterialButton(
                    onPressed: () {
                  print(_review);
                  //await createReview();
                  _createReview();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Reviews()));
                },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                  child: Text("Submeter review", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
