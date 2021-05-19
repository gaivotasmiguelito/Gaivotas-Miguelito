import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/home/homeClient.dart';
import 'package:intl/intl.dart';

Future<void>FirestoreUser (String displayName) async{
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = auth.currentUser.uid.toString();
  String uemail = auth.currentUser.email.toString();
  String udateCreation = DateFormat('MM-dd-yyyy  kk:mm').format(FirebaseAuth.instance.currentUser.metadata.creationTime);
  String ufotoDefault = 'https://firebasestorage.googleapis.com/v0/b/gaivotasmiguelito-firebase.appspot.com/o/logo1.png?alt=media&token=72797896-a793-496c-bdb8-fd99224f99ef';


  CollectionReference users = FirebaseFirestore.instance.collection('Utilizadores');
  users
      .doc(uid)
      .set({'Email':uemail,'Nome':displayName,'Id':uid,'Criado':udateCreation,'Funcao':'Cliente', 'Foto':ufotoDefault})
      .then((value) => print("Utilizador criado no Firestore"))
      .catchError((error) => print("Falha a criar utilizador no Firestore: $error"));

  //users.add({'Email':email,'Nome':displayName,'Id':uid});
  return;

}

Future<void>OnlineUser() async{
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = auth.currentUser.uid.toString();


  CollectionReference users = FirebaseFirestore.instance.collection('Utilizadores');
  return users
      .doc(uid)
      .update({'Estado':'Online'})
      .then((value) => print("Utilizador online"))
      .catchError((error) => print("Failed to update user: $error"));

}

Future<void>OfflineUser() async{
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = auth.currentUser.uid.toString();
  
  CollectionReference users = FirebaseFirestore.instance.collection('Utilizadores');
  return users
      .doc(uid)
      .update({'Estado':'Offline'})
      .then((value) => print("Utilizador offline"))
      .catchError((error) => print("Failed to update user: $error"));

}



