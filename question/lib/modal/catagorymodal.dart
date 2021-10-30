import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question/Screens/AdminScreen/catagory.dart';
import 'package:question/components/rounded_button.dart';
import 'package:question/components/rounded_input_field.dart';
import 'package:question/models/catagoryModel.dart';
import 'package:question/util/databaseHelper.dart';

String _catagoryName = "";
 Databasehelper _dbHelper = Databasehelper.instance;
List<Catagory> _catagory = []; 
class catagorymodal extends StatelessWidget {
  const catagorymodal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedInputField(
            icon: Icons.category_outlined,
            hintText: "Catagory name",
            onChanged: (value) => {_catagoryName = value},
            //controller: settingsViewModel.ipAddressController)
          ),

          // SelectableText("Your Phone Id: ${settingsViewModel.macAddress??""}"),
          SizedBox(
            height: 20,
          ),
          RoundedButton(
            press: () {
              _onsave();
              Navigator.pop(context);
              refreshContactList();
            },
            text: 'Save',
            //: ButtonState.idle,
          ),
        ],
      ),
    );
  }

  _onsave() {
    Catagory ca = Catagory();
    ca.catagoryName = _catagoryName;
    ca.createdDateTime = DateTime.now();
    var x = _dbHelper.insertCatagory(ca);
    if (x != null) {
      return 1;
    } else {
      return 2;
    }
  }
    refreshContactList() async {
    List<Catagory> x = await _dbHelper.fetchCatagory();
    
    _catagory= x;
  ;
  
  }
}
