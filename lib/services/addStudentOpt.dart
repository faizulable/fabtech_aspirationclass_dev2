import 'dart:convert';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:http/http.dart' as http;
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/FC001P.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';

class AddStudentOpt {
  String classNbr;
  AddStudentOpt({this.classNbr});

  Future<dynamic> getSchoolList(String secondaryLink,String calledBy) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[FC001P.branchIdFld] = sp.getString(AppPref.userIdPref);
      map['CALLED_BY'] = calledBy;
      map[FC001P.classNumFld] = classNbr;
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

  Future<dynamic> getFactultyList(String secondaryLink,String calledBy) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[FC001P.branchIdFld] = sp.getString(AppPref.userIdPref);
      map['CALLED_BY'] = calledBy;
      map[FC001P.classNumFld] = classNbr;
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