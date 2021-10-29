class Answer {



static const tblUser = 'Answer';

static const colId = 'id';
static const colUserId = 'userId';
static const colQuestionId = 'questionId';
static const colChoiseId = 'choiseId';
static const colCreatedDateTime = 'createdDate';

Answer(this.userId,this.questionId,this.choiseId);

int? id ; 
int ? userId ;
int ? questionId ;
int ? choiseId ;
DateTime ? createdDate;


  Answer.fromMap (Map<dynamic,dynamic> map){

  id= map[colId];
  userId= map[colUserId];
  questionId= map[colQuestionId];
  choiseId=map[colChoiseId];

  createdDate= DateTime.parse( map[colCreatedDateTime]);
}
Map <String ,dynamic> toMap () {


  var map= <String ,dynamic> {colUserId:userId,colQuestionId:questionId,colChoiseId:choiseId,colCreatedDateTime:createdDate?.toIso8601String()};

  if (id!=null)
  map[colId]=id;

  return map;
}



}