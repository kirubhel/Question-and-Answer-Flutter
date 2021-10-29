class User {

static const tblUser = 'user';

static const colId = 'id';
static const colUserName = 'userName';
static const colEmail = 'email';
static const colPasswrd = 'password';
static const colUserType = 'userType';

static const colCreatedDateTime = 'createdDate';

User({this.id,this.userName,this.email,this.password,this.userType});


  int? id ; 
  String ? userName ;
  String ? email ;
  String ? password ;
  UserType ? userType ;
 
  DateTime ? createdDate;


  User.fromMap (Map<dynamic,dynamic> map){

  id= map[colId];
  userName= map[colUserName];
  email= map[colEmail];
  password=map[colPasswrd];

  userType=  map[colUserType] =="UserType.user"?UserType.user:UserType.admin ;
  createdDate= DateTime.parse( map[colCreatedDateTime]);
}


Map <String ,dynamic> toMap () {


  var map= <String ,dynamic> {colUserName:userName,colEmail:email,colPasswrd:password,colUserType:userType.toString(),colCreatedDateTime:createdDate?.toIso8601String()};

  if (id!=null)
  map[colId]=id;

  return map;
}

}
enum UserType {user,admin}