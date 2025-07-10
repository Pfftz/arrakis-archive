import 'dart:math';
import 'package:flutter/material.dart';

// Menggunakan StatefulWidget karena kita perlu mengelola state
// seperti teks yang dimasukkan, teks yang ditampilkan, dan warna latar.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Controller untuk mengambil teks dari TextField.
  final _namaController = TextEditingController();

  // State untuk menyimpan teks yang akan ditampilkan di bawah tombol.
  String _displayText = 'Halo,';

  // State untuk menyimpan warna latar belakang Scaffold.
  Color _backgroundColor = Colors.white;

  // Fungsi ini dipanggil ketika tombol "Tampilkan Nama" ditekan.
  void _updateUI() {
    // setState() memberi tahu Flutter bahwa state telah berubah,
    // dan framework harus membangun ulang UI.
    setState(() {
      // 1. Memperbarui teks yang ditampilkan.
      // Jika TextField kosong, tampilkan "Halo,", jika tidak, tampilkan "Halo, <nama>".
      if (_namaController.text.isNotEmpty) {
        _displayText = 'Halo, ${_namaController.text}';
      } else {
        _displayText = 'Halo,';
      }

      // 2. Mengubah warna latar belakang secara acak.
      // Membuat daftar warna untuk dipilih secara acak.
      final List<Color> colorOptions = [
        Colors.red[100]!,
        Colors.blue[100]!,
        Colors.green[100]!,
        Colors.yellow[100]!,
        Colors.purple[100]!,
        Colors.orange[100]!,
        Colors.teal[100]!,
      ];
      // Pilih warna acak dari daftar di atas.
      _backgroundColor = colorOptions[Random().nextInt(colorOptions.length)];
    });
  }

  // Membersihkan controller saat widget tidak lagi digunakan untuk mencegah memory leak.
  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold adalah kerangka dasar untuk halaman aplikasi.
    return Scaffold(
      // Mengatur warna latar belakang sesuai dengan state _backgroundColor.
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        // Menyesuaikan judul dan warna AppBar sesuai gambar.
        title: const Text('Name Wondr'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      // Memberi padding di seluruh sisi body.
      body: _nameInputBar(),
    );
  }

  Padding _nameInputBar() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        // Pusatkan konten secara vertikal di tengah layar.
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TextField untuk input nama.
          TextField(
            controller: _namaController,
            decoration: const InputDecoration(
              labelText: 'Masukkan Nama',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
            ),
          ),
          // Memberi jarak vertikal antara TextField dan Tombol.
          const SizedBox(height: 16),
          // Tombol untuk memicu pembaruan UI.
          // Menggunakan SizedBox untuk mengatur lebar tombol agar memenuhi layar.
          _nameButton(),
          // Memberi jarak vertikal antara Tombol dan Teks.
          const SizedBox(height: 40),
          // Teks yang akan diperbarui.
          Text(
            _displayText,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _nameButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _updateUI,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Warna tombol
          foregroundColor: Colors.white, // Warna teks tombol
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 5,
        ),
        child: const Text('Tampilkan Nama', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
