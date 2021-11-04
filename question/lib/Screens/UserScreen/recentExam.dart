// ignore: file_names


import 'package:flutter/material.dart';
import 'package:question/models/RecentExam.dart';
import 'package:question/models/userModel.dart';
import 'package:question/util/databaseHelper.dart';
import 'package:intl/intl.dart';
import 'package:question/util/shared_Refernce.dart';
import '../../constants.dart';

Databasehelper _dbHelper = Databasehelper.instance;
List<RecentExam> _uExam = [];

class RecentExamPage extends StatefulWidget {
  State<RecentExamPage> createState() => _RecentExamPage();
}

class _RecentExamPage extends State<RecentExamPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _refreshContactList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(16), child: _buildTasks(context));
  }

  Widget _buildTasks(BuildContext context) {
    return (Container(
        child: Card(
            color: kPrimaryLightColor,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                      color: kPrimaryLightColor,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Recent Exams",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ))),
                          SizedBox(
            
          height: MediaQuery.of(context).size.height * 0.675,
          child:
                  ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _uExam.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 8.0,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(color: kPrimaryLightColor),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 1.0, color: Colors.white24))),
                              child: Icon(Icons.people_alt_outlined,
                                  color: kPrimaryColor),
                            ),
                            title: Text(
                              _uExam[index].UserName.toString(),
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(_uExam[index].SubcatagoryName.toString(),
                                    style: TextStyle(color: kPrimaryColor)),
                                    Text("${_uExam[index].rightAnswer.toString()} / ${_uExam[index].totalQuestion.toString()}",
                                    style: TextStyle(color: kPrimaryColor)),
                                       Text("estimated : ${_uExam[index].estimatedTime!.toStringAsFixed(2)} minute | elapsed : ${_uExam[index].takenTime!.toStringAsFixed(2)} minute",
                                    style: TextStyle(color: kPrimaryColor)),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      DateFormat('yyyy-MM-dd – kk:mm')
                                          .format(_uExam[index].creatdatetime!)
                                          .toString(),
                                      style: TextStyle(color: kPrimaryColor)),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
                ]))));
  }

  _refreshContactList() async {
     SharedPreferencesUtil _preferencesUtil = new SharedPreferencesUtil();
    int _id = _preferencesUtil.getId();

    List<RecentExam> x = await _dbHelper.fetchUserAnswer();
    setState(() {
      _uExam = x.where((element) => element.userId==_id).toList();
    });
  }
}
