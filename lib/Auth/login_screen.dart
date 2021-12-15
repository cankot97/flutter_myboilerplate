import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secondapp/main.dart';
import 'package:secondapp/Auth/auth_wrapper.dart';


class Loginscreen  extends StatefulWidget {
  const Loginscreen ({ Key? key }) : super(key: key);

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {


  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void signin() async  {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);
    setState(() {
    });
  }


  void signup() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);
    setState(() {
    });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return Authwrapper();
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
                ElevatedButton(onPressed: () => signin(), child: const Text('Sign in')),
                ElevatedButton(onPressed: () => signup(), child: const Text('Sign up')),
                ElevatedButton(onPressed: ()=> logout(), child: const Text('Log out'))
              ]
            )
          ],
        )
      ),
    );
  }
}