import 'package:flutter/material.dart';
import 'package:resepp/dbhelper.dart';
import 'package:resepp/crud.dart';

class ResepSayaPage extends StatefulWidget {
  @override
  _ResepSayaPageState createState() => _ResepSayaPageState();
}

class _ResepSayaPageState extends State<ResepSayaPage> {
  final DBHelper _dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Saya Page'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbHelper.queryAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> recipes = snapshot.data ?? [];
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> recipe = recipes[index];
                return Card(
                  child: ListTile(
                    title: Text(recipe[DBHelper.COLUMN_NAME] ?? ''),
                    subtitle: Text(recipe[DBHelper.COLUMN_INGREDIENTS] ?? ''),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CRUDPage(initialData: recipe),
                        ),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteRecipe(recipe);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _deleteRecipe(Map<String, dynamic> recipe) async {
    String name = recipe[DBHelper.COLUMN_NAME];
    int result = await _dbHelper.delete(name);

    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recipe deleted successfully'),
        ),
      );
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete recipe'),
        ),
      );
    }
  }
}
