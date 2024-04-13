import 'package:flutter/material.dart';
import 'package:resepp/crud.dart';
import 'package:resepp/resepsaya.dart';
import 'package:resepp/akunsaya.dart';
import 'package:resepp/setting.dart'; 
import 'package:resepp/dbhelper.dart'; 
import 'package:resepp/api.dart'; 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DBHelper _dbHelper = DBHelper();
  List<Map<String, dynamic>> _resep = [];

  @override
  void initState() {
    super.initState();
    _loadResep();
  }

  Future<void> _loadResep() async {
    try {
      final resepFromApi = await Api.getResep(); 
      final resepFromDB = await _dbHelper.queryAll(); 
      setState(() {
        _resep = [...resepFromApi, ...resepFromDB];
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _addResep(Map<String, dynamic> newResep) {
    setState(() {
      _resep.add(newResep);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('CRUD Page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CRUDPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Akun Saya'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/akunsaya');
              },
            ),
            ListTile(
              title: Text('Resep Saya'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/resepsaya');
              },
            ),
            ListTile(
              title: Text('Setting'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _resep.length,
        itemBuilder: (context, index) {
          final resep = _resep[index];
          return Card(
            child: ListTile(
              title: Text(resep[DBHelper.COLUMN_NAME]),
              subtitle: Text(resep[DBHelper.COLUMN_INGREDIENTS]),
              onTap: () {
                // Navigasi ke halaman detail resep
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CRUDPage(),
            ),
          ).then((result) {
            if (result != null && result is Map<String, dynamic>) {
              _addResep(result);
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
