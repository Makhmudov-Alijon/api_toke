import 'dart:convert';
import 'package:http/http.dart' as http;

import '../token_store.dart';
import 'all_task_api.dart';
final tokenStore=TokenStore();
Future<AllTaskApi?> updateTask(String id) async {
  final response = await http.put(
    Uri.http('api-nodejs-todolist.herokuapp.com', '/task'+id),
    headers: {'Authorization': "Bearer " + tokenStore.getToken().toString(),
      'Content-Type': "application/json",
    },

  );

  if (response.statusCode == 200) {

    return AllTaskApi.fromJson(jsonDecode(response.body));
  } else {

    throw Exception('Failed to update album.');
  }
}