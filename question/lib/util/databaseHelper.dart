import 'package:path_provider/path_provider.dart';
import 'package:question/models/answerModel.dart';
import 'package:question/models/catagoryModel.dart';
import 'package:question/models/choicesModel.dart';
import 'package:question/models/item.dart';
import 'package:question/models/questionModel.dart';
import 'package:question/models/subCatagoryModel.dart';
import 'package:question/models/userAnswer.dart';
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

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);

    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
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
    await db.execute('''
  
  CREATE TABLE ${SubCatagory.tblSubCatagory}(

    ${SubCatagory.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${SubCatagory.colSubCatagoryName} TEXT NOT NULL,
    ${SubCatagory.colCatagoryId} INTEGER NOT NULL,
    ${SubCatagory.colCreatedDateTime} DATETIME NOT NULL
    
  )
  
  
  ''');

      await db.execute('''
  
  CREATE TABLE ${Question.tblQuestion}(

    ${Question.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Question.colQuesiton} TEXT NOT NULL,
    ${Question.colsubCatagoryId} INTEGER NOT NULL,
    ${Question.colElapsedTime} INTEGER NOT NULL,
    ${Question.colTimeMeasurment} TEXT NOT NULL,
    ${Question.colAnswerId} INTEGER DEFAULT NULL,
    ${Question.colCreatedDateTime} DATETIME NOT NULL
    
  )
  
  
  ''');
   await db.execute('''
  
  CREATE TABLE ${Choise.tblChoice}(

    ${Choise.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Choise.colChoise} TEXT NOT NULL,
    ${Choise.colQuestionId} INTEGER NOT NULL,

    ${Choise.colCreatedDateTime} DATETIME NOT NULL
    
  )
  
  
  ''');

  await db.execute('''
  
  CREATE TABLE ${UserAnswer.tblUserAnswer}(

    ${UserAnswer.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
  
    ${UserAnswer.colUserId} INTEGER NOT NULL,
    ${UserAnswer.colsubCatagoryId} INTEGER NOT NULL,
    ${UserAnswer.colrightAnswer} INTEGER NOT NULL,
    ${UserAnswer.coltotalQuestion} INTEGER NOT NULL,
    ${UserAnswer.colelapsedTime} REAL NOT NULL,
    ${UserAnswer.coltakenTime} REAL NOT NULL,
    
    ${UserAnswer.colCreatedDateTime} DATETIME NOT NULL
    
  )
  
  
  ''');


    User adminUser = User();
    adminUser.userName = 'admin';
    adminUser.password = 'P@ssw0rd';
    adminUser.email = 'admin@gmail.com';
    adminUser.userType = UserType.admin;
    adminUser.createdDate = DateTime.now();
    await db.insert(User.tblUser, adminUser.toMap());
  }

