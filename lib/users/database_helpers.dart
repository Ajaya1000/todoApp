import 'dart:io';
//import 'package:mydairy/users/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String users = 'users';
final String username = 'username';
final String email = 'email';
final String password = 'password';
final String userId ='_id';
class User{
  String uname;
  String uemail;
  String pword;
  int id;
  User();
  User.fromMap(Map<String, dynamic> map) {
    id = map [userId];
    uname = map[username];
    uemail = map[email];
    pword = map[password];
  }
  Map<String, dynamic > toMap(){
    var map = <String, dynamic>{
      email :uemail,
        username:uname,
        password : pword
    };
    if( id != null){
      map[userId] = id;
    }
    return map;
  }
}
class DatabaseHelper{
  static final _databaseName = "UserDb.db";
  static final _databaseversion = 1;
  DatabaseHelper._pConst();
  static final DatabaseHelper instance = DatabaseHelper._pConst();
  static Database _database;

  Future<Database> get database async{
    if(_database!= null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async{
    Directory docDic = await getApplicationDocumentsDirectory();
    String path = join(docDic.path, _databaseName);
    return await openDatabase(path,version : _databaseversion, onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async{
    await db.execute(''' 
    CREATE TABLE ${users} (
    ${userId} INTEGER PRIMARY KEY,
    ${email} TEXT NOT NULL, 
    ${username} TEXT NOT NULL,
    ${password} TEXT NOT NULL
    ) ''');
  }
  Future<int> insert(User user) async{
    Database db = await database;
    int id = await db.insert(users, user.toMap());
    return id;
  }

  Future<User> queryUser(String userEmail) async{
    Database db = await database;
    List<Map> maps = await db.query(users,
        columns: [userId,email,username,password],
        where: '${email} = ?',
        whereArgs : [userEmail]
    );
    if(maps.length > 0){
      return User.fromMap(maps.first);
    }
    return null;
  }
}