import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:question/components/rounded_button.dart';
import 'package:question/constants.dart';
import 'package:question/modal/subCatagorymodal.dart';
import 'package:question/models/item.dart';
import 'package:question/models/subCatagoryModel.dart';
import 'package:question/util/databaseHelper.dart';

Databasehelper _dbHelper = Databasehelper.instance;
List<Item> _catagory = [];

class SubCatagoryPage extends StatefulWidget {
  State<SubCatagoryPage> createState() => _SubCatagoryPage();
}

class _SubCatagoryPage extends State<SubCatagoryPage> {
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
        child: Column(children: <Widget>[
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
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: subcatagorymodal());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)))).then((value) => setState(() {refreshContactList();}));
            },
            color: kPrimaryLightColor,
            icon: const Icon(
              Icons.add_circle,
              color: kPrimaryColor,
            ),
          )),
      SizedBox(
            
          height: MediaQuery.of(context).size.height * 0.675,
          child: RefreshIndicator(
        onRefresh: () => refreshContactList(),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _catagory.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(color: kPrimaryLightColor),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: kPrimaryColor))),
                    child: Icon(Icons.category_outlined, color: kPrimaryColor),
                  ),
                  title: Text(
                    _catagory[index].subCName.toString(),
                    style: const TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_catagory[index].CName.toString(),
                          style: TextStyle(color: kPrimaryColor)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            DateFormat('yyyy-MM-dd – kk:mm')
                                .format(_catagory[index].creatdatetime!)
                                .toString(),
                            style: TextStyle(color: kPrimaryColor)),
                      )
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline_outlined,
                        color: kPrimaryColor),
                    onPressed: () async {
                      int c = await _ontap(_catagory[index].value);
                                 showDialog(
                    context: context,
                    barrierDismissible: false, // user must tap button!

                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: new Text('Delete Status'),
                        content: new SingleChildScrollView(
                          child: new ListBody(
                            children: [
                              new Text(c == 999999
                                  ? 'Error : Question on this SUb Catagory Exist'
                                 
                                      : 'Successfully Deleted'),
                            ],
                          ),
                        ),
                        actions: [
                          new RoundedButton(
                            text: "ok",
                            press: () {
                              Navigator.pop(
                                context,
                                
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
              
                           },
                  ),
                  onTap: () => {},
                ),
              ),
            );
          },
        ),
      ))
    ]));
  }

  Future<int> _ontap(id) async {
    var x = await _dbHelper.deleteSubCatagory(id);
    refreshContactList();
    return x;
  }

  refreshContactList() async {
    List<Item> x = await _dbHelper.fetchSubCatagory();
    setState(() {
      _catagory = x;
    });
  }
}
