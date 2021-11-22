import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth_service.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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

    );
  }
}
