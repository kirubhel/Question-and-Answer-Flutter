class RecentExam {
  int? value;
  String? UserName;
  String? SubcatagoryName;
  int? rightAnswer;
  int? totalQuestion;
  double?estimatedTime;
  double ?takenTime;
  DateTime? creatdatetime;

  RecentExam(
      this.value,
      this.UserName,
      this.SubcatagoryName,
      this.rightAnswer,
      this.totalQuestion,
      this.estimatedTime,
      this.creatdatetime,
      this.takenTime);

  RecentExam.fromMap(Map<dynamic, dynamic> map) {
    value = map['id'];
    SubcatagoryName = map['subCatagoryName'];
    rightAnswer = map['rightAnswer'];
    totalQuestion = map['totalQuestion'];
    estimatedTime = map['elapsedTime'];
    takenTime = map['takenTime'];
    creatdatetime = DateTime.parse(map['createdDate']);
  }
}
