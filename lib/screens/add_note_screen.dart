import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/firestore_service.dart';
import 'package:flutter_firebase/utils/custom_message.dart';

class AddNoteScreen extends StatefulWidget {
AddNoteScreen({Key? key,required this.user}) : super(key: key);
  final User user;
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
bool loading =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                controller: descriptionController,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: loading ?  CircularProgressIndicator(): FloatingActionButton(
        onPressed: () async{
          if(titleController.text=="" || descriptionController.text==""){
            Utils().customMessage(
                context, "All fields are required!", Colors.redAccent);
          }else{
            setState(() {
              loading = true;
            });
            await FirestoreService().insertNote(titleController.text, descriptionController.text, widget.user.uid);
            setState(() {
              loading = false;
            });
          }
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
