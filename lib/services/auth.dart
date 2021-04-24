import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fabtech_aspirationclass_dev/models/appUser.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:flutter/cupertino.dart';
import 'package:fabtech_aspirationclass_dev/services/registration.dart';
import 'package:fabtech_aspirationclass_dev/services/signIn.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //String _centerId,_centerName,_emailID = '';

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
    try
    {
      SignInService signInService = SignInService(emailId: email);
      dynamic httpResult = await signInService.signInUser(kSignIn);
      String possitiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        return 'Registration Failed, error at server.';
      }
      //user created as server end
      if(httpResult['status'] == possitiveStatus) {
        sp.setString(AppPref.centerIdPref, httpResult['CENTER_ID']);
        sp.setString(AppPref.centerNamePref, httpResult['NAME']);
        sp.setString(AppPref.emailPref, httpResult['EMAIL_ID']);
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return _userFromFirebaseCredential(result);
      } else {
        return httpResult['message'];
      }
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseCredential(result);
    }
    on FirebaseAuthException catch(e)
    {
      sp.setString(AppPref.centerIdPref, '');
      sp.setString(AppPref.emailPref, '');
      sp.setString(AppPref.centerNamePref, '');
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
  Future<dynamic> registerWithEmailAndPassword(String email,String password,String centerName,
      String address,String contactNumber) async
  {
    try
    {
      RegistrationService registrationService = RegistrationService(emailId: email,centerName: centerName,
          address: address,contactNumber: contactNumber);
      dynamic httpResult = await registrationService.registerUser(kRegisterUser);
      String possitiveStatus = 'true';

      //failed as server end
      if(httpResult is String){
        return 'Registration Failed, error at server.';
      }
      //user created as server end
      if(httpResult['status'] == possitiveStatus) {
        sp.setString(AppPref.centerIdPref, httpResult['CENTER_ID']);
        sp.setString(AppPref.centerNamePref, httpResult['NAME']);
        sp.setString(AppPref.emailPref, httpResult['EMAIL_ID']);
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        return _userFromFirebaseCredential(result);
      } else {
        return httpResult['message'];
      }
    }
    on FirebaseAuthException catch(e)
    {
      sp.setString(AppPref.centerIdPref, '');
      sp.setString(AppPref.emailPref, '');
      sp.setString(AppPref.centerNamePref, '');
      RegistrationService registrationService = RegistrationService(emailId: email,centerName: centerName,
          address: address,contactNumber: contactNumber);
      dynamic httpResult = await registrationService.deleteRegUser(kDeleteRegRequest);
      String possitiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        return 'Registration Failed, error at server.';
      }
      //temp user deleted from the server
      if(httpResult['status'] == possitiveStatus) {
        print('Firebase Error Code = ' + e.code);
        if (e.code == 'invalid-email') {
          return 'invalid EmailID.';
        } else if (e.code == 'email-already-in-use') {
          return 'EmailId is already registered.';
        }
      }else {
        return httpResult['message'];
      }
    }
    catch(e)
    {
      print(e.toString());
      return 'No Data';
    }
  }

  //SignOut
  Future signOut() async{
    try{
      sp.setString(AppPref.centerIdPref, '');
      sp.setString(AppPref.emailPref, '');
      sp.setString(AppPref.centerNamePref, '');
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}