import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firestoreUsers.dart';

class Review extends StatefulWidget {
  const Review({Key key}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {

  String _userName = FirebaseAuth.instance.currentUser.displayName;
  String _review;

  CollectionReference ref = FirebaseFirestore.instance.collection('Reviews');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _createReview() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      Map <String,dynamic> data = {"Conteudo":_review.toString(), "Nome":_userName};

      FirebaseFirestore.instance.collection("Reviews").add(data);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),


        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Reviews",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20,),
                    Text("Deixe-nos a sua opinião!",
                      style: TextStyle(
                          fontSize: 15,
                          color:Colors.grey[700]),)
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[

                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: <Widget>[

                            Text(
                              'Review',

                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color:Colors.black87,
                              ),

                            ),
                            SizedBox(
                              height: 10,
                            ),

                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (input){
                                if(input.isEmpty){
                                  return 'Insira a sua mensagem!';
                                }
                              } ,
                              onSaved: (input) => _review =input,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 0,
                                      horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[400]
                                    ),

                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey[400])
                                  )
                              ),

                            ),

                          ],
                        ),
                      ),

                      SizedBox(height: 10,),

                    ],
                  ),
                ),
                Padding(padding:
                EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration:
                    BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                    ),


                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {

                        print(_review);

                        //await createReview();
                        _createReview();

                      },
                      color: Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),

                      ),
                      child: Text(
                        "Criar Review", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,

                      ),
                      ),

                    ),
                  ),
                ),


                Padding(padding:
                EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration:
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),


                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {



                      },
                      color: Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),

                      ),
                      child: Text(
                        "Testar", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,

                      ),
                      ),

                    ),
                  ),
                ),

              ],
            ))
          ],
        ),
      ),
    );
  }
}
