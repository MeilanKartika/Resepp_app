import 'package:flutter/material.dart';

class AkunSayaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun Saya'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Informasi Akun',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Nama: John Doe'),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email: johndoe@example.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Nomor Telepon: +1234567890'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Pengaturan Akun',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Ubah Kata Sandi'),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Ubah Bahasa'),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Pengaturan Notifikasi'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
