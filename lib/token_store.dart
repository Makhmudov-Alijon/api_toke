import 'package:hive/hive.dart';

class TokenStore {
  final box = Hive.box('token');

  void setToken(String token){
    box.put('token', token);
  }

  String? getToken(){
    return box.get('token');

  }

  void deleteToken(){
    box.delete('token');
  }
}