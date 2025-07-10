// detail page
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data dari arguments
    final argData = Get.arguments;
    
    // Ambil data dari URL parameters (path parameters)
    final namaParam = Get.parameters['nama'];
    final umurParam = Get.parameters['umur'];
    
    // Ambil data dari query parameters
    final namaQuery = Get.parameters['nama'];
    final umurQuery = Get.parameters['umur'];
    final statusQuery = Get.parameters['status'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Arguments Data
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data dari Arguments:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Nama: ${argData != null ? argData['nama'] ?? '-' : '-'}'),
                    Text('Umur: ${argData != null ? argData['umur']?.toString() ?? '-' : '-'}'),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // URL Parameters Data
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data dari URL Parameters:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Nama: ${namaParam ?? '-'}'),
                    Text('Umur: ${umurParam ?? '-'}'),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // Query Parameters Data
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data dari Query Parameters:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.orange.shade800,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Nama: ${namaQuery ?? '-'}'),
                    Text('Umur: ${umurQuery ?? '-'}'),
                    Text('Status: ${statusQuery ?? '-'}'),
                  ],
                ),
              ),
              
              SizedBox(height: 30),
              
              // Debug Info
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Debug Info:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Current Route: ${Get.currentRoute}'),
                    Text('All Parameters: ${Get.parameters}'),
                    Text('Arguments: ${Get.arguments}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
