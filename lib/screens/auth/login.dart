import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firestoreUsers.dart';
import 'package:flutter_app/services/firestore_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email ='';
  String _password='';


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CollectionReference utilizadores = FirebaseFirestore.instance.collection('Utilizadores');

  Future<void> _loginuser() async {
    final formState = _formKey.currentState;


    if(formState.validate()){

      formState.save();

      try {

        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        print("User: $userCredential");


        //Firestore online
        OnlineUser();


        Navigator.of(context).pushReplacementNamed('/home');


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
    return  Scaffold(
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
                    Text("Iniciar sessão",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20,),
                    Text("Inicie a sessão com a sua conta",
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
                              'Email',

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
                                  return 'Email inválido!';
                                }
                              } ,
                              onSaved: (input) => _email =input,
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
                            SizedBox(height: 20,),

                            Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color:Colors.black87
                              ),

                            ),

                            SizedBox(height: 10,),

                            TextFormField(
                              obscureText: true,
                              validator: (input){
                                if(input.length<6){
                                  return 'A password deve ter no minimo 6 caracteres.';
                                }
                              } ,
                              onSaved: (input) {
                                _password =input;

                                },
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
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),

                        )



                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {

                        _loginuser();

                        //Navigator.of(context).pushReplacementNamed('/home');
                      },
                      color: Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),

                      ),
                      child: Text(
                        "Iniciar sessão", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,

                      ),
                      ),

                    ),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Não tem uma conta?"),
                    Text(" Crie uma!", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,

                    ),)
                  ],
                ),

                Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.fitHeight
                    ),

                  ),
                )

              ],
            ))
          ],
        ),
      ),
    );
  }
}
