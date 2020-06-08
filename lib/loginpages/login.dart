
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
//  final String title;
//  LoginPage({ this.title}) ;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
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
              size: 130,
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
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter Password',
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                      validator: (value){
                        int e,c;
                        bool flag =false;
                        e=c=-1;
                        for(int i=0;i<value.length;i++){
                          if(value[i]== '@'){
                            e=i;
                          }
                          if(value[i]== '.'){
                            c=i;
                          }
                          if(value[i]== ' '){
                            flag =true;
                            break;
                          }
                        }
                        if(value.isEmpty || flag  || e<0 || c<0 || e>c ){
                          return 'Email address format is invalid';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        ButtonTheme(
                          minWidth : 250.0,
                          height: 43,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.teal,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40.0)),),
                            onPressed: ()=>{
                              if(_formkey.currentState.validate()){
                                print(passwordController.text),
                                print(emailController.text)
                              }
                            } ,
                            child: Text(''
                                'Login',
                            ),
                            splashColor: Colors.cyanAccent,
                          ),
                        ),
                        FlatButton(
                          onPressed: () => {
                            Navigator.of(context).pushNamed('/SignupPage')
                          },child: Text('New User? Sign Up'),
                          textColor: Colors.blue,
                        ),
                      ],
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
