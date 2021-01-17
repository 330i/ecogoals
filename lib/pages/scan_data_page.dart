import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

import 'entry_confirmation_page.dart';

class ScanDataPage extends StatefulWidget {
  @override
  _ScanDataPageState createState() => _ScanDataPageState();
}

class _ScanDataPageState extends State<ScanDataPage> {

  String _scanBarcode = 'Unknown';

  String barcodeBase = "https://api.barcodelookup.com/v2/products?barcode=";
  String barcodeSearchKey = "kwdpyrwe68p47x8dx81oyht7jzirg0";

  int touchedIndex;

  @override
  void initState() {
    super.initState();
  }

  var barcodedata = {};

  Future getFoodData(String name) {}

  Future<Map<String, dynamic>> getBarcodeData(String barcode) async {
    var url = barcodeBase + barcode + "&formatted=y&key=" + barcodeSearchKey;
    var response = await http.get(url);

    barcodedata = json.decode(response.body);

    print(barcodedata);
    return barcodedata;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future scanBarcodeNormal(BuildContext context) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    var data = await getBarcodeData(barcodeScanRes);
    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EntryConfirmationPage(
            title: "Confirmation",
            params: data,
            barcode: barcodeScanRes,
            name: barcodedata['products'][0]['product_name'],
            weight: barcodedata['products'][0]['weight'],
            length: barcodedata['products'][0]['length'],
            width: barcodedata['products'][0]['width'],
            height: barcodedata['products'][0]['height'],
            isFood: barcodedata['products'][0]['category'].contains('Food'),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 20.0, top: 8.0, bottom: 12.0),
                child: Column (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text('Waste Material', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16.0)),
                      Center(
                        child: Container(
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 140,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 140,
                                    child: Center(
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance.collection('scans').snapshots(),
                                        builder: (context, snapshot) {
                                          if(snapshot.hasData) {
                                            QuerySnapshot snap = snapshot.data;
                                            List<int> material = [0,0,0,0];
                                            print(snap.size);
                                            for(int i=0;i<snap.size;i++) {
                                              if(snap.docs[i].get('packaging').toLowerCase()=='plastic') {
                                                material[0]++;
                                                print('plastic');
                                              }
                                              if(snap.docs[i].get('packaging').toLowerCase()=='cardboard') {
                                                material[1]++;
                                                print('plastic');
                                              }
                                              if(snap.docs[i].get('packaging').toLowerCase()=='metal') {
                                                material[2]++;
                                                print('plastic');
                                              }
                                              else {
                                                material[3]++;
                                                print('other: ${snap.docs[i].get('packaging')}');
                                              }
                                            }
                                            int total = material[0]+material[1]+material[2]+material[3];
                                            return PieChart(
                                              PieChartData(
                                                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                                                    setState(() {
                                                      if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                                          pieTouchResponse.touchInput is FlPanEnd) {
                                                        touchedIndex = -1;
                                                      }
                                                      else {
                                                        touchedIndex = pieTouchResponse.touchedSectionIndex;
                                                      }
                                                    });
                                                  }),
                                                  borderData: FlBorderData(
                                                    show: false,
                                                  ),
                                                  sectionsSpace: 0,
                                                  centerSpaceRadius: 40,
                                                  sections: showingSections(material[0]*100.0/total,material[1]*100.0/total,material[2]*100.0/total,material[3]*100.0/total)
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              ),
              onTap: null,
            ),
            _buildTile(
              Padding
                (
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 115,
                        ),
                      ),
                      Text('Scan', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                      Text('Barcode ', style: TextStyle(color: Colors.black45)),
                    ]
                ),
              ),
              onTap: () => scanBarcodeNormal(context),
            ),
            _buildTile(
              Padding
                (
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('scans').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      QuerySnapshot snap = snapshot.data;
                      return Column
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
                                  Text('Scans', style: TextStyle(color: Colors.black45)),
                                  Text(snap.size.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                ],
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 4.0)),
                          Container(
                            width: 400,
                            height: 240,
                            child: ListView.builder(
                              itemCount: snap.size,
                              itemBuilder: (BuildContext context, index) {
                                return _goalTile(snap.docs[index].get('name'), DateTime.fromMillisecondsSinceEpoch((snap.docs[index].get('time') as Timestamp).millisecondsSinceEpoch), DateTime.fromMillisecondsSinceEpoch((snap.docs[index].get('expiration') as Timestamp).millisecondsSinceEpoch));
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
            onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
            child: child
        )
    );
  }

  Widget _goalTile(String desc, DateTime time, DateTime expiration) {
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
              Text(
                '${expiration.month}/${expiration.day}/${expiration.year}',
              ),
            ],
          ),
        ),
        width: 300,
        height: 100,
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

  List<PieChartSectionData> showingSections(double plastic, double cardboard, double metal, double other) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 10;
      final double radius = isTouched ? 30 : 20;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.lightBlueAccent,
            value: plastic,
            title: isTouched ? 'Plastic' : '${plastic.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.deepOrangeAccent,
            value: cardboard,
            title: isTouched ? 'Cardboard' : '${cardboard.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purpleAccent,
            value: metal,
            title: isTouched ? 'Metal' : '${metal.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.greenAccent,
            value: other,
            title: isTouched ? 'Others' : '${other.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black),
          );
        default:
          return null;
      }
    });
  }
}