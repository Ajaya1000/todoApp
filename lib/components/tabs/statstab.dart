import 'package:flutter/material.dart';
class StatsTab extends StatefulWidget {
  @override
  _StatsTabState createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Container(
        child: Center(
          child: Text("Stats Tab"),
        ),
      ),
    );
  }
}
