import 'package:fabtech_aspirationclass_dev/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/wrapper.dart';

   AppBar header(BuildContext context,String title){
     AuthService _auth = AuthService();
     return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'LemonMilkMedium',
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade400),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20),),
                ),
              ),
            ),
            icon: Icon(Icons.exit_to_app_rounded),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
              //Goto the the login page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Wrapper()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ),
      ],
    );
}