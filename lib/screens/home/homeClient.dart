import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/map/map.dart';
import 'package:flutter_app/screens/profile/editProfile.dart';
import 'package:flutter_app/screens/profile/profile.dart';
import 'package:flutter_app/screens/reviews/add_review.dart';
import 'package:flutter_app/screens/upload/uploadFoto.dart';
import 'package:flutter_app/services/firestoreUsers.dart';
import 'package:intl/intl.dart';


class HomePageClient extends StatefulWidget {
  const HomePageClient({Key key}) : super(key: key);

  @override
  _HomePageClientState createState() => _HomePageClientState();
}

class _HomePageClientState extends State<HomePageClient> {

  String _userEmail = FirebaseAuth.instance.currentUser.email;
  String _userName = FirebaseAuth.instance.currentUser.displayName;
  String _uid = FirebaseAuth.instance.currentUser.uid;

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
                'Bem-vindo '+_userName,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),

              ),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              subtitle: Text('Página principal'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePageClient()));
                print('home');
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text('Minha conta',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              subtitle: Text('Perfil e definições de conta'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Profile()));
                print('Conta');
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              leading: Icon(Icons.rate_review_outlined),
              title: Text('Reviews',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddReview()));
                print('Review');
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              leading: Icon(Icons.photo_camera_outlined),
              title: Text('Fotos',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UploadFoto()));
                print('SOS');
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),),
              subtitle: Text('Finalizar sessão'),
              onTap: () async {
                print('Sair');
                _logoutuser();
              },
              trailing: Icon(Icons.arrow_forward_ios_outlined),
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
