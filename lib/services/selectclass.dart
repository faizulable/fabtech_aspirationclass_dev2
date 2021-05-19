import 'dart:convert';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:http/http.dart' as http;
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/CL001P.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';

class SelectClass {
  String branchId;
  SelectClass({this.branchId});

  Future<dynamic> selectClassReq(String secondaryLink) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[CL001P.branchIdFld] = branchId;
      map[CL001P.sessionFld] = sp.getString(AppPref.sessionPref);
      //print(map);
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        //print(response.body);
        return jsonDecode(response.body);
      } else {
        return "No Data, error at server end";
      }
    } catch (e) {
      return "Record selection failed, please try again";
    }
  }
}