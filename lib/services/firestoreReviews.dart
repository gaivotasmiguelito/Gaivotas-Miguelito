import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


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


  CollectionReference reviews = FirebaseFirestore.instance.collection('Reviews');
  return reviews
      .doc(uid)
      .delete()
      .then((value) => print("Review apagada!"))
      .catchError((error) => print("Falha a apagar a review: $error"));

}


