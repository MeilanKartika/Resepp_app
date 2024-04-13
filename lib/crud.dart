import 'package:flutter/material.dart';
import 'package:resepp/dbhelper.dart';
import 'package:resepp/resepsaya.dart';

class CRUDPage extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  CRUDPage({this.initialData});

  @override
  _CRUDPageState createState() => _CRUDPageState();
}

class _CRUDPageState extends State<CRUDPage> {
  final DBHelper _dbHelper = DBHelper();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _stepsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _nameController.text = widget.initialData![DBHelper.COLUMN_NAME] ?? '';
      _ingredientsController.text = widget.initialData![DBHelper.COLUMN_INGREDIENTS] ?? '';
      _stepsController.text = widget.initialData![DBHelper.COLUMN_STEPS] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialData != null ? 'Edit Recipe' : 'Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ingredientsController,
                decoration: InputDecoration(
                  labelText: 'Bahan',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the ingredients';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stepsController,
                decoration: InputDecoration(
                  labelText: 'Tahapan',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the steps';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.initialData != null) {
                        await _updateRecipe();
                      } else {
                        await _addRecipe();
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(widget.initialData != null ? 'Update Recipe' : 'Add Recipe'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addRecipe() async {
    String name = _nameController.text.trim();
    String ingredients = _ingredientsController.text.trim();
    String steps = _stepsController.text.trim();

    Map<String, dynamic> recipe = {
      DBHelper.COLUMN_NAME: name,
      DBHelper.COLUMN_INGREDIENTS: ingredients,
      DBHelper.COLUMN_STEPS: steps,
    };

    int result = await _dbHelper.insert(recipe);

    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recipe added successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add recipe'),
        ),
      );
    }
  }

  Future<void> _updateRecipe() async {
    String name = _nameController.text.trim();
    String ingredients = _ingredientsController.text.trim();
    String steps = _stepsController.text.trim();

    Map<String, dynamic> recipe = {
      DBHelper.COLUMN_NAME: name,
      DBHelper.COLUMN_INGREDIENTS: ingredients,
      DBHelper.COLUMN_STEPS: steps,
    };

    int result = await _dbHelper.update(recipe);

    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recipe updated successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update recipe'),
        ),
      );
    }
  }
}
