import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

const _credentials = r'''{
"type": "service_account",
  "project_id": "winged-axon-322708",
  "private_key_id": "8c4a7d75cffc2f8aff09e24e730a7831985ec1cb",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCUl0eBi2FaoLqt\nyx8IQf0vGuqPM+TznyQUSKf/8vtx1E+yguLE1zU8N5p2ZaHEWGhLMh9eqOVWjaQ6\nBYU/8HBUvpSso6VWgJPn3bV0TQ6vPuneK95MZubNh0GqHMi0vlROE+qGlxSsW+OX\nD9B1TCR48tWnAzdxbdsy72b+kVAI8Pbs9uRzH1gbaMPxcx1Np5RQo7KE4baqRq0w\n5pFYHpwWY6suwQdzBMiOe3ta2cYiZWWktQWmee5H7qwCn534S8F3XCAM3CW6AqZG\np4Xjsl49LIts9QTlVQT3iFbcFCTyI4e016f8/myuOLHhlZPqgDgpot2mmkaSY7Eh\nx4JW/XdhAgMBAAECggEADXL7NhFTYKcUo9SzPIWbMM91tJF6Dcef4IrKU03UZB4B\n5VftxkBDtsLCTdNuxr1JGf6cPUP57Lwe8GDTNJGC3ADF/IbxWPjZVPl0dOWL8zZg\nEku+hVl5AYMBDAXVRXAcDwHEI/t6aQwGIlmm62msEXB1Vcu3kczjiWLcMSVzl44d\n4jFmnmFOUq41Ct1DD6in1QoGBg/d5teGBveN03qBN4jeVpvUBL16u8epk3Q3Z4zO\ne/guSuK1s+fg18ElYvrGP6Th9eEH410NnTD1ng+9pWHhdh8VD8wkN2s9D9EgulLV\nMSeh6EZCqMHlnffUUbpgIdt//+BLFiwQX2kFn5PhWwKBgQDLev2guvEY3Ds1AGL6\nVl+MSviKqkd5EbdzIT5et3WEoWGFtn5NmB15lnfYyX+51N6EN7cxar8XY3D2IarW\n4+lbl/h1seif8XhlIcfsABuujALdua+cM9F7qTlyGoHxof6gDHKku0SkwRNtID9M\nZ0Ga+m+0y65AqTZ7VfY+OEHyVwKBgQC68XROVpz4ztijLAf2KHTi3rYUMTV6UrwW\nQXMQ6dN6TJpCNMNdQGxZIq3qx11OKcxVQvTputWQbTV4Jr3RfyImIEcBNGBhuRtV\ntlEEy45pq/YToxBVFXE1WxPQAJ9Y1TzXi+AZ1swL4ijigcpqsLlAJkK5TpHtZFjp\nblY3hz6BBwKBgQCsNKKBbLSufXP+Hx2lD4Q9jxVZBVMHu16uKOxH7KugW5PVPeUW\ndi47wIQdDCr0cpr++sgnIlgmyxnGtCeJRckwoyS7Np3Q/uMNc9FmgZDr38JtM8DT\nSWd4aHcdgiGHBbogaWh80Z/+bwipyijH2HtFVb1EHTyTrKFXMCD9906YcQKBgQCJ\nk0QKmscue9sGSlMZnrBWfZv1xDkc6mIs5sGtgsb1TAaCDp5vtAeImXLwQwOxkCUl\n4f6nO64LebNN1wT+dddFw589jbQYdsddDq0VIFCQB9MypGBSnVMQ9xPfkXWzREpg\nPjoQCflkDW4VM3sphSDvyrhz8xSFZcHhGCgu+ULQZQKBgBfr3kQcmktyinHAa+z6\nMIn0Ovu4Ll5IB3u0vdR2TQyEEnGOyPjcoqrDXgf1DwKeAfYbBqLssifpYHBP2B9h\nQ5SAgrYO5nwZKnDeIhQfNdSIyvvzvl/QHuxNPdRvB3iRLeUtJZM6AvfxtgSjXjij\nSQ0FnH1hT2kXcWh7oGUNxg5V\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets-tutorial@winged-axon-322708.iam.gserviceaccount.com",
  "client_id": "103328362079909973172",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets-tutorial%40winged-axon-322708.iam.gserviceaccount.com"
}''';
//spredsheet id
const _spreadsheetId = '1dhT9ptWQch65Tvj0LRN3vC9xIKkUvazJe4lXEwsmiWY';

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
