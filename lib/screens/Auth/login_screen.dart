
import 'package:flutter/material.dart';
import 'package:secondapp/screens/Auth/auth_wrapper.dart';
import 'package:secondapp/model/bodypart.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secondapp/screens/Auth/login_screen.dart';
import 'package:secondapp/services/auth_service.dart';


class Loginscreen  extends StatefulWidget {
  const Loginscreen ({ Key? key }) : super(key: key);

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {

  final AuthService _auth = AuthService();

  //Signin and Signup field
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();


  void logout() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const Authwrapper();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Account authentication ' + (FirebaseAuth.instance.currentUser == null ? 'Out' : 'In')),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(controller: emailcontroller,),
            TextField(controller: passwordcontroller,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () => _auth.signIn(emailcontroller.text, passwordcontroller.text), child: const Text('Sign in')),
                ElevatedButton(onPressed: () => _auth.signUp(emailcontroller.text, passwordcontroller.text), child: const Text('Sign up')),
                ElevatedButton(onPressed: ()=> logout(), child: const Text('Log out'))
              ]
            )
          ],
        )
      ),
    );
  }
}