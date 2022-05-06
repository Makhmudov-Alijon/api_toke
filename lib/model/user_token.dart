/// age : 20
/// _id : "6223c3892a4ae90017a8260c"
/// name : "al1231231231"
/// email : "shahzodbek12345@gmail.com"
/// createdAt : "2022-03-05T20:09:45.031Z"
/// updatedAt : "2022-03-05T20:09:45.283Z"
/// __v : 1

class UserToken {
  UserToken({
      int? age, 
      String? id, 
      String? name, 
      String? email, 

      int? v,}){
    _age = age;
    _id = id;
    _name = name;
    _email = email;

    _v = v;
}

  UserToken.fromJson(dynamic json) {
    _age = json['age'];
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];

    _v = json['__v'];
  }
  int? _age;
  String? _id;
  String? _name;
  String? _email;

  int? _v;

  int? get age => _age;
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;

  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['age'] = _age;
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;

    map['__v'] = _v;
    return map;
  }

}