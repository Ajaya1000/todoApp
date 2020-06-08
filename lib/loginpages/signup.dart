import 'package:flutter/material.dart';
import 'package:mydairy/users/database_helpers.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _sKey = GlobalKey<FormState> ();
   final emailController = TextEditingController();
   final nameController = TextEditingController();
   final pwordController = TextEditingController();

   _save() async {
     DatabaseHelper helper = DatabaseHelper.instance;
     dynamic temp = await helper.queryUser(emailController.text);
     if(temp != null){
       print(temp.uname);
       print(temp.pword);
       print(temp.uemail);
       Alert(
         context: context,
         type: AlertType.error,
         title: "Email Id Already exist",
         desc: "try providing another email id or go back to login page",
         buttons: [
           DialogButton(
             child: Text(
               "ok",
               style: TextStyle(color: Colors.white, fontSize: 20),
             ),
             onPressed: () {
               Navigator.pop(context);
             },
             width: 120,
           )
         ],
       ).show();
       return;
     }
    User user = User();
    user.uemail = emailController.text;
    user.uname = nameController.text;
    user.pword = pwordController.text;
    int id = await helper.insert(user);
     Alert(
       context: context,
       type: AlertType.success,
       title: "Account Created",
       desc: "you can now go back to login page",
       buttons: [
         DialogButton(
           child: Text(
             "Login page",
             style: TextStyle(color: Colors.white, fontSize: 20),
           ),
           onPressed: () {
             Navigator.of(context).pushReplacementNamed('/LoginPage');
           },
           width: 120,
         )
       ],
     ).show();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              FlutterLogo(
                size: 40,
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text('Create New Account',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                 fontWeight: FontWeight.bold,
                ),
                ),
              ),
              SizedBox(
                height: 130.0,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _sKey,
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
                            labelText: 'Full Name (required)',
                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'Full Name can\'t be empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                           controller: nameController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: ' E-mail (required)',

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
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',

                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return 'password cannot be empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: pwordController,
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
                                if(_sKey.currentState.validate()){
                                  _save()
                                }
                                  //_showMyDialog()

                                } ,
                                child: Text(''
                                    'Create New Account',
                                ),
                                splashColor: Colors.cyanAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ),
              )
            ],
          )
      ),
    );
  }
}
