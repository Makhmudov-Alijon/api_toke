import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../model/all_task_api.dart';
import '../model/user_token.dart';
import '../token_store.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}
final tokenStore = TokenStore();
class _ProfilPageState extends State<ProfilPage> {
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
  File? image;
  final _picker=ImagePicker();
  Future getImage()async{
    final pickedFile=await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(pickedFile!=null){
      image=File(pickedFile.path);
      setState(() {

      });
    }else{
      print('no image');

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[800],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
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
                  child: Text('Profil',style: GoogleFonts.pacifico(fontSize: 40,fontWeight: FontWeight.w900,),)
              ),
            ),
            GestureDetector(
              child: Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 14.0,

                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.file(
                    File(image?.path ?? '').absolute,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
              ),
              onTap: (){
                getImage();
              },
            ),
            Container(
              child:  FutureBuilder(
                  future: userToken(),
                  builder: (context, AsyncSnapshot<UserToken> snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(

                          children: [

                            Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Text('Name : ${snapshot.data?.name.toString()}' ,
                                  style: TextStyle(color: Colors.white),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Text('Email : ${snapshot.data?.email.toString()}' ,
                                    style: TextStyle(color: Colors.white))),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Text('Age : ${snapshot.data?.age.toString()}' ,
                                    style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: FutureBuilder(
                future: fetchTask(),
                  builder: (context,AsyncSnapshot<AllTaskApi?> snapshot){
                  return Text('All Task Number : ${snapshot.data?.count.toString()}' ?? '' , style: TextStyle(color: Colors.white),);
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
