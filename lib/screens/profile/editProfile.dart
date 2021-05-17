import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({Key key}) : super(key: key);

  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {


  String _email ='';
  String _name='';


  String uid = FirebaseAuth.instance.currentUser.uid;
  String uname = FirebaseAuth.instance.currentUser.displayName;
  String uemail = FirebaseAuth.instance.currentUser.email;

  User user = FirebaseAuth.instance.currentUser;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionReference utilizadores = FirebaseFirestore.instance.collection('Utilizadores');


  Future<void> _updateuser() async {


    final formState = _formKey.currentState;

    if(formState.validate()){

      formState.save();


      await FirebaseAuth.instance.currentUser.updateProfile(displayName: _name);

      //var user = firebase.auth().currentUser;
      user.updateEmail(_email);

      //await FirebaseAuth.instance.currentUser.reload();

        return utilizadores
            .doc(uid)
            .update({'Nome': _name, 'Email':_email})
            .then((value) => print("Utilizador atualizado"))
            .catchError((error) => print("Falhha a atualizar: $error"));

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Scaffold(

        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 200,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                Column(
                  children: <Widget>[
                    Text(
                      'Dados Pessoais',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context).backgroundColor
                                ),

                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/images/logo1.png",
                                    ))),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                  color: Colors.blue,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),

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
                            'Nome',

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
                            initialValue: uname,


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
                          SizedBox(
                            height: 20,
                          ),

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
                            initialValue: uemail,


                            validator: (input){
                              if(input.isEmpty){
                                return 'Nome inválido!';
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


                        ],
                      ),
                    ),


                  ],
                ),
                Container(
                  decoration:
                  BoxDecoration(
                      borderRadius: BorderRadius.circular(50),

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
