import 'dart:async';
import 'dart:convert';

import 'package:api_toke/model/put_eddit.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/all_task_api.dart';
import '../token_store.dart';
import 'drawer_page.dart';

final tokenStore=TokenStore();

Future<AllTaskApi?> fetchTask() async {
  final response = await http
      .get(Uri.http('api-nodejs-todolist.herokuapp.com', '/task'),
    headers: {'Authorization': "Bearer " + tokenStore.getToken().toString(),
      'Content-Type': "application/json",
    },
  );
  if (response.statusCode == 200) {
    return AllTaskApi.fromJson(jsonDecode(response.body));
  } else {
  }
}
Future<AllTaskApi?> deleteTask(String id) async {
  final  responsen = await http.delete(Uri.http('api-nodejs-todolist.herokuapp.com', '/task/'+id),
    headers: {'Authorization': "Bearer " + tokenStore.getToken().toString(),
      'Content-Type': "application/json",
    },
  );

  if (responsen.statusCode == 200) {

    return AllTaskApi.fromJson(jsonDecode(responsen.body));
  } else {

    return null;
  }
}
class AllTaskPage extends StatefulWidget {
  const AllTaskPage({Key? key}) : super(key: key);

  @override
  _AllTaskPageState createState() => _AllTaskPageState();
}
class _AllTaskPageState extends State<AllTaskPage> {
   late Future<AllTaskApi?> _futureTask;
   late Future<AllTaskApi?> _futureEdit;
   TextEditingController taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.deepPurple[800],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          elevation: 0,
          title: const Text('All Task'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: fetchTask(),
            builder: (context,AsyncSnapshot<AllTaskApi?> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();

              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.count,
                    itemBuilder: (context, index){
                      // return Text(snapshot.data?.data?.elementAt(index).description ?? '');
                      return  Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .03,
                            left: MediaQuery.of(context).size.width * .03,
                            right: MediaQuery.of(context).size.width * .03,
                          ),
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width * .7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.deepPurple),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListTile(
                                    title: Text('name : ${snapshot.data!.data!.elementAt(index).description.toString()}'
                                      ,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  subtitle: Text('data : ${snapshot.data!.data!.elementAt(index).createdAt}' , style: TextStyle(color: Colors.white),),
                                  trailing:  Container(
                                    child: IconButton(
                                      icon:Icon(Icons.delete,),
                                      color: Colors.white,
                                      onPressed: (){
                                        setState(() {
                                          _futureTask=deleteTask(snapshot.data?.data?.elementAt(index).id ?? '') as Future<AllTaskApi?>;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: IconButton(
                                        icon:Icon(Icons.delete,),
                                        color: Colors.white,
                                        onPressed: (){
                                          setState(() {
                                            _futureTask=deleteTask(snapshot.data?.data?.elementAt(index).id ?? '') as Future<AllTaskApi?>;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        icon:Icon(Icons.edit,),
                                        color: Colors.white,
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                          setState(() {
                                            _futureEdit=updateTask(taskController.text=snapshot.data?.data?.elementAt(index).description ?? '');
                                          });

                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                    });
              }

            },
          ),
        ),
      ),
    );
  }
}