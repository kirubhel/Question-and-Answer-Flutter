import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:question/constants.dart';
import 'package:question/modal/catagorymodal.dart';
import 'package:question/models/catagoryModel.dart';

import 'package:question/util/databaseHelper.dart';

Databasehelper _dbHelper = Databasehelper.instance;
List<Catagory> _catagory = [];

class RecentExam extends StatefulWidget {
  State<RecentExam> createState() => _RecentExam();
}

class _RecentExam extends State<RecentExam> {
  @override
  void initState() {
    super.initState();
    setState(() {
      refreshContactList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(16), child: _buildTasks(context));
  }

  Widget _buildTasks(BuildContext context) {
    
    return SingleChildScrollView(

            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
         
                child:Column(
                  children: <Widget>[
                  
          Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                iconSize: 50,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: catagorymodal());
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0))));
                },
                color: kPrimaryLightColor,
                icon: const Icon(
                  Icons.add_circle,
                  color: kPrimaryColor,
                ),
              )),
         
            RefreshIndicator(
                onRefresh: () => refreshContactList(),
              child:  ListView.builder(
                
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _catagory.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 8.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
                                    width: 1.0, color: kPrimaryColor))),
                        child:
                            Icon(Icons.category_outlined, color: kPrimaryColor),
                      ),
                      title: Text(
                        _catagory[index].catagoryName.toString(),
                        style: const TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          DateFormat('yyyy-MM-dd – kk:mm')
                              .format(_catagory[index].createdDateTime!)
                              .toString(),
                          style: TextStyle(color: kPrimaryColor)),
                      trailing:  
                      IconButton(
                        icon: Icon( Icons.delete_outline_outlined ,color: kPrimaryColor),onPressed: ()=>{_ontap(_catagory[index].id)}, ),
                      onTap: () => {},
                    ),
                  ),
                );
              },
            )
            ),
          
        ]));
  }

  _ontap(id) async {
    var x = await _dbHelper.deleteCatagory(id);
    refreshContactList();
  }

  refreshContactList() async {
    List<Catagory> x = await _dbHelper.fetchCatagory();
    setState(() {
      _catagory = x;
    });
  }
}
