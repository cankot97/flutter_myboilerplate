
import 'package:flutter/material.dart';
import 'package:secondapp/screens/Auth/auth_wrapper.dart';
import 'package:secondapp/model/bodypart.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:secondapp/services/auth_service.dart';


Future<BodyPart> getBpdescr(int i) async {
  var dio = Dio();
  var res = await dio.get('https://jsonplaceholder.typicode.com/albums/' + i.toString());
  return BodyPart.fromJson(res.data);
}


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>(
      create: (_) => AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: "Flutter Firebase Authentication",
        theme: ThemeData(),
        home: const Authwrapper(),
      ),
    );
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //   ),
    //   // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    //   home: const Authwrapper(),
  }
}






