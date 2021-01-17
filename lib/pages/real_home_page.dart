import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
        appBar: AppBar
          (
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
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 20.0, top: 16.0, bottom: 12.0),
                child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Center(
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
                                      value: .8,
                                      backgroundColor: Colors.transparent,
                                      valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '80%',
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
                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('Reduce monthly trash to 5kg and stuff', style: TextStyle(color: Colors.black87)),
                    ]
                ),
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
                                      fontSize: 38.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'kg',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
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
              Padding
                (
                  padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                  child: Column
                    (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Row
                        (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Column
                            (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Text('Goals', style: TextStyle(color: Colors.black45)),
                              Text('10', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                            ],
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 4.0)),
                      Container(
                        width: 400,
                        height: 240,
                        child:
                        ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext context, index) {
                            return _goalTile('desc', DateTime.now());
                          },
                        ),
                      ),
                    ],
                  )
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
            onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
            child: child
        )
    );
  }

  Widget _goalTile(String desc, DateTime time) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                desc,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${time.month}/${time.day}/${time.year}',
              ),
            ],
          ),
        ),
        width: 300,
        height: 70,
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
