import 'dart:convert';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:http/http.dart' as http;
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/PY001P.dart';
import 'package:fabtech_aspirationclass_dev/models/FC001P.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';


class ProcessPaymentService {

  Future<dynamic> getAllPayment(String secondaryLink,String studentID) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[PY001P.branchIdFld] = sp.getString(AppPref.userIdPref);
      map[PY001P.sessionFld] = sp.getString(AppPref.sessionPref);
      map[PY001P.studentIDFld] = studentID;
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

  Future<dynamic> createMiscPayment(String secondaryLink,String studentID,studentName,facultyId,
      subject,classNbr,amount,comment,month,mode) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[PY001P.studentIDFld] = studentID;
      map[PY001P.branchIdFld] = sp.getString(AppPref.userIdPref);
      map[PY001P.facultyFld] = facultyId;
      map[PY001P.subjectFld] = subject;
      map[PY001P.sessionFld] = sp.getString(AppPref.sessionPref);
      map[FC001P.classNumFld] = classNbr;
      map[PY001P.feeFld] = amount;
      map[FC001P.nameFld] = studentName;
      map['COMMENT'] = comment;
      map[PY001P.modeFld] = mode;
      map[PY001P.monthFld] = month;
      print(map);
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        return "No Data, error at server end";
      }
    } catch (e) {
      return "Record selection failed, please try again";
    }
  }

  Future<dynamic> getPaymentDues(String secondaryLink,String studentID,facultyId,subject) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[PY001P.branchIdFld] = sp.getString(AppPref.userIdPref);
      map[PY001P.sessionFld] = sp.getString(AppPref.sessionPref);
      map[PY001P.studentIDFld] = studentID;
      map[PY001P.facultyFld] = facultyId;
      map[PY001P.subjectFld] = subject;
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

  Future<dynamic> createMonthlyPayment(String secondaryLink,String studentID,studentName,facultyId,
      subject,classNbr,amount,comment,month,mode) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[PY001P.studentIDFld] = studentID;
      map[PY001P.branchIdFld] = sp.getString(AppPref.userIdPref);
      map[PY001P.facultyFld] = facultyId;
      map[PY001P.subjectFld] = subject;
      map[PY001P.sessionFld] = sp.getString(AppPref.sessionPref);
      map[FC001P.classNumFld] = classNbr;
      map[PY001P.feeFld] = amount;
      map[FC001P.nameFld] = studentName;
      map['COMMENT'] = comment;
      map[PY001P.monthFld] = month;
      map[PY001P.modeFld] = mode;
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