import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:question/components/rounded_button.dart';
import 'package:question/components/rounded_input_field.dart';
import 'package:question/constants.dart';

import 'package:question/modal/questionModal.dart';
import 'package:question/models/catagoryModel.dart';
import 'package:question/models/choicesModel.dart';
import 'package:question/models/item.dart';
import 'package:question/models/questioanswer.dart';
import 'package:question/models/questionModel.dart';
import 'package:question/util/databaseHelper.dart';

Databasehelper _dbHelper = Databasehelper.instance;
List<Question> _question = [];

List<Choise> _choice = [];

class QuestionPage extends StatefulWidget {
  State<QuestionPage> createState() => _QuestionPage();
}

class _QuestionPage extends State<QuestionPage> {
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
                        child: questionModal());
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
          child: Container(
              child: RefreshIndicator(
            onRefresh: () => refreshContactList(),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _question.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
                  Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Column(
                        children: [
                          Container(
                            decoration:
                                BoxDecoration(color: kPrimaryLightColor),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0, color: kPrimaryColor))),
                                child: Icon(Icons.question_answer_outlined,
                                    color: kPrimaryColor),
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
                                      Text(
                                          _question[index]
                                              .elapsedTime
                                              .toString(),
                                          style:
                                              TextStyle(color: kPrimaryColor)),
                                      Text(
                                          _question[index]
                                                      .timeMeasurment
                                                      .toString() ==
                                                  "TimeMeasurment.second"
                                              ? " Second"
                                              : _question[index]
                                                          .timeMeasurment ==
                                                      TimeMeasurment.minute
                                                  ? " Minute"
                                                  : " Hour",
                                          style:
                                              TextStyle(color: kPrimaryColor)),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        DateFormat('yyyy-MM-dd – kk:mm')
                                            .format(_question[index]
                                                .createdDateTime!)
                                            .toString(),
                                        style: TextStyle(color: kPrimaryColor)),
                                  ),
                                  Text("Answer : ${_question[index].answerId}",
                                      style: TextStyle(color: kPrimaryColor))
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.add_box_outlined,
                                        color: kPrimaryColor),
                                    onPressed: () => {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: new choicemodal(
                                                    _question[index].id!));
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  topRight:
                                                      Radius.circular(10.0)))).then((value) => setState(() {refreshContactList();}))
                                    },
                                  ),
                                  Text(
                                    "|",
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit_outlined,
                                        color: kPrimaryColor),
                                    onPressed: () {
 showModalBottomSheet(

                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: new updateQuestion(
                                                    _question[index].id!));
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  topRight:
                                                      Radius.circular(10.0)))).then((value) => setState(() {
                                                        
                                                             showDialog(
                context: context,
                barrierDismissible: false, // user must tap button!

                builder: (BuildContext context) {
                  return new AlertDialog(
                    title: new Text('Update Status',
                        style: TextStyle(color: kPrimaryColor)),
                    content: new SingleChildScrollView(
                      child: new ListBody(
                        children: [
                          new Text('Successfully Updated',
                              style: TextStyle(color: kPrimaryColor)),
                        ],
                      ),
                    ),
                    actions: [
                      new RoundedButton(
                        text: "ok",
                        press: () {
                          Navigator.pop(
                            context,
                          )
                          ;
                           refreshContactList();
                        },
                      ),
                    ],
                  );
                },
              );
          
                                                        
                                                        
                                                        
                                                       }));
                                                 
                                    },
                                  ),
                                  Text(
                                    "|",
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline_outlined,
                                        color: kPrimaryColor),
                                    onPressed: () {
                                      _deleteQuestion(_question[index].id);
                                      showDialog(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!

                                        builder: (BuildContext context) {
                                          return new AlertDialog(
                                            title: new Text('Delete Status',
                                                style: TextStyle(
                                                    color: kPrimaryColor)),
                                            content: new SingleChildScrollView(
                                              child: new ListBody(
                                                children: [
                                                  new Text(
                                                      'Successfully Deleted',
                                                      style: TextStyle(
                                                          color:
                                                              kPrimaryColor)),
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
                                  )
                                ],
                              ),
                              onTap: () => {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: new answeremodal(
                                              _question[index].id!));
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0)))).then((value) => setState(() {refreshContactList();}))
                              },
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
                                              color: kPrimaryLightColor),
                                          child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20.0,
                                                    vertical: 10.0),
                                            leading: Container(
                                              padding:
                                                  EdgeInsets.only(right: 12.0),
                                              decoration: new BoxDecoration(
                                                  border: new Border(
                                                      right: new BorderSide(
                                                          width: 1.0,
                                                          color:
                                                              kPrimaryColor))),
                                              child: Text(
                                                  (index2 + 1).toString(),
                                                  style: TextStyle(
                                                      color: kPrimaryColor)),
                                            ),
                                            title: Text(
                                              _question[index]
                                                  .choices![index2]
                                                  .choise
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            trailing: IconButton(
                                              icon: Icon(Icons.delete_outlined,
                                                  color: kPrimaryColor),
                                              onPressed: () => {
                                                _deletechoice(_question[index]
                                                    .choices![index2]
                                                    .id)
                                              },
                                            ),
                                            onTap: () => {},
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
          )))
    ]));
    
  }

  _ontap(id) async {
    await _dbHelper.deleteSubCatagory(id);
    refreshContactList();
  }

  _deletechoice(id) async {
    await _dbHelper.deleteChoise(id);
    refreshContactList();
  }

  _deleteQuestion(id) async {
    await _dbHelper.deleteQuestion(id);
    refreshContactList();
  }

  refreshContactList() async {
    var x = await _dbHelper.fetchQuestion();
    var d = await _dbHelper.fetchChoise();
    setState(() {
      _question = [];
      for (var g in x) {
        var b = g;
        b.choices = d.where((f) => f.questionId == g.id).toList();
        _question.add(b);
      }
    });
  }
}

