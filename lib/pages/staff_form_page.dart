import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'staff_list_page.dart';

class StaffFormPage extends StatefulWidget {
  @override
  _StaffFormPageState createState() => _StaffFormPageState();
}

class _StaffFormPageState extends State<StaffFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _ageController = TextEditingController();

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('staff').add({
        'name': _nameController.text,
        'id': _idController.text,
        'age': int.parse(_ageController.text),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StaffListPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Staff')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'Staff ID'),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter ID';
                  if (val.length < 3) return 'ID must be at least 3 characters';
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter name';
                  if (val.length < 3) return 'Name must be at least 3 characters';
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter age';
                  final age = int.tryParse(val);
                  if (age == null || age < 18 || age > 100) return 'Age must be between 18–100';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
