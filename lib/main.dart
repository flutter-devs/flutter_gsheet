import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

const _credentials = r'''{
"type": "service_account",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": ""
}''';
//spredsheet id
const _spreadsheetId = '';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final gsheets;
  late final ss;
  var sheet;
  int _counter = 0;
  int rowCount = 2;
  bool flag = false;

  _loadCredential() async {
    gsheets = GSheets(_credentials);
    ss = await gsheets.spreadsheet(_spreadsheetId);
    sheet = ss.worksheetByTitle('dump');
    print('Google Sheet Successfully Load');
    _tableHeader();
  }

  _tableHeader() async {
    await sheet!.values.insertValue('S no', column: 1, row: 1);
    await sheet!.values.insertValue('User ID', column: 2, row: 1);
    await sheet!.values.insertValue('Album ID', column: 3, row: 1);
    await sheet!.values.insertValue('Album title', column: 4, row: 1);
    await sheet!.values.insertValue('Year', column: 5, row: 1);
    await sheet!.values.insertValue('Cover Page URL', column: 6, row: 1);
    await sheet!.values.insertValue('Inside page URL', column: 7, row: 1);
    await sheet!.values.insertValue('Created Datetime', column: 8, row: 1);
    await sheet!.values.insertValue('Device OS', column: 9, row: 1);
  }

  _uploadData() async {
    setState(() {
      flag = true;
    });

    await sheet.values.insertValue(_counter, column: 1, row: rowCount);
    await sheet.values.insertValue('nvkdk234', column: 2, row: rowCount);
    await sheet.values.insertValue('Alb43', column: 3, row: rowCount);
    await sheet.values.insertValue('wedding', column: 4, row: rowCount);
    await sheet.values.insertValue('2021', column: 5, row: rowCount);
    await sheet.values.insertValue('www.google.com', column: 6, row: rowCount);
    await sheet.values.insertValue('www.google.com', column: 7, row: rowCount);
    await sheet.values
        .insertValue('2021-08-12 / 18:11:08', column: 8, row: rowCount);
    await sheet.values.insertValue('IOS', column: 9, row: rowCount);
    await rowCount++;
    setState(() {
      flag = false;
    });
  }

  @override
  void initState() {
    _loadCredential();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter GSheets'),
      ),
      body: Center(
        child: flag
            ? Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                  color: Colors.blue,
                    ),
                  Text('Please wait...'),
                ],
              ),
            )
            : Text(
                'Upload $_counter Data${_counter == 1 ? '' : 's'}.',
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: flag ? null : _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: flag ? Colors.black12 : Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _uploadData();
    });
  }
}
