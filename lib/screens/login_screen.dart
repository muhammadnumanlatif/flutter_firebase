import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/register_screen.dart';
import 'package:flutter_firebase/services/auth_service.dart';
import 'package:flutter_firebase/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text("Login Yourself")),
            SizedBox(
              height: 35,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            loading? CircularProgressIndicator():   Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.75,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading=true;
                  });
                  if (emailController.text == "" ||
                      passwordController.text == "" ||
                      !emailController.text.contains('@')) {
                    Utils().customMessage(
                        context, "All fields are required!", Colors.redAccent);
                  } else if (passwordController.text.length < 5) {
                    Utils().customMessage(context, "Password field must be >5!",
                        Colors.redAccent);
                  } else {
                    User? result = await AuthService().signIn(
                        emailController.text, passwordController.text,context);
                    (result != null)
                        ? Utils().customMessage(
                            context, "SignIn Successfully", Colors.teal)
                        : Utils().customMessage(
                            context, "SignIn Failed", Colors.redAccent);
                  }
                  setState(() {
                    loading=false;
                  });
                },
                child: Text("Login"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Text('Don`t have an account? Register Here'))
          ],
        ),
      ),
    );
  }
}
