import 'dart:convert';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:http/http.dart' as http;
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/ST001P.dart';
import 'package:fabtech_aspirationclass_dev/models/ST002P.dart';
import 'package:fabtech_aspirationclass_dev/models/addStudent.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';

class CreateStudentService{

  Future<dynamic> createStudent(String secondaryLink,AddStudentPersonalDetails addStudentPersonalDetails,
      String jsonSubList, String monthlyFees, String totalDues) async {
    String link = kRootlink + secondaryLink;
    var url = Uri.parse(link);
    try {
      var map = new Map<String, dynamic>();
      map[ST001P.nameFld] = addStudentPersonalDetails.name;
      map[ST002P.branchIdFld] = sp.getString(AppPref.userIdPref);
      map[ST001P.contactNumberFld] = addStudentPersonalDetails.contactNum;
      map[ST001P.classNumFld] = addStudentPersonalDetails.classNum;
      map[ST001P.sessionFld] = sp.getString(AppPref.sessionPref);
      map[ST001P.monthlyFeesFld] = monthlyFees;
      map[ST001P.duesFld] = totalDues;
      map[ST001P.emailFld] = addStudentPersonalDetails.emailId;
      map[ST001P.genderFld] = addStudentPersonalDetails.gender;
      map[ST001P.schoolFld] = addStudentPersonalDetails.school;
      map[ST001P.boardFld] = addStudentPersonalDetails.board;
      map[ST001P.admissionFeesFld] = addStudentPersonalDetails.admFees;
      map[ST001P.dateOfAdmissionFld] = addStudentPersonalDetails.dateOfAdd;
      map['SUBJECT_LIST'] = jsonSubList;
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