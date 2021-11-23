import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future insertNote(String title, String description, String userId) async{
    try{
      await firestore.collection('notes').add({
        "title":title,
        "description": description,
        "date": DateTime.now(),
        "userId": userId
      });
    }catch(e){
print(e);
    }
  }

  Future updateNote(String title, String description, String docId) async{
    try{
      await firestore.collection('notes').doc(docId).update({
        "title":title,
        "description": description,
        "date": DateTime.now(),
      });
    }catch(e){
      print(e);
    }
  }

  Future deleteNote(String docId) async{
    try{
      await firestore.collection('notes').doc(docId).delete();
    }catch(e){
      print(e);
    }
  }

}