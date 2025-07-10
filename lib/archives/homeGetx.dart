// hompage
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';

  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  Future<void> loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Halo, $username',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 50),
              ),
              child: Text('Logout'),
            ),
            SizedBox(height: 20),
            // Arguments (cara yang sudah ada)
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/detail', arguments: {
                  'nama': username,
                  'umur': 25,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(200, 50),
              ),
              child: Text('Detail (Arguments)'),
            ),
            SizedBox(height: 10),
            // URL Parameters
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/detail/$username/25');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(200, 50),
              ),
              child: Text('Detail (URL Params)'),
            ),
            SizedBox(height: 10),
            // Query Parameters
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/detail?nama=$username&umur=25&status=active');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(200, 50),
              ),
              child: Text('Detail (Query Params)'),
            ),
          ],
        ),
      ),
    );
  }
}
