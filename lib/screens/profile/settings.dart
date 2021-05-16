import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/profile/password.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
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
            buildAccountOptionRow(context, "Alterar Conteúdo"),
            buildAccountOptionRow(context, "Alterar Password"),
            buildAccountOptionRow(context, "Privacidade e Segurança"),

            MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () {

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UPassword()));

                //Navigator.of(context).pushReplacementNamed('/home');
              },
              color: Color(0xff0095FF),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),

              ),
              child: Text(
                "Alterar Conteudo", style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,

              ),
              ),

            ),

            MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () {

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UPassword()));

                //Navigator.of(context).pushReplacementNamed('/home');
              },
              color: Color(0xff0095FF),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),

              ),
              child: Text(
                "Alterar Password", style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,

              ),
              ),

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

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {

              },
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Opção 1"),
                    Text("Opção 2"),
                    Text("Opção 3"),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Fechar")
                  ),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
