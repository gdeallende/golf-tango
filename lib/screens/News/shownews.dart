import 'package:flutter/material.dart';
import 'package:golfandtango/screens/News/updatenews.dart';
import 'package:golfandtango/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golfandtango/services/database.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final AuthService _auth = AuthService();
  DatabaseService database = new DatabaseService();

  QuerySnapshot newsSnapshot;

  Widget newsList() {
    return Container(
      child: Column(
        children: <Widget>[
          newsSnapshot != null
              ? Expanded(
                  child: ListView.builder(
                      itemCount: newsSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> temp =
                            newsSnapshot.docs[index].data();
                        print('download data ${temp['description']}');
                        return NewsTile(
                            temp["imgUrl"], temp["title"], temp["description"]);
                      }),
                )
              : Container(child: Text("Loading"))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    database.getNews().then((result) {
      newsSnapshot = result;
      print('newsSnapshot.docs.length ' + newsSnapshot.docs.length.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Venue News and Promotions'),
        backgroundColor: Colors.yellow[700],
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: newsList(),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UpdateNews()));
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  String imgUrl;
  String title;
  String description;

  NewsTile(this.imgUrl, this.title, this.description);

  @override
  Widget build(BuildContext context) {
    print('$title $imgUrl $description');
    return Container(
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imgUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(height: 50),
                  Text(description,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ))
        ],
      ),
    );
  }
}
