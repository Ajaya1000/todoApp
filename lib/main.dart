import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mydairy/loginpages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:mydairy/transitions/slideright.dart';

import 'components/homepage.dart';
import 'loginpages/signup.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
        accentColor: Colors.white,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/HomePage' : (BuildContext context) => HomePage(),
        '/LoginPage':(BuildContext context) => LoginPage(),
        '/SignupPage' : (BuildContext context) => SignupPage()

      },
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  startTime() async {
    var _duration =  Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }
 void navigationPage() async {
   // Navigator.of(context).pushReplacement(_createRoute());
   String next;
   SharedPreferences prefs = await SharedPreferences.getInstance();
   next = '/HomePage';
//   if(prefs.containsKey('logstate') && prefs.getBool('logstate')){
//       next = '/HomePage';
//   }
//   else
//    next='/LoginPage';

  await  Navigator.of(context).pushReplacementNamed(next);
  }
//  Route _createRoute() {
//    return PageRouteBuilder(
//      pageBuilder: (context, animation, secondaryAnimation) => next(),
//      transitionsBuilder: (context, animation, secondaryAnimation, child) {
//        var begin = Offset(0.0, 1.0);
//        var end = Offset.zero;
//        var curve = Curves.ease;
//
//        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//        return SlideTransition(
//          position: animation.drive(tween),
//          child: child,
//        );
//      },
//    );
//  }

  @override
  void initState(){
    _iconAnimationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    );
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.linear
    );
    _iconAnimation.addListener(()=> this.setState((){

    }));
    _iconAnimationController.forward();
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: FlutterLogo(
                size: (_iconAnimation.value)*130,
              ),
            ),
           Expanded(
             flex: 1,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 CircularProgressIndicator(
                 ),
                 Container(
                   padding: EdgeInsets.only(top: 30.0),
                   child: Text(
                     'Welcome',
                     style: TextStyle(
                       fontSize: 30,
                       fontWeight: FontWeight.bold,
                       color: Colors.blue[700],
                     ),
                   ),
                 ),
               ],
             ),
           )
          ],
        ),
      ),
    );
  }

}
