import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void>FirestoreCreatePhoto (String urlFoto) async{
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = auth.currentUser.uid;
  String uemail = auth.currentUser.email;
  String uname = auth.currentUser.displayName;
  String udateCreation = DateFormat('dd-MM-yyyy  kk:mm').format(FirebaseAuth.instance.currentUser.metadata.creationTime);



  CollectionReference users = FirebaseFirestore.instance.collection('Fotos');
  users
      .doc()
      .set({'Email':uemail,'Nome':uname,'Id_utilizador':uid,'Criado':udateCreation,'Url':urlFoto, 'Valido':'Nao'})
      .then((value) => print("Utilizador criado no Firestore"))
      .catchError((error) => print("Falha a criar utilizador no Firestore: $error"));

  //users.add({'Email':email,'Nome':displayName,'Id':uid});
  return;

}

Future<void>FirestorePhotoDelete(String uid) async{


  CollectionReference photo = FirebaseFirestore.instance.collection('Fotos');
  return photo
      .doc(uid)
      .delete()
      .then((value) => print("Foto apagada!"))
      .catchError((error) => print("Failed to delete user: $error"));

}

Future<void>FirestorePhotoValidar(String uid) async{

  CollectionReference photo = FirebaseFirestore.instance.collection('Fotos');
  return photo
      .doc(uid)
      .update({'Valido':'Sim'})
      .then((value) => print("Review atualizada"))
      .catchError((error) => print("Falha a atualizar. Não existe review: $error"));

}

Future<void>FirestorePhotoNaoValidar(String uid) async{

  CollectionReference photo = FirebaseFirestore.instance.collection('Fotos');
  return photo
      .doc(uid)
      .update({'Valido':'Nao'})
      .then((value) => print("Foto não validada"))
      .catchError((error) => print("Falha a atualizar. Não existe review: $error"));

}