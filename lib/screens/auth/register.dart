import 'dart:async';
import 'package:fabtech_aspirationclass_dev/customPainter/LabelCustomPainter.dart';
import 'package:fabtech_aspirationclass_dev/services/auth.dart';
import 'package:fabtech_aspirationclass_dev/models/appUser.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerL.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerR.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(('New Center')),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple.shade600, Colors.teal.shade400]
          ),
        ),
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(vertical: 50,horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent,
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SingleChildScrollView(child: SignInBody(auth: _auth)),
          ),
        ),
      ),
    );
  }
}



class SignInBody extends StatefulWidget {
  final AuthService auth;
  SignInBody({this.auth});
  @override
  _SignInBodyState createState() => _SignInBodyState();
}
class _SignInBodyState extends State<SignInBody> {
  final _formKey = GlobalKey<FormState>();
  String _emailId, _password,_centerName,_address,_contactNumber = '';
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('images/banner.png'),
                      fit: BoxFit.fill
                  ),
                  shape: BoxShape.rectangle
              ),
            ),
          ),
          SizedBox(height: 15,),
          BaseContainerLeft(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Text('Center Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    painter: RPSCustomPainter(),
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: TextFormField(
                      decoration: inputNameDecoration,
                      onSaved: (input) => _centerName = input,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your company Name';
                        }
                        if (value.length > 50) {
                          return 'Max length is 50';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          BaseContainerRight(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Text('Address',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    painter: RPSCustomPainter(),
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: TextFormField(
                      decoration: inputAddressDecoration,
                      onSaved: (input) => _address = input,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Address';
                        }
                        if (value.length > 100) {
                          return 'Max length is 50';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          BaseContainerRight(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Text('Contact Number',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    painter: RPSCustomPainter(),
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: inputContactDecoration,
                      onSaved: (input) => _contactNumber = input,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Contact Number';
                        }
                        if (value.length != 10) {
                          return 'Invalid Contact Number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          BaseContainerRight(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Text('Email Id',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    painter: RPSCustomPainter(),
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: TextFormField(
                      decoration: inputEmailDecoration,
                      controller: emailController,
                      onSaved: (input) => _emailId = input,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your EmailID';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          BaseContainerRight(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Text('Confirm Email Id',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    painter: RPSCustomPainter(),
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: TextFormField(
                      decoration: inputEmailDecoration,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter EmailId';
                        }
                        if (value != emailController.text) {
                          return 'EmailID is not matching';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          BaseContainerRight(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Text('Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    painter: RPSCustomPainter(),
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: TextFormField(
                      controller: passwordController,
                      decoration: inputPasswordDecoration,
                      obscureText: true,
                      onSaved: (input) => _password = input,
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'Password min length is 6';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          BaseContainerRight(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPaint(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Text('Confirm Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    painter: RPSCustomPainter(),
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: TextFormField(
                      decoration: inputPasswordDecoration,
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please confirm Password';
                        }
                        if (value !=
                            passwordController.text) {
                          return 'Password is not matching';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade400),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20),),
                  ),
                ),
              ),
              icon: Icon(Icons.assignment_ind_rounded),
              label: Text('Register'),
              onPressed: () async {

                if(_formKey.currentState.validate()){
                  _formKey.currentState.save();
                  EasyLoading.show(status: 'Wait..',maskType: EasyLoadingMaskType.none);
                  /*print('EmailId: '+_emailId);
                  print('Password: '+_password);*/
                  dynamic result = await widget.auth.registerWithEmailAndPassword(_emailId,_password,_centerName,_address,_contactNumber);
                  EasyLoading.dismiss();
                  if(result is String) {
                    EasyLoading.showToast(result);
                  } else {
                    //successful login
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
