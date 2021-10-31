class Choise {



static const tblChoice = 'Choise';

static const colId = 'id';

static const colQuestionId = 'questionId';
static const colChoise = 'choise';
static const colCreatedDateTime = 'createdDate';

Choise();

int? id ; 

int ? questionId ;
String ? choise ;
DateTime ? createdDate;


  Choise.fromMap (Map<dynamic,dynamic> map){

  id= map[colId];

  questionId= map[colQuestionId];
  choise=map[colChoise];

  createdDate= DateTime.parse( map[colCreatedDateTime]);
}
Map <String ,dynamic> toMap () {


  var map= <String ,dynamic> {colQuestionId:questionId,colChoise:choise ,colCreatedDateTime:createdDate?.toIso8601String()};

  if (id!=null)
  map[colId]=id;

  return map;
}



}