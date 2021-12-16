import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth authenticator = FirebaseAuth.instance;

  //auth change user stream
  Stream<User?> get user {
    return authenticator.authStateChanges();
  }

  //sign in
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await  authenticator.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Sign up
  Future signUp(String email, String password) async {
    try{
      UserCredential result = await authenticator.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //Sign out
  Future signOut() async {
    try{
      return await authenticator.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}