class Catagory {

static const tblCatagory = 'catagory';
static const colId = 'id';
static const colCatagoryName = 'catagoryName';
static const colCreatedDateTime = 'createdDateTime';


int ?id ;
String ?catagoryName ; 
DateTime? createdDateTime;

Catagory(this.id,this.catagoryName,this.createdDateTime);


Catagory.fromMap (Map<dynamic,dynamic> map){

  id= map[colId];
  catagoryName= map[colCatagoryName];
  createdDateTime= DateTime.parse( map[colCreatedDateTime]);
}


Map <String ,dynamic> toMap () {


  var map= <String ,dynamic> {colCatagoryName:catagoryName,colCreatedDateTime:createdDateTime?.toIso8601String()};

  if (id!=null)
  map[colId]=id;

  return map;
}





}