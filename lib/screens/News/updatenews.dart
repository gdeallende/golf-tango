import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'package:golfandtango/services/auth.dart';
import 'package:golfandtango/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:io';

class UpdateNews extends StatefulWidget {
  @override
  _UpdateNewsState createState() => _UpdateNewsState();
}

class _UpdateNewsState extends State<UpdateNews> {
  final AuthService _auth = AuthService();
  String authorName;
  String title;
  String description;
  File selectedImage;
  bool _isLoading = false;

  DatabaseService database = new DatabaseService();
  FirebaseStorage storage = FirebaseStorage.instance;

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(image.path);
    });
  }

  uploadNews() {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });
//upload image to firebase store
      Reference firebaseStorageRef = storage
          .ref()
          .child("newsImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      UploadTask uploadTask = firebaseStorageRef.putFile(selectedImage);
      uploadTask.then((value) async {
        var downloadUrl = await value.ref.getDownloadURL();
        print("This is the URL: $downloadUrl");

        Map<String, String> newsMap = {
          "imgUrl": downloadUrl,
          "title": title,
          "description": description
        };
        database.addNews(newsMap).then((result) {
          Navigator.pop(context);
        });
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update News and Promotions'),
        backgroundColor: Colors.yellow[700],
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.file_upload),
            label: Text('Update'),
            onPressed: () {
              uploadNews();
            },
          ),
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(color: Colors.black),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: selectedImage != null
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  selectedImage,
                                  fit: BoxFit.cover,
                                )),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            width: MediaQuery.of(context).size.width,
                            child:
                                Icon(Icons.add_a_photo, color: Colors.black45),
                          ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(
                                fontSize: 20.0, color: Colors.yellow[800]),
                            focusColor: Colors.yellow[800],
                            fillColor: Colors.grey[600].withOpacity(0.5),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.yellow[800], width: 1.0)),
                          ),
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(
                                fontSize: 10.0, color: Colors.yellow[800]),
                            focusColor: Colors.yellow[800],
                            fillColor: Colors.grey[600].withOpacity(0.5),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.yellow[800], width: 1.0)),
                          ),
                          onChanged: (value) {
                            description = value;
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
