import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecogoals/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:validators/sanitizers.dart';

class GoalCreationPage extends StatefulWidget {
  @override
  _GoalCreationPageState createState() => _GoalCreationPageState();
}

class _GoalCreationPageState extends State<GoalCreationPage> {

  TextEditingController wasteController = new TextEditingController();
  DateTime goal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          Spacer(
            flex: 1,
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Spacer(
            flex: 20,
          ),
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () {
              print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
              if(!(wasteController.text==''||wasteController.text==null)&&goal!=null) {
                FirebaseFirestore.instance.collection('goals').add({
                  'goal': toDouble(wasteController.text),
                  'time': Timestamp.fromDate(goal),
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              }
            },
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'My goal is to reduce daily waste to',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            child: TextField(
                              controller: wasteController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5),
                              ),
                            ),
                          ),
                          Text(
                            ' pounds',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                    ),
                    Container(
                      child: Text(
                        'I\'m going to reach it before',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueGrey[30],
                  elevation: 3,
                  shadowColor: Colors.black45,
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 230,
                          height: 60,
                          child: Center(
                            child: Text(
                              goal == null
                                  ? ''
                                  : '${goal.month}/${goal.day}/${goal.year}',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: goal != null
                        ? goal
                        : DateTime(DateTime.now().year),
                    firstDate: DateTime(DateTime.now().year),
                    lastDate: DateTime(2050),
                  ).then((goaldate) {
                    setState(() {
                      goal = goaldate;
                    });
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
