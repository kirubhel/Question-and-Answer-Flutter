import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:question/components/rounded_button.dart';
import 'package:question/constants.dart';
import 'package:question/modal/catagorymodal.dart';
import 'package:question/models/catagoryModel.dart';
import 'package:question/models/choicesModel.dart';
import 'package:question/models/listItem.dart';
import 'package:question/models/questioanswer.dart';
import 'package:question/models/questionModel.dart';
import 'package:question/models/subCatagoryModel.dart';
import 'package:question/models/userAnswer.dart';

import 'package:question/util/databaseHelper.dart';
import 'package:question/util/shared_Refernce.dart';

Databasehelper _dbHelper = Databasehelper.instance;
List<Catagory> _catagory = [];
List<ListItem> _dropdownItems = [ListItem(0, "")];
List<DropdownMenuItem<ListItem>> _dropdownMenuItems = [];
ListItem? _selectedItem;

List<SubCatagory> categoriesList = [];
List<Question> _question = [];
List<Choise> _choice = [];

DateTime? startDate;
DateTime? endDate;
List<QuestionAnswer> _questionAnswer = [];

class TakeExam extends StatefulWidget {
  State<TakeExam> createState() => _TakeExam();
}

class _TakeExam extends State<TakeExam> {

  @override
  void initState() {
   
    super.initState();

    new Future<List<SubCatagory>>.delayed(new Duration(seconds: 2), ()=> _catfetch()  ).then((value) {

         categoriesList = value;


    setState(() {
        
      _question = [];
    _questionAnswer= [];
    
      for (var d in categoriesList) {
        ListItem k = new ListItem(d.id!, d.subCatagoryName!);
        _dropdownItems.add(k);
      }
      _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
      _selectedItem = _dropdownMenuItems[0].value;
    });
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

        child: Column(children: <Widget>[
      Card(
          margin: EdgeInsets.all(0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: new Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: kPrimaryLightColor, width: 4)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ListItem>(
                          iconSize: 36,
                          icon:
                              Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                          isExpanded: true,
                          value: _selectedItem,
                          items: _dropdownMenuItems,
                          onChanged: (value) {
                            setState(() {
                              _selectedItem = value;
                              refreshContactList();
                            });
                          }),
                    ),
                  ),
                ),
              ),
            ],
          )),
          
      Container(
          child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _question.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              Card(
                  elevation: 8.0,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Column(
                    children: [
                      Container(
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
                                Icon(Icons.quiz_outlined, color: kPrimaryColor),
                          ),
                          title: Text(
                            _question[index].question.toString(),
                            style: const TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(_question[index].elapsedTime.toString(),
                                      style: TextStyle(color: kPrimaryColor)),
                                  Text(
                                      _question[index]
                                                  .timeMeasurment
                                                  .toString() ==
                                              "TimeMeasurment.second"
                                          ? " Second"
                                          : _question[index].timeMeasurment ==
                                                  TimeMeasurment.minute
                                              ? " Minute"
                                              : " Hour",
                                      style: TextStyle(color: kPrimaryColor))
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    DateFormat('yyyy-MM-dd – kk:mm')
                                        .format(
                                            _question[index].createdDateTime!)
                                        .toString(),
                                    style: TextStyle(color: kPrimaryColor)),
                              )
                            ],
                          ),
                          onTap: () => {},
                        ),
                      ),
                      ListView.builder(
                          itemCount: _question[index].choices!.length,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index2) {
  
                            return Card(
                                elevation: 8.0,
                                margin: new EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: _question[index].choices![index2].selected ? kPrimaryColor : kPrimaryLightColor),
                                      child: ListTile(
                                        
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        leading: Container(
                                          padding: EdgeInsets.only(right: 12.0),
                                          decoration: new BoxDecoration(
                                              border: new Border(
                                                  right: new BorderSide(
                                                      width: 1.0,
                                                      color: _question[index].choices![index2].selected ? Colors.white : kPrimaryColor))),
                                          child: Text((index2 + 1).toString(),
                                              style: TextStyle(
                                                  color: _question[index].choices![index2].selected ? Colors.white : kPrimaryColor)),
                                        ),
                                        title: Text(
                                          _question[index]
                                              .choices![index2]
                                              .choise
                                              .toString(),
                                          style:  TextStyle(
                                              color: _question[index].choices![index2].selected? Colors.white:kPrimaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () => {
                                  setState(() => _question[index].choices![index2].selected=!_question[index].choices![index2].selected),
                                          setAnswer(
                                              _question[index].id!, index2 + 1)
                                        },
                                      ),
                                    ),
                                  ],
                                ));
                          })
                    ],
                  ))
            ]);
          },
        ),
      )),
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
                        child: resultmodal(
                            startDate!, _question[0].subCatagoryId!));
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))));
            },
            color: kPrimaryLightColor,
            icon: const Icon(
              Icons.directions_transit,
              color: kPrimaryColor,
            ),
          )),
    ]));
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

  _ontap(id) async {
    var x = await _dbHelper.deleteCatagory(id);
  }

  Future<List<SubCatagory>>  _catfetch() async {
    _dropdownItems = [ListItem(0, "Select Sub Catagory")];
    Future<List<SubCatagory>> _categoriesLists = _dbHelper.fetchSCatagory();
   return _categoriesLists;
  }

  refreshContactList() async {
    startDate = DateTime.now();
    var x = await _dbHelper.fetchQuestion();
    var d = await _dbHelper.fetchChoise();
    List<Choise>f=[];
    for (var n in d){
      var g =n;
      g.selected=false;
      f.add(g);
    }
    setState(() {
      _question = [];
      for (var g in x) {
        var b = g;
        b.choices = f.where((f) => f.questionId == g.id).toList();
        _question.add(b);
      }

      _question = _question
          .where((x) => x.subCatagoryId == _selectedItem!.value)
          .toList();

      for (var g in _question) {
        QuestionAnswer _questionanswer = new QuestionAnswer(g.id!, 0);
        _questionAnswer.add(_questionanswer);
      }
    });
  }

  setAnswer(int qid, int aid) {
    for (var i = 0; i < _questionAnswer.length; i++) {
      if (_questionAnswer[i].questionId == qid) {
        _questionAnswer[i].answerId = aid;
      }
    }
  }
}

