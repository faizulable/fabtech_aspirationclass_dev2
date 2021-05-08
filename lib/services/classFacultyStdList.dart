import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/FC001P.dart';

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