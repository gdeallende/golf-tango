import 'package:flutter/material.dart';
import 'package:golfandtango/screens/Menu/drinks/drinks.dart';
import 'package:golfandtango/screens/Menu/food/food.dart';
import 'package:golfandtango/screens/Menu/other/other.dart';
import 'package:golfandtango/services/auth.dart';

class MenuCatagories extends StatefulWidget {
  @override
  _MenuCatagoriesState createState() => _MenuCatagoriesState();
}

class _MenuCatagoriesState extends State<MenuCatagories> {
  final AuthService _auth = AuthService();

  List<String> catagories = ["Food", "Drinks", "Other"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Menu: ')),
          backgroundColor: Colors.yellow[700],
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/four_tumblers.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Container(
                margin: const EdgeInsets.all(80.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  children: catagories.map((catagory) {
                    return GestureDetector(
                      child: Card(
                        elevation: 2.0,
                        color: Colors.white.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.yellow[800], width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(20.0),
                        child: getCardByCatagory(catagory),
                      ),
                      onTap: () {
                        if (catagory == "Food")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodMenu()));
                        else if (catagory == "Drinks")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DrinksMenu()));
                        else
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtherMenu()));
                      },
                    );
                  }).toList(),
                ))));
  }

  getCardByCatagory(String catagory) {
    String img = "";
    if (catagory == "Food")
      img = "assets/burger_png.png";
    else if (catagory == "Drinks")
      img = "assets/cocktail_png.png";
    else
      img = "assets/lighter.png";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
          child: Container(
            child: new Stack(
              children: <Widget>[
                new Image.asset(
                  img,
                  width: 100,
                  height: 100.0,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 100,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
                color: Colors.yellow.shade600.withOpacity(0.8), width: 2),
            borderRadius: BorderRadius.all(Radius.circular(1.0)),
          ),
          child: Text(
            catagory,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
