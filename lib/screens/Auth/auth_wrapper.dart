
import 'package:flutter/material.dart';
import 'package:secondapp/screens/Auth/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secondapp/screens/Auth/login_screen.dart';
import 'package:secondapp/main.dart';
import 'package:provider/provider.dart';

class Authwrapper extends StatefulWidget {
  const Authwrapper({ Key? key }) : super(key: key);

  @override
  _AuthwrapperState createState() => _AuthwrapperState();
}

class _AuthwrapperState extends State<Authwrapper> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    print(user);

    if(user == null){
      return const Loginscreen();
    }
    else {
      return const MyHomePage(title: 'My Home Page');
    }
  }
}