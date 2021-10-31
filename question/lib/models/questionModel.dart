import 'package:question/models/choicesModel.dart';

class Question {
  static const tblQuestion = 'Question';

  static const colId = 'id';
  static const colQuesiton = 'question';
  static const colsubCatagoryId = 'subCatagoryId';
  static const colElapsedTime = 'elapsedTime';

  static const colTimeMeasurment = 'timeMeasurment';
  static const colCreatedDateTime = 'createdDateTime';
  static const colAnswerId = 'answerId';

  Question();

  int? id;
  String? question;
  int? subCatagoryId;
  int? elapsedTime;
  int? answerId;
  TimeMeasurment? timeMeasurment;
  DateTime? createdDateTime;
  List<Choise>? choices;

  Question.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];

    question = map[colQuesiton];
    subCatagoryId = map[colsubCatagoryId];
    elapsedTime = map[colElapsedTime];

    answerId = map[colAnswerId];
    timeMeasurment = map[colTimeMeasurment] == "TimeMeasurment.hour"
        ? TimeMeasurment.hour
        : map[colTimeMeasurment] == "TimeMeasurment.minute"
            ? TimeMeasurment.minute
            : TimeMeasurment.second;
    createdDateTime = DateTime.parse(map[colCreatedDateTime]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colQuesiton: question,
      colsubCatagoryId: subCatagoryId,
      colElapsedTime: elapsedTime,
      colTimeMeasurment: timeMeasurment.toString(),
      colCreatedDateTime: createdDateTime?.toIso8601String(),
      colAnswerId: answerId
    };

    if (id != null) map[colId] = id;

    return map;
  }
}

enum TimeMeasurment { minute, hour, second }
