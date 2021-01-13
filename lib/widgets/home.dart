import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool sex = false;

  int age;

  double taille = 170.0;

  double poids;

  double itemSelected;

  double total;

  int base;
  int activite;

  Row radios() {
    List<Widget> l = [];
    activities.forEach((key, value) {
      Column column = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            value: value,
            groupValue: itemSelected,
            activeColor: setcolor(),
            onChanged: (Object i) {
              setState(() {
                itemSelected = i;
              });
            }
          ),
          textWithStyle(key, color: setcolor()),
        ],
      );
      l.add(column);
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: l,
    );
  }

  Map activities = {
    'Faible': 1.2,
    'Normale': 1.5,
    'Elevée': 1.8
  };


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: setcolor(),
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textWithStyle("Remplissez tous les champs pour obtenir votre besoin quotidien en calories",
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  elevation: 10.0,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textWithStyle('Femme', color: Colors.pink),
                              Switch(
                                  inactiveTrackColor: Colors.pink,
                                  inactiveThumbColor: Colors.pink,
                                  activeTrackColor: Colors.blue,
                                  value: sex,
                                  onChanged: (bool b) {
                                    setState(() {
                                      sex = b;
                                    });
                                  }
                              ),
                              textWithStyle('Homme', color: Colors.blue)
                            ],
                          ),
                          RaisedButton(
                              onPressed: chooseDate,
                              color: setcolor(),
                              textColor: Colors.white,
                              child: age == null ? Text('Indiquez votre âge') : Text("Votre age est de : $age ans")
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          Text('Votre taille est de : $taille cm',
                            style: TextStyle(
                                color: setcolor()
                            ),
                          ),
                          Slider(
                              value: taille,
                              activeColor: setcolor(),
                              divisions: 80,
                              min: 170.0,
                              max: 250.0,
                              onChanged: (double d) {
                                setState(() {
                                  taille = d;
                                });
                              }
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            onSubmitted: (String string) {
                              setState(() {
                                poids = double.parse(string);
                              });
                            },
                            decoration: InputDecoration(
                                filled: true,
                                labelText: "Remplir le champ avec votre poids"
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          Text(
                            "Quelle est votre activité sportive ?",
                            style: TextStyle(
                              color: setcolor(),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          radios(),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                  child: Text("Calculez votre besoin"),
                  textColor: Colors.white,
                  color: setcolor(),
                  onPressed: calculCalories
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> chooseDate() async {
    DateTime choice = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (choice != null) {
      var difference = DateTime.now().difference(choice);
      var days = difference.inDays;
      var years = days / 365.25;
      setState(() {
        age = years.toInt();
      });
    }
  }

  void calculCalories() {
    if (poids != null && taille != null && itemSelected != null) {
      sex == true ? base = (66.4730 + (13.7516 * poids) + (5.0033 * taille) - (6.7550 * age)).toInt() : base = (655.0955 + (9.5634 * poids) + (1.8496 * taille) - (4.6756 * age)).toInt();
      activite = (base * itemSelected).toInt();
      calcul();
    } else {
      alert();
    }
  }

  Future<Null> calcul() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: textWithStyle('Calcul', fontSize: 20.0),
          content: textWithStyle("Votre montant de calorie de base est de : $base kcal "
              "\n Votre montant de calorie avec activité est de : $activite kcal"),
          actions: [
            FlatButton(
              color: setcolor(),
              onPressed: () => Navigator.pop(context),
              child: textWithStyle('Retour', color: Colors.white))
          ],
        );
      }
    );
  }

  Future<Null> alert() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: textWithStyle('Erreur'),
          content: textWithStyle('Tous les champs ne sont pas remplis'),
          actions: [
            FlatButton(
              color: setcolor(),
              onPressed: () => Navigator.pop(context),
              child: textWithStyle("Retour", color: Colors.white)
            ),
          ],
        );
      }
    );
  }

  Text textWithStyle(String data, {color: Colors.black87, factor: 1.0, fontSize: 15.0}) {
    return Text(
        data,
        textScaleFactor: factor,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: fontSize
        )
    );
  }

  Color setcolor() {
    return sex == false ? Colors.pink : Colors.blue;
  }
}