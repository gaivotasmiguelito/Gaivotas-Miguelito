import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/home/homeClient.dart';
import 'package:flutter_app/screens/profile/settings.dart';


const kLargeTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);
const kTitleTextStyle = TextStyle(
  fontSize: 16,
  color: Color.fromRGBO(129, 165, 168, 1),
);
const kSmallTextStyle = TextStyle(
  fontSize: 16,
);
class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  String uname = FirebaseAuth.instance.currentUser.displayName;
  String uemail = FirebaseAuth.instance.currentUser.email;


  CollectionReference utilizadores = FirebaseFirestore.instance.collection('Utilizadores');

  Future<void> _homeNavigation() async {

      try {

        FirebaseFirestore.instance
            .collection("Utilizadores")
            .doc(FirebaseAuth.instance.currentUser.uid.toString())
            .get()
            .then((DocumentSnapshot snapshot) {
          if (snapshot['Funcao'] == "Admin") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePageClient()));
          }
        });
      } catch (e) {
        print(e.message);

      }
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            _homeNavigation();

          },
          icon: Icon(Icons.arrow_back_ios,

            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 35, 15, 15),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  uname,
                  style: kLargeTextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  uemail,
                  style: kTitleTextStyle,
                ),
                SizedBox(
                  height: 50,
                ),

                Padding(
                  padding:  EdgeInsets.only(top: 3),
                  child: Text("Meu album", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                ),
                SizedBox(
                  height: 40,
                ),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    GalleryImage(
                      imagePath: 'assets/images/logo1.png',
                    ),
                    GalleryImage(
                      imagePath: 'assets/images/logo1.png',
                    ),
                    GalleryImage(
                      imagePath: 'assets/images/logo1.png',
                    ),
                    GalleryImage(
                      imagePath: 'assets/images/logo1.png',
                    ),
                    GalleryImage(
                      imagePath: 'assets/images/logo1.png',
                    ),
                    GalleryImage(
                      imagePath: 'assets/images/logo1.png',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GalleryImage extends StatelessWidget {
  final String imagePath;

  GalleryImage({@required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PostFollower extends StatelessWidget {
  final int number;
  final String title;

  PostFollower({@required this.number, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          number.toString(),
          style: kLargeTextStyle,
        ),
        Text(
          title,
          style: kSmallTextStyle,
        ),
      ],
    );
  }
}
