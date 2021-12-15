
import 'package:flutter/material.dart';
import 'package:secondapp/Auth/auth_wrapper.dart';
import 'package:secondapp/model/bodypart.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secondapp/Auth/login_screen.dart';



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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: Authwrapper(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  
  double? markerX = null;
  double? markerY = null;

  BodyPart? whatBodyPart(double? x, double? y){
    for(var bodypart in bodyparts){
      if(bodypart.isBodyPart(x, y)){
        return bodypart;
      }
    }
    return null;
  }

  void _onTapDown(TapDownDetails details){
    double x = details.globalPosition.dx;
    double y = details.globalPosition.dy;  

    setState(() {
      markerX = x;
      markerY = y - AppBar().preferredSize.height - MediaQuery.of(context).padding.top;
    });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder){
        return Container(
          child: detailCard(whatBodyPart(markerX, markerY)),
        );
      }
    );
  }



  @override
  Widget build(BuildContext context) {
    
    if (FirebaseAuth.instance.currentUser == null) {return  Authwrapper();}
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children:  [
            GestureDetector(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/images/body.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              onTapDown: (TapDownDetails details) =>  _onTapDown(details),
            ),
            Positioned(
              left: markerX, 
              top: markerY,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Log out'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                setState(() {
                });
              },
            )

          ])
      ),
    );
  }

  Widget detailCard(BodyPart? bp){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            bp?.name ?? 'No Body Part',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 30
            ),
          ),
          FutureBuilder<BodyPart>(
            future: getBpdescr(bp?.id ?? 10),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return Text(snapshot.data?.title ?? "Fetching Error");
              }
              return const CircularProgressIndicator();
            },
          ),
          ElevatedButton(
            child: const Text('Back'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

}
// intergate firebase user authentication.
// login and regis screen
//screen for login user information

//packages provider



