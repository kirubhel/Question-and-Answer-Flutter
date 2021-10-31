import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question/Screens/AdminScreen/catagory.dart';
import 'package:question/components/rounded_button.dart';
import 'package:question/components/rounded_input_field.dart';
import 'package:question/constants.dart';
import 'package:question/models/catagoryModel.dart';
import 'package:question/models/questionModel.dart';
import 'package:question/models/subCatagoryModel.dart';
import 'package:question/util/databaseHelper.dart';
import 'package:question/widgets/DropDown.dart';
import 'package:question/models/listItem.dart';

String _question = "";
String _elapsedTime = "";
int _catagoryId = 0;
Databasehelper _dbHelper = Databasehelper.instance;

List<SubCatagory> categoriesList = [];

List<ListItem> _dropdownItems = [ListItem(0, "")];
List<DropdownMenuItem<ListItem>> _dropdownMenuItems = [];
ListItem? _selectedItem;
List<ListItem> _dropdownItems2 = [
  ListItem(0, "Second"),
  ListItem(1, "Minute"),
  ListItem(2, "Hour")
];
List<DropdownMenuItem<ListItem>> _dropdownMenuItems2 = [];
ListItem? _selectedItem2;

class questionModal extends StatefulWidget {
  State<questionModal> createState() => _questionModal();
}

class _questionModal extends State<questionModal> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _catfetch();

      for (var d in categoriesList) {
        ListItem k = new ListItem(d.id!, d.subCatagoryName!);
        _dropdownItems.add(k);
      }
      _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
      _selectedItem = _dropdownMenuItems[0].value;

      _dropdownMenuItems2 = buildDropDownMenuItems(_dropdownItems2);
      _selectedItem2 = _dropdownMenuItems2[0].value;
      ;
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
            minline: 5,
            maxline: 5,
            icon: Icons.question_answer_outlined,
            hintText: "Question",
            onChanged: (value) => {_question = value},
            //controller: settingsViewModel.ipAddressController)
          ),
          RoundedInputField(
            icon: Icons.timeline_outlined,
            hintText: "Elapsed Time",
            onChanged: (value) => {_elapsedTime = value},
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
                  value: _selectedItem2,
                  items: _dropdownMenuItems2,
                  onChanged: (value) {
                    setState(() {
                      _selectedItem2 = value;
                    });
                  }),
            ),
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

  _catfetch() async {
    _dropdownItems = [ListItem(0, "Select Sub Catagory")];
    Future<List<SubCatagory>> _categoriesLists = _dbHelper.fetchSCatagory();
    categoriesList = await _categoriesLists;
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
    Question q = Question();
    q.question = _question;
    q.elapsedTime = int.parse(_elapsedTime);
    q.subCatagoryId = _selectedItem!.value;
    q.timeMeasurment = _selectedItem2!.value == 0
        ? TimeMeasurment.second
        : _selectedItem2!.value == 1
            ? TimeMeasurment.minute
            : TimeMeasurment.hour;
    q.createdDateTime = DateTime.now();

    var x = _dbHelper.insertQuestion(q);
    if (x != null) {
      return 1;
    } else {
      return 2;
    }
  }



}























