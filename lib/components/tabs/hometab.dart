import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mydairy/todomodel/taskmodel.dart';
import 'package:mydairy/todomodel/todo_dao.dart';
class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final dFormat = DateFormat("yyyy-MM-dd");
//  final tFormat = DateFormat("HH:mm");
  DateTime pickedDate=DateTime.now();
  int pickedTime=0;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController descController = TextEditingController();

  String dropDownValue = "today";
  var todos= [];
  final todo_dao = TodoDao();
  @override

  _initiate() async{
    print("_initiate called");
    String day;
    var today= DateTime.now();
    if(dropDownValue=="today"){
      day= dFormat.format(today);
    }
    else if(dropDownValue == "tomorrow"){
      day=dFormat.format(today.add(Duration(days: 1)));
    }
    else{
      day=dFormat.format(today.subtract(Duration(days: 1)));
    }
//    if(todos!=null)
//      todos.clear();
    var temp = await todo_dao.findByDate(day);
    print(temp.length);
    temp.forEach((element){
      print(" id is ${element.id}");
      print("tag is ${element.tag}");
      print("desc is ${element.desc}");
    });
    print(temp.length);
    setState(() {
      todos=temp;
    });
  }
  void initState() {

    super.initState();
    print("initSTate called");
    _initiate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton(
          value: dropDownValue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 35,
          elevation: 16,
          underline: Container(
            height: 0,
          ),
          onChanged: (nv) {
              dropDownValue = nv;
              _initiate();
          },
          items: ["yesterday", "today", "tomorrow"].map((value) =>
              DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              )).toList(),
        ),
      ),
      body: (todos==null)?Center(child: Text("Nothing To Show"),):
          ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: todos.length,
            itemBuilder: (BuildContext context,int index){
              print("Inside build context");
              var item = todos[index];
              print(item.tag);
              return TodoItem(item : item);
            },
            separatorBuilder: (BuildContext context,int index) => Divider(),
          )
      ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addTodo();
        },
        elevation: 50,
      ),
    );
  }
  _pickdate() async{
    DateTime date= await showDatePicker(
        context: context,

        firstDate: DateTime
            .now(),
        lastDate: DateTime(
            2100),
        initialDate: DateTime
        .now()
    );
    if(date !=null)
      setState(() {
        pickedDate = DateTime.parse(dFormat.format(date));
        dateController.text=dFormat.format(date);
      });
  }
  Future<Widget> addTodo() {
    final _formkey = GlobalKey<FormState>();
    return (
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text('To Do'),
                  content: SingleChildScrollView(
                      child: ListBody(
                          children: <Widget>[
                            Container(
                                child: Form(

                                    key: _formkey,
                                    child: Theme(
                                        data: ThemeData(
                                            inputDecorationTheme: InputDecorationTheme(
//                                              filled: true,
//                                              fillColor: Colors.greenAccent,
                                              labelStyle: TextStyle(
                                                    color: Colors.grey
                                                    ),
                                              enabledBorder: OutlineInputBorder(
                                                // gapPadding: 50,
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius
                                                        .circular(20)),

                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                // gapPadding: 50,
                                                borderSide: BorderSide(
                                                  color: Colors.teal,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius
                                                        .circular(20)),
                                              ),
                                            )
                                        ),
                                        child: Column(
                                          children: <Widget>[

                                            Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 6,
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                        color: Colors.grey[300]
                                                      ),
                                                      keyboardType: TextInputType
                                                          .text,
                                                      controller: tagController,
                                                      decoration: InputDecoration(
                                                          labelText: "tag"
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 12,
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          color: Colors.grey[300]
                                                      ),
                                                      keyboardType: TextInputType.datetime,
                                                      controller: dateController,
                                                      decoration: InputDecoration(
                                                        labelText: "date"
                                                      ),
                                                      onTap: _pickdate,
                                                      //controller: dateController,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 6,
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          color: Colors.grey[300]
                                                      ),
                                                      keyboardType: TextInputType
                                                          .number,
                                                      controller: timeController,
                                                      decoration: InputDecoration(
                                                          labelText: "hours"
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              style: TextStyle(
                                                  color: Colors.grey[300]
                                              ),
                                              controller: descController,
                                              keyboardType: TextInputType.text,
                                              maxLines: null,
                                            ),
                                          ],
                                        )
                                    )
                                )
                            )
                          ]
                      )
                  ),
                actions: <Widget>[
                  OutlineButton(
                    onPressed: (){
                        _add();
                        Navigator.pop(context);
                    },
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
//                        side: BorderSide(color: Colors.red)
                    ),
                    child: Container(
                      decoration:BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey[800],
                            Colors.grey[700]
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ) ,
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
                      child: Text("Ok",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  OutlineButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
//                        side: BorderSide(color: Colors.red)
                    ),
                    child: Container(
                      decoration:BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey[800],
                              Colors.grey[700]
                            ],
                          ),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ) ,
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Cancel",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ),

                ],
              );
            }
        )
    );
  }
  _add() async{
    TodoModel temp_todo = TodoModel(tag: tagController.text,time: int.parse(timeController.text),desc: descController.text,day: dateController.text);
   int k = await todo_dao.insert(temp_todo);
   temp_todo.id = k;
   _initiate();
  }
}

class TodoItem extends StatefulWidget {
  final TodoModel item;
  TodoItem({this.item});
  @override
  _TodoItemState createState() => _TodoItemState(item : this.item);
//  {
//    print("inside todo");
////    print(item.tag);
//
//  }
}

class _TodoItemState extends State<TodoItem> {
   final TodoModel item;
  _TodoItemState({this.item});
  final _todo_dao = TodoDao();
  double satisfiction=0.0;
  bool checked=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checked=item.isCompleted;
  }
  @override
  Widget build(BuildContext context) {
    print("inside todo builder");
    print(item.tag);
    return (item==null)?Container(child: Text("null"),):Card(
      child: ListTile(
        key: Key(item.id.toString()),
      onTap: (){
        print("tapped");
        return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('AlertDialog Title'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Alert'),
                    Text('Would you like to delete this to do?'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('ok'),
                  onPressed: () {
                    _todo_dao.delete(item.id);
                    setState(() {

                    });
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
        }
        );
      },
        leading: Checkbox(
          value: (checked==null)?false:checked,
          onChanged: (new_value){
            setState(() {
              checked = new_value;
            });
          },
        ),
        title: Row(
          children: <Widget>[
            Text(item.tag),
            SizedBox(
              width: 20,
            ),
            Text(item.day),
            SizedBox(
              width: 20,
            ),
            Text("${item.time} hrs")
          ],
        ),
      ),
    );
  }
}
