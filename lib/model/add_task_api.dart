// To parse this JSON data, do
//
//     final addTaskApi = addTaskApiFromJson(jsonString);

import 'dart:convert';

AddTaskApi addTaskApiFromJson(String str) => AddTaskApi.fromJson(json.decode(str));

String addTaskApiToJson(AddTaskApi data) => json.encode(data.toJson());

class AddTaskApi {
  AddTaskApi({
     this.success,
    required this.data,
  });

  bool? success;
  Data data;

  factory AddTaskApi.fromJson(Map<String, dynamic> json) => AddTaskApi(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.completed,
    this.id,
   required this.description,
    this.owner,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  bool? completed;
  String? id;
  String description;
  String? owner;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    completed: json["completed"],
    id: json["_id"],
    description: json["description"],
    owner: json["owner"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "completed": completed,
    "_id": id,
    "description": description,
    "owner": owner,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
