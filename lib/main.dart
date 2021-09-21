import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session/flutter_session.dart';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Api.dart';
import 'Dashboard.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    dynamic token = FlutterSession().get('token');
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

class _LoginPageState extends State<LoginPage> {
  final companyidController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String message = '';
  bool isLoggedIn = false;
  String companyid = '';
  @override
  void dispose() {
    companyidController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String companyid = prefs.getString('companyid');

    if (companyid != null) {
      setState(() {
        isLoggedIn = true;
        companyid = companyid;
      });
      return;
    }
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('companyid', null);

    setState(() {
      companyid = '';
      isLoggedIn = false;
    });
  }

  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailController.text);
    prefs.setString('companyid', companyidController.text);
    prefs.setString('password', passwordController.text);
    setState(() {
      companyid = companyidController.text;
      isLoggedIn = true;
    });

    companyidController.clear();
  }

  bool _securetext = true;
  @override
  Widget build(BuildContext context) {
      return WillPopScope(
          onWillPop: (){
            //user press back navigation button
            moveToLastScreen();
          },
        child:Scaffold(
        body:SingleChildScrollView(
          child:Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 100,),
                    // Image(
                    //   image: AssetImage('assets/info5cloud.jpg'),
                    //   width: 160,
                    //   height: 160,
                    // ),
                    Text("ECS",
                      style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.bold),
                    ),
                    Text('Welcome to ECS',
                      style:TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(350)
              ),
                color: Color(0xff0277bd),
              ),
            ),
            // Expanded(
            SizedBox(height: 50,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Login",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text("Login to your account",
                      style: TextStyle(
                          fontSize: 15,
                          color:Colors.grey[700]),)
                  ],
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: TextField(
                          controller: companyidController,
                          decoration: InputDecoration(
                              hintText: 'enter company id',
                              hintStyle: TextStyle(color: Colors.black12),
                              labelText: 'Company_id',
                              labelStyle: TextStyle(color: Colors.blueGrey,fontSize: 20),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                              prefixIcon: Icon(Icons.security,color:Colors.grey)),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'enter Email id',
                            hintStyle: TextStyle(color: Colors.black12),
                            labelText: 'UserName',
                            labelStyle: TextStyle(color: Colors.blueGrey,fontSize: 20),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(Icons.mail,color:Colors.grey)),
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 50,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: _securetext,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.black12),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.blueGrey,fontSize: 20),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          prefixIcon: Icon(Icons.lock,color:Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(_securetext
                                ? Icons.visibility_off
                                : Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                _securetext = !_securetext;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Padding(padding:
                EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration:
                    BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )
                    ),
                    child: MaterialButton(
                      minWidth: 250,
                      height: 50,

                      onPressed: () async {
                        var company_id = companyidController.text;
                        var email = emailController.text;
                        var password = passwordController.text;
                        var rsp = await loginuser(company_id,email, password);
                        if (rsp.containsKey('success') == true) {
                          print(rsp);
                          if (rsp['success'] == true) {
                            await FlutterSession().set('token', rsp['data']['token']);
                            Fluttertoast.showToast(
                                msg: "Login Successful",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.white,
                                textColor: Colors.green,
                                fontSize: 16.0
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardPage()));
                          }

                          else {
                            Fluttertoast.showToast(
                                msg: "Login Failed.",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 10,
                                backgroundColor: Colors.white,
                                textColor: Colors.red,
                                fontSize: 20.0
                            );
                          }
                        }
                      },

                      color: Color(0xff0277bd),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Login", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50,),
              ],
            )
          ],
        ),
      ),
    )
    );
  }
  void moveToLastScreen() {
    Navigator.pop(context);
  }
}