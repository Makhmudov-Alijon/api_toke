/// count : 1
/// data : [{"completed":false,"_id":"6223de5fcfbac800179e1c2c","description":"reading book","owner":"6223de4bcfbac800179e1c2a","createdAt":"2022-03-05T22:04:15.494Z","updatedAt":"2022-03-05T22:04:15.494Z","__v":0},null]

class AllTaskApi {
  AllTaskApi({
      int? count, 
      List<Data>? data,}){
    _count = count;
    _data = data;
}

  AllTaskApi.fromJson(dynamic json) {
    _count = json['count'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _count;
  List<Data>? _data;

  int? get count => _count;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// completed : false
/// _id : "6223de5fcfbac800179e1c2c"
/// description : "reading book"
/// owner : "6223de4bcfbac800179e1c2a"
/// createdAt : "2022-03-05T22:04:15.494Z"
/// updatedAt : "2022-03-05T22:04:15.494Z"
/// __v : 0

class Data {
  Data({
      bool? completed, 
      String? id, 
      String? description, 
      String? owner, 
      String? createdAt, 
      String? updatedAt, 
      int? v,}){
    _completed = completed;
    _id = id;
    _description = description;
    _owner = owner;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _completed = json['completed'];
    _id = json['_id'];
    _description = json['description'];
    _owner = json['owner'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  bool? _completed;
  String? _id;
  String? _description;
  String? _owner;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  bool? get completed => _completed;
  String? get id => _id;
  String? get description => _description;
  String? get owner => _owner;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['completed'] = _completed;
    map['_id'] = _id;
    map['description'] = _description;
    map['owner'] = _owner;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}