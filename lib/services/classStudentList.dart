import 'dart:convert';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:http/http.dart' as http;
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/CL001P.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';

class ClassStudentListService {
  String branchId,classNum;
  ClassStudentListService({this.branchId,this.classNum});

  Future<dynamic> selectStudentReq(String secondaryLink) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[CL001P.branchIdFld] = branchId;
      map[CL001P.classNumFld] = classNum;
      map[CL001P.sessionFld] = sp.getString(AppPref.sessionPref);
      //print(map);
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        //print(response.body);
        return jsonDecode(response.body);
      } else {
        return "No Data";
      }
    } catch (e) {
      return "Record retrieval failed, please try again";
    }
  }
}