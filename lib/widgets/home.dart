import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool sex = false;

  DateTime date;
  int age;

  double taille = 170.0;

  String poids;

  int itemSelected;

  List level = ["Faible", "Normale", "Elevée"];

  double multiplicator;

  double total;

  List<Widget> radios() {
    List<Widget> l = [];
    for(int x = 0; x < level.length; x++) {
      Column column = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(value: x,
              activeColor: sex == false ? Colors.pink : Colors.blue,
              groupValue: itemSelected,
              onChanged: (int i) {
                setState(() {
                  itemSelected = i;
                  multiplicator = level2[level[i]];
                });
              }
          ),
          Text(level[x],
            style: TextStyle(
                color: sex == false ? Colors.pink : Colors.blue
            ),
          ),
        ],
      );
      l.add(column);
    }
    return l;
  }

  Map level2 = {
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
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Remplissez tous les champs pour obtenir votre besoin quotidien en calories",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                ),
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
                              Text('Femme'),
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
                              Text('Homme'),
                            ],
                          ),
                          RaisedButton(
                              onPressed: chooseDate,
                              color: sex == false ? Colors.pink : Colors.blue,
                              textColor: Colors.white,
                              child: date == null ? Text('Indiquez votre âge') : Text("Votre age est de : $age ans")
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          Text('Votre taille est de : $taille cm',
                            style: TextStyle(
                                color: sex == false ? Colors.pink : Colors.blue
                            ),
                          ),
                          Slider(
                              value: taille,
                              activeColor: sex == false ? Colors.pink : Colors.blue,
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
                                poids = string;
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
                              color: sex == false ? Colors.pink : Colors.blue,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: radios(),
                          )
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
                  color: sex == false ? Colors.pink : Colors.blue,
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
      setState(() {
        date = choice;
        age = DateTime.now().year - date.year;
      });
    }
  }

  void calculCalories() {
    if (sex == true) {
      total = multiplicator * 66.4730 + (13.7516 * double.parse(poids)) + (5.0033 * taille) - (6.7550 * age.toDouble());
    } else {
      total = multiplicator * 655.0955 + (9.5634 * double.parse(poids)) + (1.8496 * taille) - (4.6756 * age.toDouble());
    }
    print(total);
  }
}