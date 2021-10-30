// ignore: file_names
import 'package:flutter/material.dart';
import 'package:question/models/userModel.dart';
import 'package:question/util/databaseHelper.dart';

import '../../constants.dart';

Databasehelper _dbHelper = Databasehelper.instance;
List<User> _users = [];

class UserListPage extends StatefulWidget {
  State<UserListPage> createState() => _UserListPage();
}

class _UserListPage extends State<UserListPage> {
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
          Text(
            "Users List",
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _users.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 8.0,
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.purple[300]),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.white24))),
                      child:
                          Icon(Icons.people_alt_outlined, color: Colors.white),
                    ),
                    title: Text(
                      _users[index].userName.toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                    subtitle: Row(
                      children: <Widget>[
                        Text(_users[index].email.toString(),
                            style: TextStyle(color: Colors.white))
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
