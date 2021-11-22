import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import 'package:flutter_firebase/screens/register_screen.dart';
import 'package:flutter_firebase/services/auth_service.dart';

class AuthStateCheck extends StatelessWidget {
  const AuthStateCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().firebaseAuth.authStateChanges(),
        builder: (context,snapshot){
        if(snapshot.hasData){
          return HomeScreen();
        }
        return RegisterScreen();
        }
    );
  }
}
