import 'package:path_provider/path_provider.dart';
import 'package:question/models/catagoryModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:question/models/userModel.dart';


class Databasehelper {

static const _databaseName = 'Exam.db';
static const _databaseVersion = 1;

//singleton class
Databasehelper._();
static final Databasehelper instance = Databasehelper._();

Database? _database;

Future<Database> get database async{
  if (_database !=null) return _database!;

  _database = await _initDatabase();
  return _database!;

}
   _initDatabase()async {

  Directory dataDirectory =await getApplicationDocumentsDirectory();
  String dbPath = join(dataDirectory.path,_databaseName);

return await openDatabase(dbPath,version: _databaseVersion,onCreate: _onCreateDB);

}
_onCreateDB(Database db , int version )async {

  await db.execute('''
  
  CREATE TABLE ${User.tblUser}(

    ${User.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${User.colUserName} TEXT NOT NULL,
    ${User.colEmail} TEXT NOT NULL,
    ${User.colPasswrd} TEXT NOT NULL,
    ${User.colUserType} TEXT NOT NULL,
    ${User.colCreatedDateTime} DATETIME NOT NULL
    
  )
  
  
  ''');
  await db.execute('''
  
  CREATE TABLE ${Catagory.tblCatagory}(

    ${Catagory.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Catagory.colCatagoryName} TEXT NOT NULL,
 
    ${Catagory.colCreatedDateTime} DATETIME NOT NULL
    
  )
  
  
  ''');

User adminUser = User();
adminUser.userName='admin';
adminUser.password='P@ssw0rd';
adminUser.email ='admin@gmail.com';
adminUser.userType=UserType.admin;
adminUser.createdDate=DateTime.now();
  await db.insert(User.tblUser, adminUser.toMap());

}

//user 
 Future <int> insertuser (User user) async {

  Database db = await database ; 
 return await  db.insert(User.tblUser, user.toMap());

 }

  Future <int> updateUser (User user) async {

  Database db = await database ; 
 return await  db.update(User.tblUser, user.toMap(),
 where:'${User.colId}=?',
 whereArgs: [user.id] );

 }


 Future <int> deleteUser (int id) async {

  Database db = await database ; 
 return await  db.delete(User.tblUser,
 where:'${User.colId}=?',
 whereArgs: [id] );

 }

Future<List <User>> fetchUsers  () async {

Database db = await database;
List<Map> users = await db.query(User.tblUser,where: '${User.colUserType}=?',whereArgs: ["UserType.user"]);
return users.isEmpty? []:users.map((e) => User.fromMap(e)).toList();
}


Future <List<User>> userLogin (String userName , String password) async{


Database db = await database;

var user = await db.rawQuery('select * from ${User.tblUser} where (${User.colUserName}="${userName}" or ${User.colEmail}="${userName}") and ${User.colPasswrd}="${password}"');

 return user.isEmpty? []:user.map((e) => User.fromMap(e)).toList(); 
 
}

//catagory
 Future <int> insertCatagory (Catagory cat) async {

  Database db = await database ; 
 return await  db.insert(Catagory.tblCatagory, cat.toMap());

 }
 Future<List <Catagory>> fetchCatagory  () async {

Database db = await database;
List<Map> catagories = await db.query(Catagory.tblCatagory);
return catagories.isEmpty? []:catagories.map((e) => Catagory.fromMap(e)).toList();
}
}
