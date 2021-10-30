import 'package:flutter/material.dart';
import 'package:question/modal/catagorymodal.dart';
import 'package:question/models/catagoryModel.dart';

import 'package:question/util/databaseHelper.dart';



   Databasehelper _dbHelper = Databasehelper.instance;
List<Catagory> _catagory = [];
class CatagoryPage extends StatefulWidget {
  State<CatagoryPage> createState() => _CatagoryPage();
}
class _CatagoryPage extends State<CatagoryPage> {


  @override
void initState () {
  super.initState();
  setState(() {
    
    refreshContactList ();
  });
}




  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(16), child: _buildTasks(context));
  }


  Widget _buildTasks(BuildContext context) {
    
   
    return (Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:SingleChildScrollView(child: 
        
        
         Column(children: <Widget>[
          
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
                        child: catagorymodal());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))));
            },
            color: Colors.purple[300],
            icon: const Icon(Icons.add_circle),
          )
          ),
         Container(
           child:
           SingleChildScrollView(child:
            ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _catagory.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
                  child: Icon(Icons.category_outlined, color: Colors.white),
                ),
                title: Text(
                _catagory[index].catagoryName.toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    )
         )
    ]
    )
    )
    ));
  }

  refreshContactList() async {
    List<Catagory> x = await _dbHelper.fetchCatagory();
    setState(() {
    _catagory= x;
  });
  
  }

 
}
