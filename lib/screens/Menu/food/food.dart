import 'package:flutter/material.dart';
import 'package:golfandtango/screens/Menu/food/breakfast.dart';
import 'package:golfandtango/screens/Menu/food/extras.dart';
import 'package:golfandtango/screens/Menu/food/mains.dart';
import 'package:golfandtango/screens/Menu/food/sides.dart';
import 'package:golfandtango/services/auth.dart';

class FoodMenu extends StatefulWidget {
  @override
  _FoodMenuState createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  final AuthService _auth = AuthService();

  List<String> catagories = [
    "Breakfast",
    "Mains",
    "Sides",
    "Desserts",
    "Extras"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Menu: Food ')),
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
                        if (catagory == "Breakfast")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BreakfastList()));
                        else if (catagory == "Mains")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainsList()));
                        else if (catagory == "Sides")
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SidesList()));
                        else if (catagory == "Desserts")
                          print("Tequila");
                        else
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExtrasList()));
                      },
                    );
                  }).toList(),
                ))));
  }

  Column getCardByCatagory(String catagory) {
    String img = "";
    if (catagory == "Breakfast")
      img = "assets/burger_png.png";
    else if (catagory == "Mains")
      img = "assets/cocktail_png.png";
    else if (catagory == "Sides")
      img = "assets/cocktail_png.png";
    else if (catagory == "Desserts")
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
