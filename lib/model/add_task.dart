import 'dart:convert';

import 'package:api_toke/model/all_task.dart';
import 'package:api_toke/model/add_task_api.dart';
import 'package:http/http.dart' as http;

import '../token_store.dart';
final tokenStore=TokenStore();
Future<AddTaskApi> addTaskApi(dynamic description)async {

  var responsen =await http.post(
    Uri.http('api-nodejs-todolist.herokuapp.com', '/task'),
    body: jsonEncode(
        {
          "description" :description
        }
    ),
    headers: {'Authorization': "Bearer " + tokenStore.getToken().toString(), 'Content-Type': "application/json",
    },
  );

  if (responsen.statusCode == 201) {
    return AddTaskApi.fromJson(jsonDecode(responsen.body));
  }
    throw Exception('Failed to create album.');
  }
