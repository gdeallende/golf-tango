import 'package:flutter/material.dart';
import 'package:golfandtango/assistanceFunctions/sharedpref.dart';

class MessageScreen extends StatefulWidget {
  final String otherUserDisplayName;
  final String otherUserEmail;
  MessageScreen(this.otherUserDisplayName, this.otherUserEmail);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String chatThreadId;
  String messageId;
  String currentUserDisplayName;
  String currentUserProfilePic;
  String currentUserEmail;
  String myDisplayName = SharedPreferenceAssistant.userEmailKey.toString();
  TextEditingController sendingMsgEditController = TextEditingController();

  getMyInfoFromSharedPref() async {
    chatThreadId =
        makeChatRoomId(widget.otherUserDisplayName, currentUserDisplayName);
  }

  makeChatRoomId(String userOne, String userTwo) {
    if (userOne.substring(0, 1).codeUnitAt(0) >
        userTwo.substring(0, 1).codeUnitAt(0)) {
      return "$userTwo\_$userOne";
    } else {
      return "$userOne\_$userTwo";
    }
  }

  sendNewMessage() {
    if (sendingMsgEditController.text != "") {
      String theMessage = sendingMsgEditController.text;
      var lastMsgTime = DateTime.now();

      Map<String, dynamic> messageInformation = {
        "theMessage": theMessage,
        "sendBy": currentUserDisplayName,
        "timeStamp": lastMsgTime,
      };
    }
  }

  getAndSetMessages() async {}

  onLaunch() async {
    await getMyInfoFromSharedPref();
    getAndSetMessages();
  }

  @override
  void initState() {
    onLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text(widget.otherUserDisplayName),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: sendingMsgEditController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type Message...",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.yellow[800], width: 1.0)),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        String email =
                            await SharedPreferenceAssistant.getEmail();
                        print('get email on press : $email');
                      },
                      child: Icon(Icons.send, color: Colors.yellow[800]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
