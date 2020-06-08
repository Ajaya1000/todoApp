import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mydairy/loginpages/login.dart';
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
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        brightness: Brightness.light,
        accentColor: Colors.blue[900],
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/LoginPage':(BuildContext context) => LoginPage(),
        '/SignupPage' : (BuildContext context) => SignupPage(),
        '/HomePage' : (BuildContext context) => HomePage()
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
  void navigationPage() {
    Navigator.of(context).pushReplacement(_createRoute());
  }
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => next(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  Widget next(){
      return LoginPage();
  }
  //init state

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
