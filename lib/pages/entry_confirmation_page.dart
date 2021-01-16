import 'package:flutter/material.dart';

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
  ];

  List<Text> titles = [
    Text('Name'),
    Text('Material'),
    Text('Width'),
    Text('Height'),
    Text('Weight'),
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
      con.value = TextEditingValue(
        text: '-----',
      );
    }
  }

  void _confirmScan() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setDefaultScanData();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
