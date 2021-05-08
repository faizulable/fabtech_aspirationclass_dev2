import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/CT001P.dart';
class SignInService {
  String emailId;

  SignInService(
      {this.emailId});

  Future<dynamic> signInUser(String secondaryLink) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[CT001P.emailFld] = emailId;
      print(map);
      final response = await http.post(url, body: map);
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return "No Data";
      }
    } catch (e) {
      return "Record creation failed, please try again";
    }
  }

  /*Future<dynamic> deleteRegUser(String secondaryLink) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[CT001P.emailFld] = emailId;
      print(map);
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        return "No Data";
      }
    } catch (e) {
      return "Record creation failed, please try again";
    }
  }*/
}