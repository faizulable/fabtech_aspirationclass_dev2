import 'dart:convert';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:http/http.dart' as http;
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/PY002P.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';


class ProcessDueService {
  Future<dynamic> getDue(String secondaryLink,String facultyID,String subject,String studentID) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[PY002P.branchIdFld] = sp.getString(AppPref.userIdPref);
      map[PY002P.sessionFld] = sp.getString(AppPref.sessionPref);
      map[PY002P.studentIDFld] = studentID;
      map[PY002P.facultyFld] = facultyID;
      map[PY002P.subjectFld] = subject;
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
}