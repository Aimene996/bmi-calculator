import 'dart:math';

import 'package:agecalculate/screens/result.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isMale = true;
  double weight = 60;
  double age = 22;
  bool isSelected = true;
  double heightVal = 170;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text('Title'),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _gender(context, "male"),
                            _gender(context, "female")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "height",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${heightVal.toStringAsFixed(1)}",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "cm",
                                  style: Theme.of(context).textTheme.headline1,
                                )
                              ],
                            ),
                            Slider(
                              min: 100,
                              max: 220,
                              value: heightVal,
                              onChanged: (value) {
                                setState(() {
                                  heightVal = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _optionThree(context, "weight"),
                            _optionThree(context, "age")
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        var result = weight / pow(heightVal / 100, 2);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Result(
                                result: result, isMale: isMale, age: age);
                          }),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              "Calculate",
                              style: Theme.of(context).textTheme.headline2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container()
                  ],
                ),
              ),
            )));
  }

  Widget _gender(BuildContext context, String type) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isMale = type == "male" ? true : false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: (isMale && type == "male") || (!isMale && type != "male")
                    ? Theme.of(context).primaryColor
                    : Colors.blueGrey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    type == "male" ? Icons.male : Icons.female,
                    size: 90,
                  ),
                  Text(
                    type == "male" ? "male" : "female",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _optionThree(BuildContext context, String type) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.blueGrey),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                type == 'weight' ? 'weight' : "age",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                type == 'weight' ? '$weight' : "$age",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: type == 'weight' ? weight++ : age++,
                    onPressed: () {
                      setState(() {
                        type == 'weight' ? weight++ : age++;
                      });
                    },
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    heroTag: type == "age" ? age-- : weight--,
                    onPressed: () {
                      setState(() {
                        type == 'age' ? age-- : weight--;
                      });
                    },
                    child: Icon(Icons.remove),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
