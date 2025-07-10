import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  ListData({super.key});

  final List<String> mahasiswa = [
    'Udin - 333720001',
    'Asep - 333720002',
    'Siti - 333720003',
    'Budi - 333720004',
    'Tati - 333720005',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Belajar ListView')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: mahasiswa.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://placehold.co/50.png'),
              ),
              title: Text(mahasiswa[index]),
              subtitle: const Text('Klik Detail'),
              onTap: () {
                print(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Mahasiswa : ${mahasiswa[index]}'),
                    showCloseIcon: true,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}