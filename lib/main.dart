import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:fabtech_aspirationclass_dev/models/appUser.dart';
import 'package:fabtech_aspirationclass_dev/services/auth.dart';
import 'package:fabtech_aspirationclass_dev/services/dataConnectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sp;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sp = await SharedPreferences.getInstance();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 4000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.black26.withOpacity(0.5)
    ..userInteractions = true
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..dismissOnTap = false;

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AppUser>.value(
        initialData: AppUser.initialData(),
        value: AuthService().streamUserMethod,),
        StreamProvider<DataConnectionStatus>(
          initialData: DataConnectivityService().initialData(),
          create: (context){
            return DataConnectivityService().connectivityStreamController.stream;
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.teal.shade400,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.purple,
            elevation: 0,
            textTheme: TextTheme(headline6: TextStyle(color: Colors.white,fontSize: 20)),
          ),
        ),
        home: Wrapper(),
        builder: EasyLoading.init(),
      ),
    );

    /*StreamProvider<AppUser>.value(
      initialData: AppUser.initialData(),
      value: AuthService().streamUserMethod,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );*/
  }
}
