import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/profile/password.dart';
import 'package:flutter_app/screens/profile/profile.dart';

import 'editProfile.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  CollectionReference utilizadores = FirebaseFirestore.instance.collection('Utilizadores');

  String ufoto;


  Future<void> _getFotoUser() async {

        FirebaseAuth auth = FirebaseAuth.instance;

        String _uid = auth.currentUser.uid;
        FirebaseFirestore.instance.collection('Utilizadores').doc(_uid).get().then((data) {

          ufoto=data['Foto'];



        });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Profile()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(

        padding: EdgeInsets.symmetric(vertical:20,horizontal: 25),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Definições",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Conta",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                  'Alterar dados pessoais',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),

              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SettingsUI()));
                print('Alterar dados pessoais');
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              title: Text(
                'Alterar Password',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),

              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UPassword()));
                print('Alterar Password');
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              title: Text(
                'Privacidade e Segurança',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),

              ),
              onTap: (){
                /*Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));*/
                print('Privacidade e Segurança');
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),

            SizedBox(
              height: 50,
            ),
            Center(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {},
                child: Text("Finalizar Sessão",
                    style: TextStyle(
                        fontSize: 16, color: Colors.black
                    ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
