import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecogoals/models/product.dart';
import 'package:flutter/material.dart';
import 'package:validators/sanitizers.dart';

class EntryConfirmationPage extends StatefulWidget {
  EntryConfirmationPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _EntryConfirmationPageState createState() => _EntryConfirmationPageState();
}

class _EntryConfirmationPageState extends State<EntryConfirmationPage> {
  List<TextEditingController> controller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  DateTime expiration;
  bool isFood = false;

  List<Text> titles = [
    Text('Name'),
    Text('Material'),
    Text('Length'),
    Text('Width'),
    Text('Height'),
    Text('Weight'),
    Text('Barcode'),
    Text('isFood'),
    Text('Expiration'),
  ];

  Divider divider = Divider(
    color: Colors.blue,
    height: 10,
    thickness: 2,
    indent: 20,
    endIndent: 0,
  );

  void updateScanData(int index, String data) {}

  void setDefaultScanData() {
    for (TextEditingController con in controller) {
      con.value = TextEditingValue();
    }
  }

  void _confirmScan() async {
    DocumentReference doc = FirebaseFirestore.instance.collection('scans').doc();
    setState(() {
      Product product = Product(
        name: controller[0].text,
        packaging: controller[1].text,
        length: toDouble(controller[2].text),
        width: toDouble(controller[3].text),
        height: toDouble(controller[4].text),
        weight: toDouble(controller[5].text),
        barcode: controller[6].text,
        isFood: isFood,
        time: Timestamp.fromDate(DateTime.now()),
        expiration: Timestamp.fromDate(expiration),
        id: doc.id,
        used: 0,
      );
      doc.set(product.toJson());
    });
  }

  @override
  Widget build(BuildContext context) {
    setDefaultScanData();
    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 64,
              color: Colors.blue[100],
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    titles[0],
                    TextField(
                      controller: controller[0],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            divider,
            Container(
              height: 64,
              color: Colors.blue[100],
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    titles[1],
                    TextField(
                      controller: controller[1],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            divider,
            Container(
              height: 64,
              color: Colors.blue[100],
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    titles[2],
                    TextField(
                      controller: controller[2],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            divider,
            Container(
              height: 64,
              color: Colors.blue[100],
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    titles[3],
                    TextField(
                      controller: controller[3],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            divider,
            Container(
              height: 64,
              color: Colors.blue[100],
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    titles[4],
                    TextField(
                      controller: controller[4],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 64,
              color: Colors.blue[100],
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    titles[5],
                    TextField(
                      controller: controller[5],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            divider,
            Container(
              height: 64,
              color: Colors.blue[100],
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    titles[6],
                    TextField(
                      controller: controller[6],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            divider,
            CheckboxListTile(
              title: Text('Food'),
              value: isFood,
              onChanged: (bool value) {
                setState(() {
                  isFood = value;
                });
              },
            ),
            divider,
            GestureDetector(
              child: Container(
                height: 64,
                color: Colors.blue[100],
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      titles[8],
                      Text(
                        expiration == null ? '' : '${expiration.month}/${expiration.day}/${expiration.year}',
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: expiration != null ? expiration : DateTime(DateTime.now().year),
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime(2050),
                ).then((expirationdate) {
                  setState(() {
                    expiration = expirationdate;
                  });
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _confirmScan,
        backgroundColor: Colors.green[100],
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
