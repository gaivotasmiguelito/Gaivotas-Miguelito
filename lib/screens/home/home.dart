import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/map.dart';
import 'package:flutter_app/screens/home/review.dart';
import 'package:flutter_app/screens/home/uploadFoto.dart';
import 'package:flutter_app/screens/profile/editProfile.dart';
import 'package:flutter_app/services/firestoreUsers.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _userEmail = FirebaseAuth.instance.currentUser.email;
  String _userName = FirebaseAuth.instance.currentUser.displayName;

  String _dateCreation = DateFormat('MM-dd-yyyy').format(FirebaseAuth.instance.currentUser.metadata.creationTime);
  //String _dateLastSigned = DateFormat('MM-dd-yyyy – kk:mm').format(FirebaseAuth.instance.currentUser.metadata.lastSignInTime);


  Future<void> _logoutuser() async {

    //Firestore offline
    OfflineUser();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/welcome');

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [

            UserAccountsDrawerHeader(
              currentAccountPicture:CircleAvatar(
                backgroundImage:
                AssetImage('assets/images/logo1.png'),
              ),
              accountName: Text(
                  _userName,
                textAlign: TextAlign.center,
              ),
              accountEmail: Text(_userEmail),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              subtitle: Text('Página principal'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
                print('home');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text('Minha conta'),
              subtitle: Text('Perfil e definições de conta'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SettingsUI()));
                print('Conta');
              },
            ),
            ListTile(
              leading: Icon(Icons.rate_review_outlined),
              title: Text('Reviews'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Review()));
                print('Review');
              },
            ),
            ListTile(
              leading: Icon(Icons.rate_review_outlined),
              title: Text('Fotos'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UploadFoto()));
                print('SOS');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              subtitle: Text('Finalizar sessão'),
              onTap: () async {
                print('Sair');
                _logoutuser();
              },
            ),
            SizedBox(
              height: 60,
            ),
            ListTile(
              subtitle: Text('Criado a '+_dateCreation),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Gaivotas Miguelito'),
      ),
      body: MapPage(),
    );
  }
}