import 'dart:convert';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:http/http.dart' as http;
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/ST001P.dart';
import 'package:fabtech_aspirationclass_dev/models/ST002P.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';

class AddStudentSubjectService{

  Future<dynamic> createSubject(String secondaryLink,String studentId, String facultyID, String subject, String classNum,
      String enrolDate, String monthlyFees, String totalDues) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[ST002P.studentIdFld] = studentId;
      map[ST002P.branchIdFld] = sp.getString(AppPref.userIdPref);
      map[ST002P.facultyIdFld] = facultyID;
      map[ST002P.subjectFld] = subject;
      map[ST001P.sessionFld] = sp.getString(AppPref.sessionPref);
      map[ST001P.classNumFld] = classNum;
      map[ST002P.dateOfEnrolFld] = enrolDate;
      map[ST002P.feeFld] = monthlyFees;
      map[ST002P.dueFld] = totalDues;
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

  Future<dynamic> removeSubject(String secondaryLink,String studentId, String facultyID, String subject, String classNum,) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[ST002P.studentIdFld] = studentId;
      map[ST002P.branchIdFld] = sp.getString(AppPref.userIdPref);
      map[ST002P.facultyIdFld] = facultyID;
      map[ST002P.subjectFld] = subject;
      map[ST002P.sessionFld] = sp.getString(AppPref.sessionPref);
      map[ST001P.classNumFld] = classNum;
      //print(map);
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        //print(response.body);
        return jsonDecode(response.body);
      } else {
        return "No Data, error at server end";
      }
    } catch (e) {
      return "Record process failed, please try again";
    }
  }
}