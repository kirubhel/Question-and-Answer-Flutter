import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question/Screens/AdminScreen/catagory.dart';
import 'package:question/components/rounded_button.dart';
import 'package:question/components/rounded_input_field.dart';
import 'package:question/constants.dart';
import 'package:question/models/catagoryModel.dart';
import 'package:question/models/subCatagoryModel.dart';
import 'package:question/util/databaseHelper.dart';
import 'package:question/widgets/DropDown.dart';
import 'package:question/models/listItem.dart';

String _catagoryName = "";
int _catagoryId = 0;
Databasehelper _dbHelper = Databasehelper.instance;

List<Catagory> categoriesList = [];

List<ListItem> _dropdownItems = [ListItem(0, "")];
List<DropdownMenuItem<ListItem>> _dropdownMenuItems = [];
ListItem? _selectedItem;

class subcatagorymodal extends StatefulWidget {
  State<subcatagorymodal> createState() => _subcatagorymodal();
}

class _subcatagorymodal extends State<subcatagorymodal> {
  @override
  void initState() {
    super.initState();


  new Future<List<Catagory>>.delayed(new Duration(seconds: 2), ()=> _catfetch()  ).then((value) {

        categoriesList = value;


    setState(() {
     

      for (var d in categoriesList) {
        ListItem k = new ListItem(d.id!, d.catagoryName!);
        _dropdownItems.add(k);
      }
      _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
      _selectedItem = _dropdownMenuItems[0].value;

      ;
    });
  });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedInputField(
            icon: Icons.category_outlined,
            hintText: "Sub Catagory name",
            onChanged: (value) => {_catagoryName = value},
            //controller: settingsViewModel.ipAddressController)
          ),

          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kPrimaryLightColor, width: 4)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ListItem>(
                  iconSize: 36,
                  icon: Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                  isExpanded: true,
                  value: _selectedItem,
                  items: _dropdownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedItem = value;
                    });
                  }),
            ),
          ),
          // SelectableText("Your Phone Id: ${settingsViewModel.macAddress??""}"),
          SizedBox(
            height: 20,
          ),
          RoundedButton(
            press: () {
              _onsave();
              Navigator.pop(context);
            },
            text: 'Save',
            //: ButtonState.idle,
          ),
        ],
      ),
    );
  }

 Future<List<Catagory>> _catfetch() async {
    _dropdownItems = [ListItem(0, "Select Catagory")];
    Future<List<Catagory>> _categoriesLists = _dbHelper.fetchCatagory();
    return _categoriesLists;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  _onsave() {
    SubCatagory subCat = SubCatagory();
    subCat.subCatagoryName = _catagoryName;
    subCat.catagoryId = _selectedItem!.value;
    subCat.createdDateTime = DateTime.now();
    var x = _dbHelper.insertSubCatagory(subCat);
    if (x != null) {
      return 1;
    } else {
      return 2;
    }
  }
}
