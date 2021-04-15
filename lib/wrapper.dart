import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:fabtech_aspirationclass_dev/models/appUser.dart';
import 'package:fabtech_aspirationclass_dev/screens/auth/singIn.dart';
import 'package:fabtech_aspirationclass_dev/screens/home/myHomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final AppUser user = Provider.of<AppUser>(context);
    final DataConnectionStatus connectivity = Provider.of<DataConnectionStatus>(context);
    print(user);
    if(connectivity == DataConnectionStatus.connected){
      if (user == null) {
        return SignInPage();
      } else {
        return MyHomePage(title: 'Home',);
      }
    } else if(connectivity == DataConnectionStatus.disconnected){
      return Container(
        child: Center(
          child: Text('No internet Connection'),
        ),
      );
    }
    else {
      return Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
