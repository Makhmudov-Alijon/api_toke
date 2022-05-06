import 'dart:convert';


import 'package:api_toke/ui_screens/login_page.dart';
import 'package:api_toke/ui_screens/profil_page.dart';
import 'package:api_toke/ui_screens/register_page.dart';
import 'package:flutter/material.dart';
import "package:flutter_advanced_drawer/flutter_advanced_drawer.dart";
import 'package:google_fonts/google_fonts.dart';

import '../model/add_task.dart';
import '../model/add_task_api.dart';
import '../model/all_task_api.dart';
import '../model/put_eddit.dart';
import '../model/user_token.dart';
import 'package:http/http.dart' as http;

import '../token_store.dart';
import 'all_task_page.dart';




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tokenStore = TokenStore();

  Future<UserToken> userToken() async {
    var response = await http.get(
      Uri.http('api-nodejs-todolist.herokuapp.com', '/user/me'),
      headers: {'Authorization': "Bearer " + tokenStore.getToken().toString()},
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return UserToken.fromJson(data);
    } else {
      throw Exception('eror');
    }
  }

  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController taskController = TextEditingController();
  Future<AddTaskApi>? _futuretask;
  late Future<AllTaskApi?> _futureEdit;

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 700),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(

        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),

      child: Scaffold(
        backgroundColor: Colors.deepPurple[800],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
          onPressed: () async {
            // final dynamic description=taskController.text;
            // final Future<AddTaskApi> task= addTaskApi(description);
            setState(() {
              // _task=task as AddTaskApi;
              _futuretask = addTaskApi(taskController.text);
              taskController.clear();
            });
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

          centerTitle: true,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                    color: Colors.black,
                  ),
                );
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .1,
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
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * .03,
                  left: MediaQuery
                      .of(context)
                      .size
                      .height * .03,
                  right: MediaQuery
                      .of(context)
                      .size
                      .height * .03,
                ),
                child: TextField(
                  controller: taskController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    hintText: 'add task',
                    hintStyle: GoogleFonts.pacifico(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),

              FutureBuilder<AddTaskApi>(
                future: _futuretask,
                builder: (context, snapshot) {
                  return ListTile(
                    title: Container(

                      child: Text(snapshot.data?.data.description?? '',
                        style: TextStyle(color: Colors.white),),

                    ),
                    trailing: Container(
                      child: IconButton(
                        icon: Icon(Icons.edit,),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            _futureEdit = updateTask(taskController.text =
                                snapshot.data?.data.description ?? '');
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              // FutureBuilder(
              //   future: fetchTask(),
              //   builder: (context,AsyncSnapshot<AllTaskApi?> snapshot) {
              //     return ListView.builder(
              //       itemCount: snapshot.data?.count,
              //       itemBuilder: (context, index) {
              //         return Text(snapshot.data?.data?.elementAt(index).description ?? '');
              //       });
              //
              //   },
              // ),


              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * .515,
                  left: MediaQuery
                      .of(context)
                      .size
                      .width * .6,
                ),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .06,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .3,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white))),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurple[800])),
                  child: Text('all task'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllTaskPage()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,

                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'images/2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                FutureBuilder(
                    future: userToken(),
                    builder: (context, AsyncSnapshot<UserToken> snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [

                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: Text(
                                      snapshot.data?.email.toString() ?? '',
                                      style: TextStyle(color: Colors.white)))
                            ],
                          ),
                        ],
                      );
                    }),

                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilPage()));
                  },
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),

                Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white))),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurple[800])),
                  child: Text('Logout'),
                  onPressed: (){
                    setState(() {
                      tokenStore.deleteToken();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                    });
                  },
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

}