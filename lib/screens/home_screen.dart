import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/note_model.dart';
import 'package:flutter_firebase/screens/add_note_screen.dart';
import 'package:flutter_firebase/services/auth_service.dart';

import 'edit_note_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key, required this.user}) : super(key: key);
final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () async{
          await AuthService().signOut(context);
          Future.delayed(Duration(seconds: 2),(){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen()));
          });
        },)
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').where('userId', isEqualTo: user.uid).snapshots(),
        builder: (
            BuildContext context, AsyncSnapshot<dynamic> snapshot) {
if(snapshot.hasData){
  if(snapshot.data.docs.length>0){
    return ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index){
          NoteModel note = NoteModel.fromJson(snapshot.data.docs[index]);
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text("${note.title}"),
              subtitle: Text("${note.description}"),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditNoteScreen(note:note)));
              },

            ),
          );
        }
    );
  }else{
   return Center(
      child: Text("No data avialiable"),
    );
  }
}
return Center(child: CircularProgressIndicator());
        },),
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          Navigator.push(context, 
          MaterialPageRoute(builder: (context)=>AddNoteScreen(user: user,))
          );
        },
        child: Icon(Icons.add),
    ),
    );
  }
}
