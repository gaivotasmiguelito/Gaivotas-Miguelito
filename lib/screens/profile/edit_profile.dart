import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/profile/settings.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({Key key}) : super(key: key);

  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {

  String _email ='';
  String _password='';
  String _name='';


  String uid = FirebaseAuth.instance.currentUser.uid;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionReference utilizadores = FirebaseFirestore.instance.collection('Utilizadores');

  Future<void> _updateuser() async {
    final formState = _formKey.currentState;

    if(formState.validate()){

      formState.save();

      utilizadores.doc(uid).get();

      await FirebaseAuth.instance.currentUser.updateProfile(displayName: _name);

        return utilizadores
            .doc(uid)
            .update({'Nome': _name})
            .then((value) => print("Utilizador atualizado"))
            .catchError((error) => print("Failed to update user: $error"));

    }

  }
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),


        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            FutureBuilder<DocumentSnapshot>(
            future: utilizadores.doc(uid).get(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                Map<String, dynamic> data = snapshot.data.data();
                return Text("Nome: ${data['Nome']}");

            },
          ),
                Column(
                  children: <Widget>[
                    Text("Editar conta",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,

                      ),),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[

                          Text(
                            'Nome ( Primeiro e ultimo)',

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
                                return 'Nome inválido!';
                              }
                            } ,
                            onSaved: (input) => _name =input,
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


                  ],
                ),
                Container(
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
                      _updateuser();

                    },
                    color: Color(0xff0095FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),

                    ),
                    child: Text(
                      "Editar conta", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,

                    ),
                    ),

                  ),



                ),

              ],

            ),


          ),

        ),

      ),
    );
  }
}
