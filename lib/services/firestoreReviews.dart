import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/home/homeClient.dart';
import 'package:intl/intl.dart';


Future<void>FirestoreReviewNome(String Nome) async{
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = auth.currentUser.uid.toString();


  CollectionReference users = FirebaseFirestore.instance.collection('Reviews');
  return users
      .doc(uid)
      .update({'Nome':Nome})
      .then((value) => print("Review atualizada"))
      .catchError((error) => print("Falha a atualizar. Não existe review: $error"));

}

Future<void>FirestoreReviewFoto(String Foto) async{
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = auth.currentUser.uid.toString();


  CollectionReference users = FirebaseFirestore.instance.collection('Reviews');
  return users
      .doc(uid)
      .update({'Foto':Foto})
      .then((value) => print("Review atualizada"))
      .catchError((error) => print("Falha a atualizar. Não existe review: $error"));

}

Future<void>FirestoreReviewDelete(String uid) async{


  CollectionReference users = FirebaseFirestore.instance.collection('Reviews');
  return users
      .doc(uid)
      .delete()
      .then((value) => print("Review apagada!"))
      .catchError((error) => print("Failed to delete user: $error"));

}


