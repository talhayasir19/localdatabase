import 'package:flutter/material.dart';
import 'package:localdatabase/LaptopModel.dart';
import 'package:localdatabase/LocalDb.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController modelController = TextEditingController();

  String id = '';
  String name = '';
  String model = '';

  void insertData() {
    setState(() {
      id = idController.text;
      name = nameController.text;
      model = modelController.text;
    });
    LocalDb localDb = LocalDb();
    localDb.insertData(LaptopModel(Model: model, Price: int.parse(name)));
  }

  void updateData() {
    id = idController.text;
    name = nameController.text;
    model = modelController.text;
    LocalDb localDb = LocalDb.createInstance();
    localDb.updateDate(
        LaptopModel(Id: int.parse(id), Model: model, Price: int.parse(name)));
  }

  void retrieveData() async {
    id = idController.text;
    LocalDb localDb = LocalDb();
    LocalDb localDb1 = LocalDb();
    LocalDb localDb200 = LocalDb.createInstance();
    List<LaptopModel> listLaptops = await localDb200.getData();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Data'),
          content: Text(listLaptops[listLaptops.length - 1].Id.toString() +
                  "   " +
                  listLaptops[listLaptops.length - 1].Price.toString() ??
              "Null value"),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Entry'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: 'ID',
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: modelController,
              decoration: InputDecoration(
                labelText: 'Model',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: insertData,
              child: Text('Insert Data'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: retrieveData,
              child: Text('Retrieve Data'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateData,
              child: Text('Update Data'),
            ),
          ],
        ),
      ),
    );
  }
}