//user
  Future<int> insertuser(User user) async {
    Database db = await database;
    return await db.insert(User.tblUser, user.toMap());
  }

  Future<int> updateUser(User user) async {
    Database db = await database;
    return await db.update(User.tblUser, user.toMap(),
        where: '${User.colId}=?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db
        .delete(User.tblUser, where: '${User.colId}=?', whereArgs: [id]);
  }

  Future<List<User>> fetchUsers() async {
    Database db = await database;
    List<Map> users = await db.query(User.tblUser,
        where: '${User.colUserType}=?', whereArgs: ["UserType.user"]);
    return users.isEmpty ? [] : users.map((e) => User.fromMap(e)).toList();
  }

  Future<List<User>> userLogin(String userName, String password) async {
    Database db = await database;

    var user = await db.rawQuery(
        'select * from ${User.tblUser} where (${User.colUserName}="${userName}" or ${User.colEmail}="${userName}") and ${User.colPasswrd}="${password}"');

    return user.isEmpty ? [] : user.map((e) => User.fromMap(e)).toList();
  }

//catagory
  Future<int> insertCatagory(Catagory cat) async {
    Database db = await database;
    return await db.insert(Catagory.tblCatagory, cat.toMap());
  }

  Future<int> deleteCatagory(int id) async {
    Database db = await database;
    return await db.delete(Catagory.tblCatagory,
        where: '${Catagory.colId}=?', whereArgs: [id]);
  }

  Future<List<Catagory>> fetchCatagory() async {
    Database db = await database;
    List<Map> catagories = await db.query(Catagory.tblCatagory);
    return catagories.isEmpty
        ? []
        : catagories.map((e) => Catagory.fromMap(e)).toList();
  }

//subcatagory

  Future<int> insertSubCatagory(SubCatagory subCat) async {
    Database db = await database;
    return await db.insert(SubCatagory.tblSubCatagory, subCat.toMap());
  }

  Future<int> deleteSubCatagory(int id) async {
    Database db = await database;
    return await db.delete(SubCatagory.tblSubCatagory,
        where: '${SubCatagory.colId}=?', whereArgs: [id]);
  }

  Future<List<Item>> fetchSubCatagory() async {
    String subcatagoryid =
        "${SubCatagory.tblSubCatagory}" + "." + "${SubCatagory.colId}";
    String subcatagoryname = "${SubCatagory.tblSubCatagory}" +
        "." +
        "${SubCatagory.colSubCatagoryName}";
    String subcatagoryDate = "${SubCatagory.tblSubCatagory}" +
        "." +
        "${SubCatagory.colCreatedDateTime}";
    String subcatagoryId =
        "${SubCatagory.tblSubCatagory}" + "." + "${SubCatagory.colCatagoryId}";
    String scatagoryid = "${Catagory.tblCatagory}" + "." + "${Catagory.colId}";
    String scatagoryname =
        "${Catagory.tblCatagory}" + "." + "${Catagory.colCatagoryName}";

    String query =
        // ignore: unnecessary_brace_in_string_interps
        'SELECT ${subcatagoryid}, ${subcatagoryname}, ${subcatagoryDate}, ${scatagoryname} FROM ${SubCatagory.tblSubCatagory} INNER JOIN ${Catagory.tblCatagory} ON  ${scatagoryid} = ${subcatagoryId} ';
    List<Item> list = [];
    Database db = await database;
    List<Map> subCatagories2 = await db.query(SubCatagory.tblSubCatagory);
    List<Map<String, dynamic>> dbListsubCatagories = await db.rawQuery('${query}');

    dbListsubCatagories.forEach((itemMap) {
      list.add(Item.fromMap(itemMap));
    });

    return list;
  }
 Future<List<SubCatagory>> fetchSCatagory() async {
    Database db = await database;
    List<Map> subcat = await db.query(SubCatagory.tblSubCatagory);
    return subcat.isEmpty
        ? []
        : subcat.map((e) => SubCatagory.fromMap(e)).toList();
  }

//question
  Future<int> insertQuestion(Question q) async {
    Database db = await database;
    return await db.insert(Question.tblQuestion, q.toMap());
  }
   Future<int> updateQuestion(int id, int answerID) async {
    Database db = await database;
    return await db.update(Question.tblQuestion,{ Question.colAnswerId:answerID},
    where: '${Question.colId} = ?',
        whereArgs: [id]);
  }

  Future<int> deleteQuestion(int id) async {
    Database db = await database;
    return await db.delete(Question.tblQuestion,
        where: '${Question.colId}=?', whereArgs: [id]);
  }
    Future<List<Question>> fetchQuestion() async {
    Database db = await database;
    List<Map> questions = await db.query(Question.tblQuestion);
    return questions.isEmpty
        ? []
        : questions.map((e) => Question.fromMap(e)).toList();
  }
//choices
  Future<int> insertChoise(Choise ch) async {
    Database db = await database;
    return await db.insert(Choise.tblChoice, ch.toMap());
  }

  Future<int> deleteChoise(int id) async {
    Database db = await database;
    return await db.delete(Choise.tblChoice,
        where: '${Choise.colId}=?', whereArgs: [id]);
  }
    Future<List<Choise>> fetchChoise() async {
    Database db = await database;
    List<Map> choices = await db.query(Choise.tblChoice);
    return choices.isEmpty
        ? []
        : choices.map((e) => Choise.fromMap(e)).toList();
  }

//user answer
Future<int> insertUserAnswer(UserAnswer UA) async {
    Database db = await database;
    return await db.insert(UserAnswer.tblUserAnswer, UA.toMap());
  }
  Future<List<UserAnswer>> fetchUserAnser() async {
    Database db = await database;
    List<Map> userAnswers = await db.query(UserAnswer.tblUserAnswer);
    return userAnswers.isEmpty
        ? []
        : userAnswers.map((e) => UserAnswer.fromMap(e)).toList();
  }

}
