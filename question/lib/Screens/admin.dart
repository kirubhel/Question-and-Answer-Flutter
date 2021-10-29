import 'package:flutter/material.dart';
class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);
  final List<Widget> _widgetOptions = [];
  @override
  _AdminPageState createState() => _AdminPageState();
}
class _AdminPageState extends State<AdminPage> {
 @override
  Widget build(BuildContext context) {
    return   Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Center(
              child:   UserAccountsDrawerHeader(
              accountName: Text("Dr. admin Moges"),
              accountEmail: Text("admin@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Text(
                  "B",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ) ,
            )
          
         ])));
            
            
            }

}