class UserAnswer {
  static const tblUserAnswer = 'UserAnswer';

  static const colId = 'id';
  static const colUserId = 'userId';
  static const colsubCatagoryId = 'subCatagoryId';
  static const colrightAnswer = 'rightAnswer';
  static const coltotalQuestion = 'totalQuestion';
  static const colelapsedTime = 'elapsedTime';
  static const coltakenTime = 'takenTime';
  static const colCreatedDateTime = 'createdDate';

  int? id;
  int? userId;
  int? subCatagoryId;
  int? rightAnswer;
  int? totalQuestion;
  double? elapsedTime;
  double? takenTime;
  DateTime? createdDate;

  UserAnswer();
  UserAnswer.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    userId = map[colUserId];
    subCatagoryId = map[colsubCatagoryId];
    rightAnswer = map[colrightAnswer];
    totalQuestion = map[coltotalQuestion];
    elapsedTime = map[colelapsedTime];
    takenTime = map[coltakenTime];
    createdDate = DateTime.parse(map[colCreatedDateTime]);
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colUserId: userId,
      colsubCatagoryId: subCatagoryId,
      colrightAnswer: rightAnswer,
      coltotalQuestion: totalQuestion,
      colelapsedTime: elapsedTime,
      coltakenTime: takenTime,
      colCreatedDateTime: createdDate?.toIso8601String()
    };

    if (id != null) map[colId] = id;

    return map;
  }
}
