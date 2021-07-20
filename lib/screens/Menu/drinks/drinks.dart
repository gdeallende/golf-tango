import 'package:flutter/material.dart';
import 'package:golfandtango/screens/Menu/drinks/beer.dart';
import 'package:golfandtango/screens/Menu/drinks/gin.dart';
import 'package:golfandtango/screens/Menu/drinks/liquers.dart';
import 'package:golfandtango/screens/Menu/drinks/rum.dart';
import 'package:golfandtango/screens/Menu/drinks/softdrinks.dart';
import 'package:golfandtango/screens/Menu/drinks/tequila.dart';
import 'package:golfandtango/screens/Menu/drinks/vodka.dart';
import 'package:golfandtango/screens/Menu/drinks/whiskey.dart';
import 'package:golfandtango/screens/Menu/drinks/wine.dart';
import 'package:golfandtango/services/auth.dart';

class DrinksMenu extends StatefulWidget {
  @override
  _DrinksListState createState() => _DrinksListState();
}

class _DrinksListState extends State<DrinksMenu> {
  final AuthService _auth = AuthService();

  List<String> catagories = [
    "Vodka",
    "Gin",
    "Rum",
    "Tequila",
    "Whiskey",
    "Liquers",
    "Soft Drinks",
    "Wine",
    "Beer",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Menu: Drinks ')),
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
            child: Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  children: catagories.map((catagory) {
                    return GestureDetector(
                      child: Card(
                        elevation: 2.0,
                        color: Colors.white.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.yellow[800], width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(10.0),
                        child: getCardByCatagory(catagory),
                      ),
                      onTap: () {
                        if (catagory == "Vodka")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VodkaList()));
                        else if (catagory == "Gin")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GinList()));
                        else if (catagory == "Rum")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RumList()));
                        else if (catagory == "Tequila")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TequilaList()));
                        else if (catagory == "Whiskey")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WhiskeyList()));
                        else if (catagory == "Liquers")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LiquersList()));
                        else if (catagory == "Soft Drinks")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SoftDrinksList()));
                        else if (catagory == "Wine")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WineList()));
                        else if (catagory == "Beer")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BeerList()));
                        else
                          print("Other");
                      },
                    );
                  }).toList(),
                ))));
  }

  Column getCardByCatagory(String catagory) {
    String img = "";
    if (catagory == "Vodka")
      img = "assets/vodka.png";
    else if (catagory == "Gin")
      img = "assets/cocktail_png.png";
    else if (catagory == "Rum")
      img = "assets/cocktail_png.png";
    else if (catagory == "Tequila")
      img = "assets/cocktail_png.png";
    else if (catagory == "Whiskey")
      img = "assets/cocktail_png.png";
    else if (catagory == "Liquers")
      img = "assets/cocktail_png.png";
    else if (catagory == "Soft Drinks")
      img = "assets/cocktail_png.png";
    else if (catagory == "Wine")
      img = "assets/cocktail_png.png";
    else if (catagory == "Beer")
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
