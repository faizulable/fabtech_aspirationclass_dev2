import 'package:flutter/material.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/topHeadline.dart';
import 'package:fabtech_aspirationclass_dev/screens/paymentDetail/paid/listPaidWidget.dart';
import 'package:fabtech_aspirationclass_dev/services/processPayment.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fabtech_aspirationclass_dev/utilites/constantValue.dart';
import 'package:fabtech_aspirationclass_dev/models/PY001P.dart';
import 'package:fabtech_aspirationclass_dev/utilites/widgets/progress.dart';
import 'package:fabtech_aspirationclass_dev/utilites/getMonth.dart';

class PaidTab extends StatefulWidget {
  final String studentId,studentName;
  PaidTab({this.studentId,this.studentName});
  @override
  _PaidTabState createState() => _PaidTabState();
}

class _PaidTabState extends State<PaidTab> {
  String _totalAmountStr = '0000';
  List<PaidList> _paidList;
  bool _isLoading = true;


  @override
  void initState() {
    _paidList = [];
    getPaymentList();
    /*_paidList.add(PaidList('123456789dd','APRIL','MATHS','20/04/2021','400','CASH'));
    _paidList.add(PaidList('123456789dd','APRIL','PHYSICS','20/04/2021','400','CASH'));
    _paidList.add(PaidList('123456789dd','APRIL','COMPUTER','20/04/2021','400','CASH'));
    _paidList.add(PaidList('123456789dd','APRIL','BIOLOGY','20/04/2021','400','CASH'));*/
    super.initState();
  }
//Method to get the list of teachers, currently preset in the class
  getPaymentList() async {
    _paidList = [];
    int total = 0;
    try {
      ProcessPaymentService processPaymentService = ProcessPaymentService();
      dynamic httpResult = await processPaymentService.getAllPayment(kgetStudentPayments,widget.studentId);
      String positiveStatus = 'true';
      //failed as server end
      if(httpResult is String){
        EasyLoading.showToast(httpResult);
        setState(() {
          _isLoading = false;
          _totalAmountStr = total.toString();
        });
      }
      //data fetch from server end
      if(httpResult['status'] == positiveStatus){
        //Data is fetch successfully
        httpResult['data'].forEach((element){
          _paidList.add(PaidList(element[PY001P.refNumFld], convertNumtoMonth(element[PY001P.monthFld]),
          element[PY001P.subjectFld],element[PY001P.payDateFld],element[PY001P.feeFld],element[PY001P.modeFld]));
          total = total + int.parse(element[PY001P.feeFld]);
        });
      } else {
        EasyLoading.showToast(httpResult['message']);
      }
    } catch (e) {
      EasyLoading.showToast(e);
      setState(() {
        _isLoading = false;
        _totalAmountStr = total.toString();
      });
    }
    //finally hide the progress bar
    setState(() {
      _isLoading = false;
      _totalAmountStr = total.toString();
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
            topContainer(widget.studentName,'PAYMENT DETAILS'),
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
                  Text('Amount: ',
                      style: amountHeadingTextStyle),
                  Text(_totalAmountStr,
                      style: amountValueTextStyle),
                ],
              ),
            ),
            Expanded(
              child:  _isLoading ? circularProgress() : Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                child: ListView.builder(
                  itemCount: _paidList.length,
                  itemBuilder:(BuildContext context, int index) {
                    String monthSubject = _paidList[index].month + '-' + _paidList[index].subject;
                    return PaidListWidget(refNum: _paidList[index].refNum,monthSubject: monthSubject,date: _paidList[index].date,
                        amount: _paidList[index].amount,mode: _paidList[index].mode);
                    },
                  ),
                ),
              ),
            SizedBox(height: 5.0)
          ],
      ),
    );
  }
}

class PaidList {
  final String refNum,month,subject,date,amount,mode;
  PaidList(this.refNum,this.month,this.subject,this.date,this.amount,this.mode);
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
