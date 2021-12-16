import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



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
        title: const Text('User Screen'),
      ),
      body: Center(
          child: Text(FirebaseAuth.instance.currentUser?.toString() ?? "No User"),
      ),
    );
  }
}