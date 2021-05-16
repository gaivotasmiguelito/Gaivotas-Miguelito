import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UploadFoto extends StatefulWidget {
  @override
  UploadFotoState createState() => UploadFotoState();
}
final _picker = ImagePicker();

class UploadFotoState extends State<UploadFoto> {
  File imageFile;

  _abrirGaleria() async {
    var imagem = await _picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = imagem as File;
    });
  }

  _abrirCamera() async {
    var imagem = await _picker.getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = imagem as File;
    });
  }

  Future<void> _opcoes(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
          title: Text("Escolha a opção pretendida: "),
          content: SingleChildScrollView(
              child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Galeria"),
                      onTap: () {
                        _abrirGaleria();
                      },
                    ),
                    Padding(padding: EdgeInsets.all(9.00)),
                    GestureDetector(
                      child: Text("Câmera"),
                      onTap: () {
                        _abrirCamera();
                      },
                    )
                  ]
              )
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Container(
            height: 10,
            width: 10,

            decoration: BoxDecoration(

            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),

        centerTitle: true,
        title: Text("Carregar Foto",
          style: TextStyle(color: Colors.white, fontSize: 24),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.help, size: 30),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              height: MediaQuery
                  .of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // color: Colors.green,
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.lightBlue),),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 30.0, bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Fotos Carregadas",
                      style: TextStyle(color: Colors.teal, fontSize: 20),),
                    Text("3/3",
                        style: TextStyle(color: Colors.teal, fontSize: 20)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Não foi selecionada nenhuma imagem"),
              ElevatedButton(
                onPressed: () {
                  _opcoes(context);
                },
                child: Text("Carregar Imagem", style: TextStyle(fontSize: 20),),
              )
            ],
          ),
          SizedBox(height: 40.0),
          InkWell(
            onTap: () {
              //  Navigator.push(
              //   context,
              //  MaterialPageRoute(builder: (context) => ()),
              //);
            },
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Enviar Fotos", style: TextStyle(color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),),
                  SizedBox(width: 20),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Icon(Icons.check, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}