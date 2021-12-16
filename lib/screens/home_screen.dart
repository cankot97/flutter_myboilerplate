import 'package:flutter/material.dart';
import 'package:secondapp/services/auth_service.dart';
import 'Auth/auth_wrapper.dart';
import 'package:secondapp/model/bodypart.dart';
import 'package:secondapp/main.dart';
import 'package:firebase_auth/firebase_auth.dart'; 


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final authenticator = AuthService();
  double? markerX ;
  double? markerY ;

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
    
    if (FirebaseAuth.instance.currentUser == null) {return const  Authwrapper();}
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
                await authenticator.signOut();
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