String _catagoryName = "";

List<Catagory> _catagory = [];

class choicemodal extends StatelessWidget {
  choicemodal(this.yourData);

  final int yourData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedInputField(
            minline: 3,
            maxline: 3,
            icon: Icons.question_answer_outlined,
            hintText: "Choice",
            onChanged: (value) => {_catagoryName = value},
            //controller: settingsViewModel.ipAddressController)
          ),

          // SelectableText("Your Phone Id: ${settingsViewModel.macAddress??""}"),
          const SizedBox(
            height: 20,
          ),
          RoundedButton(
            press: () {
              _onsave();
              Navigator.pop(context);
            },
            text: 'Add Choice',
            //: ButtonState.idle,
          ),
        ],
      ),
    );
  }

  _onsave() {
    Choise ca = Choise();
    ca.choise = _catagoryName;
    ca.questionId = yourData;
    ca.createdDate = DateTime.now();
    var x = _dbHelper.insertChoise(ca);
    if (x != null) {
      return 1;
    } else {
      return 2;
    }
  }
}

String _Answer = "";

class answeremodal extends StatelessWidget {
  answeremodal(this.yourData);

  final int yourData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedInputField(
            minline: 1,
            maxline: 1,
            icon: Icons.question_answer_outlined,
            hintText: "Answer",
            onChanged: (value) => {_Answer = value},
            //controller: settingsViewModel.ipAddressController)
          ),

          // SelectableText("Your Phone Id: ${settingsViewModel.macAddress??""}"),
          const SizedBox(
            height: 20,
          ),
          RoundedButton(
            press: () {
              _onsave();
              Navigator.pop(context);
            },
            text: 'Add answer',
            //: ButtonState.idle,
          ),
        ],
      ),
    );
  }

  _onsave() {
    var x = _dbHelper.updateQuestion(yourData, int.parse(_Answer));
    if (x != null) {
      return 1;
    } else {
      return 2;
    }
  }
}

String _que = "";

class updateQuestion extends StatelessWidget {
  updateQuestion(this.yourData);

  final int yourData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedInputField(
            minline: 3,
            maxline: 3,
            icon: Icons.question_answer_outlined,
            hintText: "Question",

            onChanged: (value) => {_que = value},
            //controller: settingsViewModel.ipAddressController)
          ),

          // SelectableText("Your Phone Id: ${settingsViewModel.macAddress??""}"),
          const SizedBox(
            height: 20,
          ),
          RoundedButton(
            press: () {
              _onsave();

              Navigator.pop(context);
           },
            text: 'Edit question',
            //: ButtonState.idle,
          ),
        ],
      ),
    );
  }

  _onsave() {
    var x = _dbHelper.updateQuestionque(yourData, _que);
    if (x != null) {
      return 1;
    } else {
      return 2;
    }
  }
}
