import 'dart:convert';


import 'package:api_toke/model/add_task_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../token_store.dart';
import 'all_task_api.dart';
final tokenStore=TokenStore();
List<AllTaskApi> allTaskList=[];
Future<List<AllTaskApi>> allTaskApi()async {
  var response =await http.get(
    Uri.http('api-nodejs-todolist.herokuapp.com', '/task'),
    headers: {'Authorization': "Bearer " + tokenStore.getToken().toString(),
      'Content-Type': "application/json",
    },
  );

  if(response.statusCode==200){
    var data = jsonDecode(response.body.toString());
    for (Map i in data) {
      allTaskList.add(AllTaskApi.fromJson(i));

    }
    return allTaskList;
  }else{
    return allTaskList;
  }
}
