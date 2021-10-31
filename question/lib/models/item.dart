class Item {
  int? value;
  String? subCName;
  String ?CName;
  DateTime? creatdatetime;

  Item(this.value, this.subCName,this.CName,this.creatdatetime);

Item.fromMap (Map<dynamic,dynamic> map){

  value= map['id'];
  subCName= map['subCatagoryName'];
  CName= map['catagoryName'];
  creatdatetime= DateTime.parse( map['createdDateTime']);
}
}
