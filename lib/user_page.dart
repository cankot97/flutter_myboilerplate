
import 'package:flutter/material.dart';
import 'package:secondapp/screens/Auth/auth_wrapper.dart';
import 'package:secondapp/model/bodypart.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secondapp/screens/Auth/login_screen.dart';


class UserPage extends StatefulWidget {
  const UserPage({ Key? key }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Screen'),
      ),
      body: Center(
        child: Container(
          child: Text(FirebaseAuth.instance.currentUser?.toString() ?? "No User"),
        ),
      ),
    );
  }
}