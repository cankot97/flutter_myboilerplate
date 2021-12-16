
import 'package:flutter/material.dart';
import 'package:secondapp/screens/Auth/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secondapp/screens/Auth/login_screen.dart';
import 'package:secondapp/main.dart';

class Authwrapper extends StatefulWidget {
  const Authwrapper({ Key? key }) : super(key: key);

  @override
  _AuthwrapperState createState() => _AuthwrapperState();
}

class _AuthwrapperState extends State<Authwrapper> {

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null ? const Loginscreen() :const MyHomePage(title: 'title');
  }
}