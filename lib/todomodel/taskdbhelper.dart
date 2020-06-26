import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class TaskDatabase{
  static final TaskDatabase _singleton = TaskDatabase._();
  TaskDatabase._();
  static TaskDatabase get instance => _singleton;

  Completer<Database> _dbOpenCompleter;

  Future<Database> get database async{
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
      return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final dbpath = join(appDocDir.path, 'TaskDb.db');
    final database= await databaseFactoryIo.openDatabase(dbpath);
    _dbOpenCompleter.complete(database);
  }

}