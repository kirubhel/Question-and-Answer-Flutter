class SubCatagory {

static const tblSubCatagory = 'Subcatagory';
static const colId = 'id';
static const colSubCatagoryName = 'subCatagoryName';
static const colCatagoryId = 'catagoryId';
static const colCreatedDateTime = 'createdDateTime';


int ?id ;
String ?subCatagoryName ; 
int?catagoryId;
DateTime? createdDateTime;

SubCatagory(this.id,this.subCatagoryName,this.catagoryId,this.createdDateTime);


SubCatagory.fromMap (Map<dynamic,dynamic> map){

  id= map[colId];
  subCatagoryName= map[colSubCatagoryName];
  catagoryId= map [colCatagoryId];
  createdDateTime= DateTime.parse( map[colCreatedDateTime]);
}


Map <String ,dynamic> toMap () {


  var map= <String ,dynamic> {colSubCatagoryName:subCatagoryName,colCatagoryId:catagoryId,colCreatedDateTime:createdDateTime?.toIso8601String()};

  if (id!=null)
  map[colId]=id;

  return map;
}





}