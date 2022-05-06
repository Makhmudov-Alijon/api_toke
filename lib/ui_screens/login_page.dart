import 'dart:convert';

import 'package:api_toke/model/login_register_mpdel.dart';
import 'package:api_toke/model/usermodel.dart';
import 'package:api_toke/token_store.dart';
import 'package:api_toke/ui_screens/drawer_page.dart';

import 'package:api_toke/ui_screens/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final passwordcontoller = TextEditingController();
  final emailcontrller = TextEditingController();
  final tokenStroge=TokenStore();
  bool _passwordVissbl = true;

  Future userlogin(LoginModel loginModel) async {
    var response = await http.post(
      Uri.http("api-nodejs-todolist.herokuapp.com", '/user/login'),
      body: jsonEncode(loginModel.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    var data = response.body;
    if (response.statusCode == 200) {
      var json = jsonDecode(data);
      print(json['token']);

      final user =UserModel.fromJson(json['user']);
      return;
    }
  }

  late LoginModel _loginModel;

  @override
  Widget build(BuildContext context) {
    if(tokenStroge.getToken()==null){
      return Scaffold(
        backgroundColor: Colors.deepPurple[800],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(
                          MediaQuery.of(context).size.aspectRatio * 100),
                      bottomLeft: Radius.circular(
                          MediaQuery.of(context).size.aspectRatio * 100),
                    )),
                child: Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * .2,
                      top: MediaQuery.of(context).size.height * .1,
                    ),
                    child: Text('To Do',style: GoogleFonts.pacifico(fontSize: 40,fontWeight: FontWeight.w900,),)
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05,
                  left: MediaQuery.of(context).size.height * .05,
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.pacifico(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .03,
                  left: MediaQuery.of(context).size.height * .03,
                  right: MediaQuery.of(context).size.height * .03,
                ),
                child: TextField(
                  controller: emailcontrller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    hintText: 'Email',
                    hintStyle: GoogleFonts.pacifico(color: Colors.white,fontSize: 20),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .03,
                  left: MediaQuery.of(context).size.height * .03,
                  right: MediaQuery.of(context).size.height * .03,
                ),
                child: TextFormField(
                  controller: passwordcontoller,
                  obscureText: !_passwordVissbl,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.white, style: BorderStyle.solid)),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      hintText: 'Password',
                      hintStyle: GoogleFonts.pacifico(color: Colors.white,fontSize: 20),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      suffixIcon: IconButton(
                        color: Colors.white.withOpacity(0.7),
                        icon: Icon(_passwordVissbl
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _passwordVissbl = !_passwordVissbl;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        },
                      )),
                ),
              ),
              Container(
                margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * .6),
                child: TextButton(
                  style: ButtonStyle(),
                  child: Text(
                    'Forgot Password ?',
                    style: GoogleFonts.pacifico(
                        color: Colors.white,
                        fontSize: 17,
                        decoration: TextDecoration.underline),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * .3),
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white))),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurple[800])),
                  child: Text('Login',style: GoogleFonts.pacifico(fontSize: 19),),
                  onPressed: () async {
                    var email = emailcontrller.text;
                    var password = passwordcontoller.text;
                    final LoginModel loginModel =
                    LoginModel(email: email, password: password);
                    await userlogin(loginModel);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  },
                ),
              ),

              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .20,
                      top: MediaQuery.of(context).size.width * .02,
                    ),
                    child: Text(
                      "Don't have an account ?",
                      style:GoogleFonts.pacifico (color: Colors.grey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .01,
                      top: MediaQuery.of(context).size.width * .01,
                    ),
                    child: TextButton(
                      style: ButtonStyle(),
                      child: Text(
                        'Register',
                        style: GoogleFonts.pacifico(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }else{
      return HomeScreen();
    }
  }
}
