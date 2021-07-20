import 'package:flutter/material.dart';
import 'package:golfandtango/services/auth.dart';
import 'package:golfandtango/screens/wrapper.dart';
import 'package:golfandtango/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golfandtango/screens/chatscreen/message.dart';

class Chatscreen extends StatefulWidget {
  @override
  _ChatscreenState createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  bool isSearching = false;

  Stream userStream;
  Stream currentUserStream;

  TextEditingController searchUsernameEditController = TextEditingController();

  searchButtonClick() async {
    setState(() {
      isSearching = true;
    });
    userStream = await DatabaseService()
        .getUserWithUsername(searchUsernameEditController.text);
    setState(() {});
  }

  // create conversation and proceed to the messages with that user.

  Widget listOfUsers() {
    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot docsnap = snapshot.data.docs[index];
                    return userProileInfo(docsnap["profilePic"],
                        docsnap["displayName"], docsnap["email"]);
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget listRecentChats() {
    return Container();
  }

  Widget userProileInfo(profilePic, displayName, email) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessageScreen(displayName, email)));
      },
      child: Row(
        children: [
          Image.network(
            profilePic,
            height: 35,
            width: 35,
          ),
          SizedBox(width: 10),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(displayName), Text(email)])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text('Chat Room'),
        actions: <Widget>[
          TextButton.icon(
              icon: Icon(Icons.exit_to_app),
              label: Text('Logout'),
              onPressed: () {
                AuthService().signOut().then((s) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Wrapper()),
                  );
                });
              }),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                isSearching
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isSearching = false;
                            searchUsernameEditController.text = "";
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.arrow_back_sharp)),
                      )
                    : Container(),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.yellow[800],
                          width: 1.5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.horizontal(),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchUsernameEditController,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Username"),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              if (searchUsernameEditController.text != "") {
                                searchButtonClick();
                              }
                            },
                            child: Icon(Icons.search))
                      ],
                    ),
                  ),
                )
              ],
            ),
            listOfUsers()
          ],
        ),
      ),
    );
  }
}
