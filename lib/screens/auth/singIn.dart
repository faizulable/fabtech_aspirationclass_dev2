import 'package:fabtech_aspirationclass_dev/services/auth.dart';
import 'package:fabtech_aspirationclass_dev/models/appUser.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(('SignIn User')),
      ),
      body: Container(
        child: ElevatedButton(
          child: Text('SignIn Anon'),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if(result == null)
              {
                print('Error Signing in');
              } else {
              AppUser userdata = result;
              print('Signing in successful:' + userdata.uid);
            }
          },
        ),
      ),
    );
  }
}
