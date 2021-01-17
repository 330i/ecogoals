import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecogoals/models/product.dart';
import 'package:ecogoals/pages/info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:validators/sanitizers.dart';

class EntryConfirmationPage extends StatefulWidget {
<<<<<<< HEAD
  EntryConfirmationPage({
    Key key,
    this.params,
    this.name,
  }) : super(key: key);
=======
  EntryConfirmationPage(
      {Key key,
        this.title,
        this.params,
        this.barcode,
        this.name,
        this.weight,
        this.length,
        this.width,
        this.height,
        this.isFood})
      : super(key: key);
>>>>>>> origin/ian

  final Map<String, dynamic> params;
  final String name;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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

  bool setparams = false;

  void setDefaultParams() {
    print("PARAMSSSSSS!");
    print(widget.params.toString());
    setState(
          () {
        try {
          controller[5].text = widget.params['weight'].toString();

          controller[0].text = widget.params['product_name'].toString();
          controller[6].text = widget.params['barcode_number'].toString();
          if (widget.params['category']
              .toString()
              .toLowerCase()
              .contains("food")) {
            isFood = true;
          }
          controller[4].text = widget.params['height'].toString();
          controller[3].text = widget.params['width'].toString();
          controller[2].text = widget.params['length'].toString();
        } catch (err) {
          print("There was an error");
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    try {
      controller[5].text = widget.params['weight'].toString();
    } catch (err) {
      print("There was an error");
    }
  }

  SizedBox box = SizedBox(
    height: 5,
  );

  void updateScanData(int index, String data) {}

  void setDefaultScanData() {
    for (TextEditingController con in controller) {
      con.value = TextEditingValue();
    }
  }

  void _confirmScan() async {
    DocumentReference doc =
    FirebaseFirestore.instance.collection('scans').doc();
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
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              InfoPage(params: widget.params, name: controller[0].text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (setparams == false) {
      setDefaultParams();
      setState(() {
        setparams = true;
      });
    }

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blueGrey[30],
                elevation: 3,
                shadowColor: Colors.green,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: TextField(
                          controller: controller[0],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '     Name:',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              box,
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blueGrey[30],
                shadowColor: Colors.green,
                elevation: 3,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: TextField(
                          controller: controller[1],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '     Material:',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              box,
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blueGrey[30],
                elevation: 3,
                shadowColor: Colors.green,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: TextField(
                          controller: controller[2],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '     Length:',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              box,
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blueGrey[30],
                shadowColor: Colors.green,
                elevation: 3,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: TextField(
                          controller: controller[3],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '     Width:',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              box,
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blueGrey[30],
                shadowColor: Colors.green,
                elevation: 3,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: TextField(
                          controller: controller[4],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '     Height:',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              box,
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blueGrey[30],
                shadowColor: Colors.green,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: TextField(
                          controller: controller[5],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '     Weight:',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              box,
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blueGrey[30],
                elevation: 3,
                shadowColor: Colors.green,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: TextField(
                          controller: controller[6],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '     Barcode:',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              box,
              GestureDetector(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blueGrey[30],
                  elevation: 3,
                  shadowColor: Colors.green,
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 80,
                          child: Text(
                            expiration == null
                                ? ''
                                : '${expiration.month}/${expiration.day}/${expiration.year}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: expiration != null
                        ? expiration
                        : DateTime(DateTime.now().year),
                    firstDate: DateTime(DateTime.now().year),
                    lastDate: DateTime(2050),
                  ).then((expirationdate) {
                    setState(() {
                      expiration = expirationdate;
                    });
                  });
                },
              ),
              box,
              Card(
                child: CheckboxListTile(
                  title: Text('Food'),
                  value: isFood,
                  onChanged: (bool value) {
                    setState(() {
                      isFood = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 70)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _confirmScan,
        backgroundColor: Colors.green[200],
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
