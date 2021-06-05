import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/screens/paymentDetail/dues/listWidgetDue.dart';
import 'package:fabtech_aspirationclass_dev/services/processDue.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/PY002P.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';
import 'package:fabtech_aspirationclass_dev/utilites/getMonth.dart';
import 'package:fabtech_aspirationclass_dev/screens/paymentDetail/addPayment/addPayment.dart';

class DueTab extends StatefulWidget {
  final String facultyId,subject,studentId,studentName,classNum,subjectFee;
  DueTab({this.facultyId,this.subject,this.studentId,this.studentName,this.classNum,this.subjectFee});
  @override
  _DueTabState createState() => _DueTabState();
}

class _DueTabState extends State<DueTab> {
  String _facultyNameStr = 'Teacher Name';
  String _totalAmountStr = '0000';
  List<DueList> _dueList;
  bool _isLoading = true;


  @override
  void initState() {
    _dueList = [];
    getDuesList();
/*    _dueList.add(DueList('APRIL','400','220','180'));
    _dueList.add(DueList('MAY','400','220','180'));
    _dueList.add(DueList('JUNE','400','220','180'));
    _dueList.add(DueList('JULY','400','220','180'));*/
    super.initState();
  }
//Method to get the list of teachers, currently preset in the class
  getDuesList() async {
    _dueList = [];
    int totalDue = 0;
    try {
      ProcessDueService processDueService = ProcessDueService();
      dynamic httpResult = await processDueService.getDue(kgetDues,widget.facultyId,widget.subject,widget.studentId);
      String positiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
        setState(() {
          _isLoading = false;
        });
      }
      //data fetch from server end
      if(httpResult['status'] == positiveStatus){
        //Data is fetch successfully
        httpResult['data'].forEach((element){
          _dueList.add(DueList(convertNumtoMonth(element[PY002P.monthFld]), element[PY002P.feeFld],element[PY002P.perShareAspFld],element[PY002P.perShareFacultyFld]));
          totalDue = totalDue + int.parse(element[PY002P.feeFld]);
        });
        //set the faculty name
        _facultyNameStr = httpResult['Faculty'];
      } else {
        _facultyNameStr = httpResult['Faculty'];
        EasyLoading.showToast(httpResult['message']);
      }
    } catch (e) {
      EasyLoading.showToast(e);
      setState(() {
        _isLoading = false;
      });
    }
    //finally hide the progress bar
    setState(() {
      _isLoading = false;
      _totalAmountStr = totalDue.toString();
    });
  }
//
  @override
  Widget build(BuildContext context) {
    return Container(width: MediaQuery.of(context).size.width,
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
            topContainer(widget.studentName,widget.subject + ' (DUES)'),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 7),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                shape: BoxShape.rectangle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Teacher: ',
                      style: amountHeadingTextStyle),
                  Text(_facultyNameStr,
                      style: amountValueTextStyle),
                  SizedBox(width: 15),
                  Text('Amount: ',
                      style: amountHeadingTextStyle),
                  Text(_totalAmountStr,
                      style: amountValueTextStyle),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child:  _isLoading ? circularProgress() : Container(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                      child: ListView.builder(
                        itemCount: _dueList.length,
                        itemBuilder:(BuildContext context, int index) {
                          return ListDueWidget(month: _dueList[index].month,due: _dueList[index].due,
                              aspShare: _dueList[index].aspShare,facShare: _dueList[index].facShare);
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FloatingActionButton(
                        child: Icon(Icons.navigate_before),
                        onPressed: () {
                          //go back
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 100.0),
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
                child: Text('Add Payment'),
                onPressed: () async {
                  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddPayment(studentName: widget.studentName,subjectFee: widget.subjectFee,
                      studentID: widget.studentId,facultyID: widget.facultyId,
                        subject: widget.subject,classNbr: widget.classNum);
                  })) ?? false;
                  // Payment is successfully accepted
                  if(result){
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            SizedBox(height: 5.0)
          ],
      ),
    );
  }
}

class DueList {
  final String month,due,aspShare,facShare;
  DueList(this.month,this.due,this.aspShare,this.facShare);
}

//Text Styling
const amountValueTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 20,
  fontFamily: 'LandasansMedium',
);

const amountHeadingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'LandasansMedium',
);
