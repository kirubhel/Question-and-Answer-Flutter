// ignore: file_names


import 'package:flutter/material.dart';
import 'package:question/models/userModel.dart';
import 'package:question/util/databaseHelper.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';

Databasehelper _dbHelper = Databasehelper.instance;
List<User> _users = [];

class RecentExam extends StatefulWidget {
  State<RecentExam> createState() => _RecentExam();
}

class _RecentExam extends State<RecentExam> {
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
                  ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _users.length,
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
                              _users[index].userName.toString(),
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(_users[index].email.toString(),
                                    style: TextStyle(color: kPrimaryColor)),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      DateFormat('yyyy-MM-dd – kk:mm')
                                          .format(_users[index].createdDate!)
                                          .toString(),
                                      style: TextStyle(color: kPrimaryColor)),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ]))));
  }

  _refreshContactList() async {
    List<User> x = await _dbHelper.fetchUsers();
    setState(() {
      _users = x;
    });
  }
}
