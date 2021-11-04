class RecentExam {
  int? value;
  int ?userId;
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
    userId=map['userId'];
    UserName= map['userName'];
    SubcatagoryName = map['subCatagoryName'];
    rightAnswer = map['rightAnswer'];
    totalQuestion = map['totalQuestion'];
    estimatedTime = map['elapsedTime'];
    takenTime = map['takenTime'];
    creatdatetime = map['createdDate']!=null? DateTime.parse(map['createdDate']):DateTime.now();
  }
}
