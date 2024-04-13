import 'package:flutter/material.dart';
import 'api.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<Map<String, dynamic>> _resep = [];

  @override
  void initState() {
    super.initState();
    _loadResep();
  }

  Future<void> _loadResep() async {
    try {
      final resep = await Api.getResep();
      setState(() {
        _resep = resep;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _updateResep(String id, Map<String, dynamic> updatedResep) async {
    try {
      await Api.updateResep(id, updatedResep);
      _loadResep();
    } catch (e) {
      print('Error updating recipe: $e');
    }
  }

  Future<void> _deleteResep(String id) async {
    try {
      await Api.deleteResep(id);
      _loadResep();
    } catch (e) {
      print('Error deleting recipe: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: ListView.builder(
        itemCount: _resep.length,
        itemBuilder: (context, index) {
          final resep = _resep[index];
          return Card(
            child: ListTile(
              title: Text(resep['nama']),
              subtitle: Text(resep['bahan']),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Edit Resep'),
                      content: Text('Apakah Anda ingin mengupdate resep ini?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            _updateResep(resep['id'], {
                              'nama': 'Nama Resep Baru',
                              'bahan': 'Bahan Resep Baru',
                              'tahapan': 'Tahapan Resep Baru',
                            }); // Update recipe
                            Navigator.of(context).pop();
                          },
                          child: Text('Update'),
                        ),
                      ],
                    );
                  },
                );
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Hapus Resep'),
                        content: Text('Apakah Anda ingin menghapus resep ini?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              _deleteResep(resep['id']); 
                              Navigator.of(context).pop();
                            },
                            child: Text('Hapus'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}