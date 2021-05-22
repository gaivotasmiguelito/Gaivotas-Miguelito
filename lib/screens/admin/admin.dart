import 'package:flutter/material.dart';
import 'package:flutter_app/screens/admin/photosAdmin.dart';
import 'package:flutter_app/screens/admin/reviewsAdmin.dart';
import 'package:flutter_app/screens/admin/sosAdmin.dart';
import 'package:flutter_app/screens/admin/usersAdmin.dart';
import 'package:flutter_app/screens/photo/photoPage.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();


              },
              icon: Icon(Icons.arrow_back_ios,

                color: Colors.black,
              ),
            ),
            bottom: TabBar(
              //controller: _tabControler,
              isScrollable: true,
              tabs: [
                Tab(icon: Icon(Icons.warning_amber_outlined), text: 'Pedidos de SOS'),
                Tab(icon: Icon(Icons.supervised_user_circle_rounded), text: 'Utilizadores',),
                Tab(icon: Icon(Icons.rate_review_outlined), text: 'Reviews'),
                Tab(icon: Icon(Icons.photo_camera_outlined), text: 'Fotos'),



              ],
            ),
            title: Text('Administração'),
          ),
          body: TabBarView(
            children: [
              Container(
                child: SosAdmin(),

              ),
              Container(
                child: UsersAdmin(),

              ),
              Container(
                child: ReviewsAdmin(),

              ),
              Container(
                child: PhotosAdmin(),


              ),

            ],
          ),
        ),
      ),
    );
  }

}

