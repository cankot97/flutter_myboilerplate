
import 'package:flutter/material.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
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
              ]
            )
          ],
        )
      ),
    );
  }
}