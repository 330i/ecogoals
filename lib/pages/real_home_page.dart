import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecogoals/pages/goal_creation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:validators/sanitizers.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {

  Future<double> getTodaysWaste() async {
    QuerySnapshot totalSnap = await FirebaseFirestore.instance.collection('scans').get();
    double todayWaste = 0;
    for(int i=0;i<totalSnap.size;i++) {
      if((totalSnap.docs[i].get('time') as Timestamp).toDate().isAfter(
          DateTime.now().subtract(Duration(hours: DateTime.now().hour+24, minutes: DateTime.now().minute)))&&
          (totalSnap.docs[i].get('time') as Timestamp).toDate().isBefore(
              DateTime.now().subtract(Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute)))) {
        if(totalSnap.docs[i].get('weight')>=100) {
          todayWaste+=totalSnap.docs[i].get('weight')/200;
        }
        else {
          todayWaste+=totalSnap.docs[i].get('weight');
        }
      }
    }
    return todayWaste;
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold (
        appBar: AppBar (
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(
                Icons.home,
                color: Colors.black,
                size: 32,
              ),
              Text('Home', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0))
            ],
          ),
        ),
        body: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            _buildTile(
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('goals').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    QuerySnapshot snap = snapshot.data;
                    QueryDocumentSnapshot recentDoc = snap.docs[0];
                    for(int i=0;i<snap.size;i++) {
                      if((snap.docs[i].get('time') as Timestamp).toDate().isBefore((recentDoc.get('time') as Timestamp).toDate().subtract(Duration(hours: (recentDoc.get('time') as Timestamp).toDate().hour, minutes: (recentDoc.get('time') as Timestamp).toDate().minute)))) {
                        recentDoc = snap.docs[i];
                      }
                    }
                    return FutureBuilder(
                      future: getTodaysWaste(),
                      builder: (context, totalSnapshot) {
                        if(totalSnapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 24.0, right: 20.0, top: 14.0, bottom: 12.0),
                            child: Column (
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      child: Text('Current Goal', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15.0)),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Container(
                                        child: Center(
                                          child: Container(
                                            width: 75,
                                            height: 75,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 75,
                                                  height: 75,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 15,
                                                    value: recentDoc.get('goal')/totalSnapshot.data,
                                                    backgroundColor: Colors.transparent,
                                                    valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    '${(recentDoc.get('goal')/totalSnapshot.data*100 as double).toStringAsFixed(0)}%',
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                                  Text('Reduce daily waste to ${recentDoc.get('goal')} lbs', style: TextStyle(color: Colors.black87)),
                                ]
                            ),
                          );
                        }
                        else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            _buildTile(
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('scans').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    QuerySnapshot snap = snapshot.data;
                    double total = 0;
                    for(int i=0;i<snap.size;i++) {
                      if(snap.docs[i].get('weight')>=100) {
                        total+=snap.docs[i].get('weight')/200;
                      }
                      else {
                        total+=snap.docs[i].get('weight');
                      }
                    }
                    return Padding (
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column (
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            Container(
                              height: 30,
                            ),
                            Text('Total Waste', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 22.0)),
                            Container(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: total.toStringAsFixed(2),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 36.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'lbs',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white70),
                              ),
                              child: Container(
                                height: 25,
                                width: 100,
                                child: Text(
                                  'Visualize',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onPressed: () {

                              },
                            ),
                          ]
                      ),
                    );
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            _buildTile(
              Padding (
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('goals').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      QuerySnapshot snap = snapshot.data;
                      return Column (
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Column (
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [
                                  Text('Goals', style: TextStyle(color: Colors.black45)),
                                  Text(snap.size.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                ],
                              ),
                              Spacer(
                                flex: 20,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 50,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => GoalCreationPage(),
                                    ),
                                  );
                                },
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 4.0)),
                          Container(
                            width: 400,
                            height: 240,
                            child:
                            ListView.builder(
                              itemCount: snap.size,
                              itemBuilder: (BuildContext context, index) {
                                String num = snap.docs[index].get('goal').toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
                                return _goalTile(num, DateTime.fromMillisecondsSinceEpoch((snap.docs[index].get('time') as Timestamp).millisecondsSinceEpoch));
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
          staggeredTiles: [
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(2, 350.0),
          ],
        )
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell
          (
          // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null ? () => onTap() : () { print('lol'); },
            child: child
        )
    );
  }

  Widget _goalTile(String goal, DateTime time) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reduce daily waste to $goal lbs',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 3,
              ),
              Text(
                '${time.month}/${time.day}/${time.year}',
              ),
            ],
          ),
        ),
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }
}
