import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:fabtech_aspirationclass_dev/models/appUser.dart';
import 'package:fabtech_aspirationclass_dev/screens/auth/singIn.dart';
import 'package:fabtech_aspirationclass_dev/screens/home/myHomePage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final AppUser user = Provider.of<AppUser>(context);
    final DataConnectionStatus connectivity = Provider.of<DataConnectionStatus>(context);
    print(user);
    if(connectivity == DataConnectionStatus.connected){
      EasyLoading.dismiss();
      if (user == null) {
        return SignInPage();
      } else {
        return MyHomePage(title: 'Home',);
      }
    } else if(connectivity == DataConnectionStatus.disconnected){
      EasyLoading.dismiss();
      return Container(
        child: Center(
          child: Text('No internet Connection'),
        ),
      );
    }
    else {
      return LoadingScreen();
    }
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.deepPurple.shade600, Colors.teal.shade400]
        ),
      ),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/2 + 100,
          height: MediaQuery.of(context).size.width/2 + 100,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.purpleAccent,
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('images/emblame.png'),
                  fit: BoxFit.fill
              ),
              shape: BoxShape.circle
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'loading..',
    maskType: EasyLoadingMaskType.none);
  }
}
