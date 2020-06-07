import 'package:flutter/material.dart';
import './users/user.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
        accentColor: Colors.red ,
      ),
      home: LoginPage(title: 'Hello'),
    );
  }
}

class LoginPage extends StatefulWidget {
  final String title;
  LoginPage({ this.title}) ;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  @override
  void initState(){
    super.initState();
    _iconAnimationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    );
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.fastOutSlowIn
    );
    _iconAnimation.addListener(()=> this.setState((){

    }));
    _iconAnimationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(
              size: (_iconAnimation.value) * 130,
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: Theme(
                data: ThemeData(
//                  brightness: Brightness.da,
//                  primarySwatch: Colors.red,
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                     // gapPadding: 50,
                      borderSide: BorderSide(
                        color: Colors.indigoAccent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),

                    ),
                    focusedBorder: OutlineInputBorder(
                     // gapPadding: 50,
                      borderSide: BorderSide(
                        color: Colors.teal,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    errorBorder: OutlineInputBorder(
                      // gapPadding: 50,
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),

                    ),
                    focusedErrorBorder:OutlineInputBorder(
                        // gapPadding: 50,
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return 'Enter your Email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return 'password cannot be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      minWidth: 120.0,
                      textColor: Colors.white,
                      color: Colors.teal,
                      onPressed: ()=>{
                        if(_formkey.currentState.validate()){
                          print("Welcome")
                        }
                      } ,
                      child: Text(''
                          'Login',
                      ),
                      splashColor: Colors.cyanAccent,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
