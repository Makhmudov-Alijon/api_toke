import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:api_toke/model/usermodel.dart';
import 'package:api_toke/token_store.dart';
import 'package:api_toke/ui_screens/drawer_page.dart';
import 'package:api_toke/ui_screens/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final passwordcontoller = TextEditingController();
  final namecontoller = TextEditingController();
  final emailcontoller = TextEditingController();
  final agecontoller = TextEditingController();
  final tokenStore=TokenStore();
  bool _passwordVissbl = true;
  
  Future<UserModel?> registerUser(
      var name, var email, var password, int age) async {
    var response = await http.post(
      Uri.http("api-nodejs-todolist.herokuapp.com", '/user/register'),
      body: jsonEncode(
        {
          "name": name,
          "email": email,
          "password": password,
          "age": age,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );

    var data = response.body;
    if (response.statusCode == 201) {
      var json = jsonDecode(data);
      print(json['token']);
      tokenStore.setToken(json['token']);
      return UserModel.fromJson(json['user']);
    } else {
      return null;
    }
  }
  late UserModel _userModel;

  @override
  Widget build(BuildContext context) {
    if(tokenStore.getToken()==null){
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.deepPurple[800],
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .13,
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
                        // top: MediaQuery.of(context).size.height * ,
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
                    'Register',
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
                    controller: namecontoller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      hintText: 'User Name',
                      hintStyle: GoogleFonts.pacifico(color: Colors.white,),
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
                  child: TextField(
                    controller: emailcontoller,
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
                      hintStyle: GoogleFonts.pacifico(color: Colors.white),
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
                    style: TextStyle(color: Colors.white),
                    controller: passwordcontoller,
                    obscureText: !_passwordVissbl,
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
                        hintStyle: GoogleFonts.pacifico(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        suffixIcon: IconButton(
                          color: Colors.white.withOpacity(0.7),
                          icon: Icon(_passwordVissbl
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _passwordVissbl = !_passwordVissbl;
                            });
                          },
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .03,
                    left: MediaQuery.of(context).size.height * .03,
                    right: MediaQuery.of(context).size.height * .03,
                  ),
                  child: TextField(
                    controller: agecontoller,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      hintText: 'Age',
                      hintStyle: GoogleFonts.pacifico(color: Colors.white),
                      counterStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .3,
                    top: MediaQuery.of(context).size.width * .1,
                  ),
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
                    child: Text('Register',style: GoogleFonts.pacifico(),),
                    onPressed: () async {
                      var name = namecontoller.text;
                      var email = emailcontoller.text;
                      var password = passwordcontoller.text;
                      var age = agecontoller.text;
                      UserModel? data = await registerUser(
                          name, email, password, int.tryParse(age) ?? 0);
                      setState(() {
                        _userModel = data!;
                        emailcontoller.clear();
                        passwordcontoller.clear();
                        namecontoller.clear();
                        agecontoller.clear();
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                      // box.put('Authorization', token);
                      // box.put('Authorization', 'Bearer');

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
                          'Login In ',
                          style: GoogleFonts.pacifico(
                              color: Colors.white,
                              fontSize: 17,
                              decoration: TextDecoration.underline),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }else{
      return HomeScreen();
    }


  }
}
