import 'package:firebase_auth/firebase_auth.dart';
import 'package:fabtech_aspirationclass_dev/models/appUser.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user obj based on UserCredential
  AppUser _userFromFirebaseCredential (UserCredential userdata) {
    return userdata!= null ? AppUser(uid: userdata.user.uid) : null ;
  }

  //Create user obj based on SteamUser
  AppUser _userFromFirebaseStream (User userdata) {
    return userdata!= null ? AppUser(uid: userdata.uid) : null ;
  }

  //Auth change user stream
  Stream<AppUser> get streamUserMethod {
    //return _auth.authStateChanges().map((User userdata) => _userFromFirebaseStream(userdata));
    //OR below code return the same output
    return _auth.authStateChanges().map(_userFromFirebaseStream);
  }

  // SignIn with anon
  Future<dynamic> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return _userFromFirebaseCredential(result);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  //SignIn with Email and Password
  Future<dynamic> signInWithEmailAndPassword(String email,String password) async
  {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseCredential(result);
    } on FirebaseAuthException catch(e){
      print('Firebase Error Code = '+e.code);
      if(e.code == 'invalid-email'){
        return 'invalid EmailID.';
      } else if(e.code == 'user-not-found'){
        return 'User is not registered, user not found.';
      } else if(e.code == 'wrong-password'){
        return 'Wrong password provided for that user.';
      }
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // SignUp with Email and Password
  Future<dynamic> registerWithEmailAndPassword(String email,String password) async
  {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseCredential(result);
    } on FirebaseAuthException catch(e){
      print('Firebase Error Code = '+e.code);
      if(e.code == 'invalid-email'){
        return 'invalid EmailID.';
      } else if(e.code == 'email-already-in-use'){
        return 'EmailId is already registered.';
      }
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //SignOut
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}