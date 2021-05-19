import 'dart:convert';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:http/http.dart' as http;
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/ST001P.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';

class StudentDtlsService {
  String branchId,classNum,studentId;
  StudentDtlsService({this.branchId,this.classNum,this.studentId});

  Future<dynamic> selectStudentPersonalDtls(String secondaryLink) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[ST001P.studentIdFld] = studentId;
      map[ST001P.sessionFld] = sp.getString(AppPref.sessionPref);
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

  Future<dynamic> selectStudentSubjectDtls(String secondaryLink) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[ST001P.studentIdFld] = studentId;
      map[ST001P.sessionFld] = sp.getString(AppPref.sessionPref);
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