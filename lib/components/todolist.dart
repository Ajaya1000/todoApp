import 'package:flutter/material.dart';
import 'package:mydairy/todomodel/taskmodel.dart';
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> ToDoItems = ["hii","hello","bye"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ToDoItems.length,
        itemBuilder: (BuildContext context,int index){
        return Text(ToDoItems[index]);
        }
    );
  }
}
