import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/customPainter/LabelCustomPainter.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerL.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/BaseContainerR.dart';
import 'package:fabtech_aspirationclass_dev/services/studentDtls.dart';
import 'package:fabtech_aspirationclass_dev/models/appPref.dart';
import 'package:fabtech_aspirationclass_dev/main.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/models/ST001P.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';

class PersonalTab extends StatefulWidget {
  final String classNumStr,studentIdStr,studnetNameStr;
  PersonalTab({this.classNumStr,this.studentIdStr,this.studnetNameStr});
  @override
  _PersonalTabState createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {

  bool _isloading = true;
  String emailIDStr,contactNbrStr,genderStr,schoolStr,boardStr,admissionDateStr,admissionFeesStr,monthlyFeesStr;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade600, Colors.teal.shade400]
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topContainer(widget.studnetNameStr,'CLASS '+widget.classNumStr),
          Expanded(
            child: _isloading ? circularProgress() :
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/8,
                      padding: EdgeInsets.all(2.0),
                      child: BaseContainerRight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomPaint(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: Text('Email Id',
                                    style: headingTextStyle,
                                  ),
                                ),
                              ),
                              painter: RPSCustomPainter(
                              ),
                            ),
                            Center(
                              child: Text(emailIDStr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: amountHeadingTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.width/2 - 5,
                          //padding: EdgeInsets.all(2.0),
                          child: BaseContainerLeft(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomPaint(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text('Contact Num',
                                        style: headingTextStyle,
                                      ),
                                    ),
                                  ),
                                  painter: RPSCustomPainter(
                                  ),
                                ),
                                Center(
                                  child: Text(contactNbrStr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: amountHeadingTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.width/2 -5,
                          //padding: EdgeInsets.all(2.0),
                          child: BaseContainerLeft(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomPaint(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text('Gender',
                                        style: headingTextStyle,
                                      ),
                                    ),
                                  ),
                                  painter: RPSCustomPainter(
                                  ),
                                ),
                                Center(
                                  child: Text(genderStr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: amountHeadingTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: MediaQuery.of(context).size.height/8,
                            //padding: EdgeInsets.all(2.0),
                            child: BaseContainerLeft(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomPaint(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Text('School',
                                          style: headingTextStyle,
                                        ),
                                      ),
                                    ),
                                    painter: RPSCustomPainter(
                                    ),
                                  ),
                                  Center(
                                    child: Text(schoolStr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: amountHeadingTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.0),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: MediaQuery.of(context).size.height/8,
                            //padding: EdgeInsets.all(2.0),
                            child: BaseContainerLeft(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomPaint(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Text('Board',
                                          style: headingTextStyle,
                                        ),
                                      ),
                                    ),
                                    painter: RPSCustomPainter(
                                    ),
                                  ),
                                  Center(
                                    child: Text(boardStr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: amountHeadingTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height/8,
                            //padding: EdgeInsets.all(2.0),
                            child: BaseContainerLeft(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomPaint(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Text("Adm (MM/YY)",
                                          style: headingTextStyle,
                                        ),
                                      ),
                                    ),
                                    painter: RPSCustomPainter(
                                    ),
                                  ),
                                  Center(
                                    child: Text(admissionDateStr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: amountHeadingTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.0),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height/8,
                            //padding: EdgeInsets.all(2.0),
                            child: BaseContainerLeft(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomPaint(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Text('Adm Fees',
                                          style: headingTextStyle,
                                        ),
                                      ),
                                    ),
                                    painter: RPSCustomPainter(
                                    ),
                                  ),
                                  Center(
                                    child: Text(admissionFeesStr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: amountHeadingTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.0),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height/8,
                            //padding: EdgeInsets.all(2.0),
                            child: BaseContainerLeft(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomPaint(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Text('Monthly Fees',
                                          style: headingTextStyle,
                                        ),
                                      ),
                                    ),
                                    painter: RPSCustomPainter(
                                    ),
                                  ),
                                  Center(
                                    child: Text(monthlyFeesStr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: amountHeadingTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 25.0),
                          height: 60,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade400),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20),),
                                ),
                              ),
                            ),
                            //icon: Icon(Icons.exit_to_app_rounded),
                            child: Text('Promoted'),
                            onPressed: () async {
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25.0),
                          height: 60,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade400),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20),),
                                ),
                              ),
                            ),
                            //icon: Icon(Icons.exit_to_app_rounded),
                            child: Text('Deactivate'),
                            onPressed: () async {
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    emailIDStr ='';
    contactNbrStr ='';
    genderStr ='';
    schoolStr ='';
    boardStr ='';
    admissionDateStr  ='';
    admissionFeesStr  ='';
    monthlyFeesStr   ='';
    getStudentpersonalDtls();
  }

  getStudentpersonalDtls () async {
    try{
      StudentDtlsService studentDtlsService = StudentDtlsService(branchId: sp.getString(AppPref.userIdPref),
          classNum: widget.classNumStr,studentId: widget.studentIdStr);
      dynamic httpResult = await studentDtlsService.selectStudentPersonalDtls(kSelectStudentPersonalDetails);
      String possitiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
      }
      //data fetch from server end
      if(httpResult['status'] == possitiveStatus) {
        //Data i-s fetch successfully
        httpResult['data'].forEach((element){
          emailIDStr = element[ST001P.emailFld];
          contactNbrStr = element[ST001P.contactNumberFld];
          genderStr = element[ST001P.genderFld] == 'M' ? 'Male' : 'Female';
          schoolStr = element[ST001P.schoolFld];
          boardStr = element[ST001P.boardFld];
          admissionDateStr = element[ST001P.dateOfAdmissionFld];
          admissionFeesStr = element[ST001P.admissionFeesFld];
          monthlyFeesStr = element[ST001P.monthlyFeesFld];
        });
      }
      else {
        EasyLoading.showToast(httpResult['message']);
      }
    } catch (e) {
      EasyLoading.showToast(e);
    }
    //finally hide the progress bar
    setState(() {
      _isloading = false;
    });
  }

}

const amountHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'Swansea',
);

const headingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontFamily: 'yellowRabbit',
);
