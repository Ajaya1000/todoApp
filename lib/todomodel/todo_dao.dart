import 'package:mydairy/todomodel/taskmodel.dart';
import 'package:sembast/sembast.dart';
import 'taskdbhelper.dart';

class TodoDao{
  static const folderName = "Todos";
  final _todofolder = intMapStoreFactory.store(folderName);
  Future<Database> get  _db  async => await TaskDatabase.instance.database;

  Future<int> insert(TodoModel todo) async{
    return await _todofolder.add(await _db, todo.toMap());
  }
  Future update(TodoModel todo) async{
    final finder = Finder(filter: Filter.byKey(todo.id));
    await _todofolder.update(await _db, todo.toMap(),finder: finder);
  }
  Future<TodoModel> findbyId(int id) async{
    final finder = Finder(filter: Filter.byKey(id));
    RecordSnapshot<int, Map<String, dynamic>> recordSnapshot = await _todofolder.findFirst(await _db,finder: finder);
    Map<String, dynamic> map =recordSnapshot.value;
    return TodoModel.fromMap(id,map);
  }
  Future<List<TodoModel>> findByDate(String day) async{
    final finder = Finder(filter: Filter.equals("day", day));
    List<RecordSnapshot<int, Map<String, dynamic>>> recordSnapshots= await _todofolder.find(await _db,finder: finder);
    return recordSnapshots.map((snapshots)=> TodoModel.fromMap(snapshots.key, snapshots.value)).toList(growable: true);
  }


  Future<List<TodoModel>> findByTag(String tag) async {
    final finder = Finder(filter: Filter.equals("tag", tag));
    List<RecordSnapshot<int, Map<String, dynamic>>> recordSnapshots = await _todofolder.find(await _db,finder: finder);
    return recordSnapshots.map((snapshots)=> TodoModel.fromMap(snapshots.key, snapshots.value)).toList(growable: true);
  }
  Future delete(int id) async{
    await _todofolder.record(id).delete(await _db);
  }
}