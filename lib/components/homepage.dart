import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydairy/components/tabs/hometab.dart';
import 'package:mydairy/components/tabs/menutab.dart';
import 'package:mydairy/components/tabs/settingtab.dart';
import 'package:mydairy/components/tabs/statstab.dart';
import 'package:mydairy/components/todolist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
//   String uName;
//   String uEmail;
//
//   _getPref() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    print('pref object is ${prefs}');
//    setState(() {
//      uName = prefs.getString('username');
//      uEmail = prefs.getString('useremail');
//    });
//  }
//  @override
//  void initState() {
//    super.initState();
//    _getPref();
//    print('called initstate');
//  }
  List<Widget> pages=[
    HomeTab(),
    MenuTab(),
    StatsTab(),
    SettingTab()
  ];
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true
  );
  int currentIndex =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.black,
      body: PageView(
        controller: pageController,
        onPageChanged: (index){
          setState(() {
            currentIndex=index;
          });
        },
        children: pages,
      ),


      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        backgroundColor: Colors.black,
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[700],
        type: BottomNavigationBarType.fixed,
        
        onTap: (int index) {
          setState(() {
            pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
//            currentIndex=index;
          });
        },
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              "Home Tab"
            )
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              title: Text(
                  "Menu Tab"
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.assessment),
              title: Text(
                  "Stats Tab"
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(
                  "Setting Tab"
              )
          ),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: (){
//
//        },
//      ),
    );
  }
}
