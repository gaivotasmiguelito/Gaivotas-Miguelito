import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/screens/home/homeClient.dart';



Future<void>FirestoreUser (String displayName) async{
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = auth.currentUser.uid.toString();
  String email = auth.currentUser.email.toString();


  CollectionReference users = FirebaseFirestore.instance.collection('Utilizadores');
  users
      .doc(uid)
      .set({'Email':email,'Nome':displayName,'Id':uid})
      .then((value) => print("Utilizador criado no Firestore"))
      .catchError((error) => print("Falha a criar utilizador no Firestore: $error"));

  //users.add({'Email':email,'Nome':displayName,'Id':uid});
  return;


}