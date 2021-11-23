import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/note_model.dart';
import 'package:flutter_firebase/services/firestore_service.dart';
import 'package:flutter_firebase/utils/custom_message.dart';

class EditNoteScreen extends StatefulWidget {
  EditNoteScreen({Key? key,required this.note}) : super(key: key);
  final NoteModel note;
  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool loading =false;

  @override
  void initState() {
    titleController.text= widget.note.title;
    descriptionController.text=widget.note.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed:() async{
            await showDialog(context: context,
                builder: (context){
              return AlertDialog(
                title: Text('Please Confirm'),
                content: Text('Are you sure to delete the note?'),
                actions: [
                  TextButton(onPressed: () async{
                    await FirestoreService().deleteNote(widget.note.id);
                    Navigator.pop(context);
                    Navigator.pop(context);

                  }, child: Text('Yes')),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('No')),
                ],
              );
            });
          }, icon: Icon(Icons.delete, color: Colors.red,))
        ],
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
                height: 15,
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
      floatingActionButton:loading ? CircularProgressIndicator() : FloatingActionButton(
        onPressed: () async{

          if(titleController.text=="" || descriptionController.text==""){
            Utils().customMessage(
                context, "All fields are required!", Colors.redAccent);
          }else{
            setState(() {
              loading = true;
            });
            await FirestoreService().updateNote(titleController.text, descriptionController.text, widget.note.id);
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
