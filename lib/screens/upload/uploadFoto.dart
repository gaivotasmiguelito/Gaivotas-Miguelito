import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadFoto extends StatefulWidget {
  @override
  UploadFotoState createState() => UploadFotoState();
}

class UploadFotoState extends State<UploadFoto> {
  String imageUrl;
  var file;
  final _firebaseStorage = FirebaseStorage.instance;

  uploadImage() async {
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      file = File(image.path);
    }
  }
  Widget _ImageView ()  {
    if (file == null) return Text ("Não foi selecionada nenhuma imagem");
    return SafeArea(child: Image.file(file, height: 350, width: 350));
  }

  sendImage() async {
   var snapshot = await _firebaseStorage.ref()
       .child(DateTime.now().toString())
       .putFile(file);
   var downloadUrl = await snapshot.ref.getDownloadURL();
   setState(() {
     imageUrl = downloadUrl;
   });
   if (imageUrl!=null) return print("Imagem enviada com sucesso");
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
                    Text("Fotografia Carregada",
                      style: TextStyle(color: Colors.teal, fontSize: 20),),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ImageView(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    uploadImage();
                  },
                  child: Text("Carregar Imagem", style: TextStyle(fontSize: 21),),
                ),
              )
            ],

          ),
          SizedBox(height: 40.0),
          InkWell(
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      sendImage();
                      },
                    child: Text("Enviar Fotografia", style: TextStyle(color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    ),
                  ),
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
