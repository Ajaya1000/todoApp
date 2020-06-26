class TodoModel{
  int id;
  String tag;
  int time;
  String desc;
  String day;
  bool isCompleted;
  int satisfiction;
  TodoModel({this.id,this.tag,this.time,this.desc,this.day,this.isCompleted,this.satisfiction});

 factory TodoModel.fromMap(int id,Map<String,dynamic> map) => TodoModel(
    id : id,
    tag:map["tag"],
    time:map["time"],
    desc:map["desc"],
   day: map ["day"],
   isCompleted: map["isCompleted"],
   satisfiction: map["satisfiction"]
  );
  Map<String,dynamic> toMap() => {
    "tag" : tag,
    "time" :time,
    "desc" :desc,
    "day" : day,
    "isCompleted" : isCompleted,
    "satisfiction" : satisfiction
  };
}