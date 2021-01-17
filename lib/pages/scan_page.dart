import 'dart:async';
import 'dart:convert';

import 'package:ecogoals/pages/entry_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class ScanPage extends StatefulWidget {
  ScanPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String _scanBarcode = 'Unknown';

  String barcodeBase = "https://api.barcodelookup.com/v2/products?barcode=";
  String barcodeSearchKey = "6uyacpq2o718lih1oc8rl4cgs7644g";

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
                params: data["products"][0],
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Barcode scan')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            onPressed: () => scanBarcodeNormal(context),
                            child: Text("Start barcode scan")),
                        Text('Scan result : $_scanBarcode\n',
                            style: TextStyle(fontSize: 20))
                      ]));
            })));
  }
}