class resultmodal extends StatelessWidget {
  resultmodal(this.startDate, this.subcatagoryId);
  int right_question = 0;
  final List<int> wq = [];
  final int totalquestion = _question.length;
  double elapsedtime = 0.0;
  final DateTime startDate;
  final int subcatagoryId;
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    int difdate = DateTime.now().difference(startDate).inSeconds;
    double k = difdate / 60;
    for (var i = 0; i < _question.length; i++) {
      for (var j = 0; j < _questionAnswer.length; j++) {
        if (_question[i].id == _questionAnswer[j].questionId &&
            _question[i].answerId == _questionAnswer[j].answerId) {
          right_question += 1;
        }
      }

      if (_question[i].timeMeasurment == "TimeMeasurment.second") {
        elapsedtime += (_question[i].elapsedTime! / 60);
      } else if (_question[i].timeMeasurment == "TimeMeasurment.hour") {
        elapsedtime += (_question[i].elapsedTime! * 60);
      } else {
        elapsedtime += _question[i].elapsedTime!;
      }
    }
    SharedPreferencesUtil _preferencesUtil = new SharedPreferencesUtil();

    late int _id;
    _id = _preferencesUtil.getId();
    UserAnswer useranswer = UserAnswer();
    useranswer.elapsedTime = elapsedtime;
    useranswer.takenTime = k;
    useranswer.rightAnswer = right_question;
    useranswer.totalQuestion = totalquestion;
    useranswer.userId = _id;
    useranswer.subCatagoryId = subcatagoryId;
    useranswer.createdDate = DateTime.now();
    _dbHelper.insertUserAnswer(useranswer);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${right_question} / total: ${totalquestion}'),
          Text(
              '${k.toStringAsFixed(2)} minute / total time: ${elapsedtime} minute'),
          // SelectableText("Your Phone Id: ${settingsViewModel.macAddress??""}"),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
