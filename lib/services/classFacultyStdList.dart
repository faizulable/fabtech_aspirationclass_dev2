import 'dart:convert';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:http/http.dart' as http;
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/FC001P.dart';
import 'package:fabtech_aspirationclass_dev/models/ST002P.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';

class ClassFacultyStdListService {
  String branchId,classNum,subject,facultyId;
  ClassFacultyStdListService({this.branchId,this.classNum,this.subject,this.facultyId});

  Future<dynamic> selectFacultyStdReq(String secondaryLink) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[FC001P.branchIdFld] = branchId;
      map[FC001P.classNumFld] = classNum;
      map[FC001P.subjectFld] = subject;
      map[FC001P.facultyFld] = facultyId;
      map[ST002P.sessionFld] = sp.getString(AppPref.sessionPref);
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

  Future<dynamic> selectFacultyPayment(String secondaryLink,monthStr,yearStr) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[FC001P.branchIdFld] = branchId;
      map[FC001P.facultyFld] = facultyId;
      map[FC001P.subjectFld] = subject;
      map[FC001P.classNumFld] = classNum;
      map['MONTH'] = monthStr;
      map['YEAR'] = yearStr;
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

  Future<dynamic> selectFacultyDues(String secondaryLink) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[FC001P.branchIdFld] = branchId;
      map[FC001P.facultyFld] = facultyId;
      map[FC001P.subjectFld] = subject;
      map[FC001P.classNumFld] = classNum;
      print(map);
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        return "No Data";
      }
    } catch (e) {
      return "Record retrieval failed, please try again";
    }
  }

}