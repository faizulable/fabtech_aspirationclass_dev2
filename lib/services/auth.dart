import 'package:firebase_auth/firebase_auth.dart';
import 'package:fabtech_aspirationclass_dev/models/appUser.dart';

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

  // SignUp with Email and Password

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