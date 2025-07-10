import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          // A list of widgets in the actions position
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Do something when the search icon is pressed
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Do something when the settings icon is pressed
            },
          ),
        ],
      ),
      body: Center(
        child: Image.network(
          'https://storage.googleapis.com/cms-storage-bucket/a9d6ce81aee44ae017ee.png',
          width: 100,
          height: 200,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
