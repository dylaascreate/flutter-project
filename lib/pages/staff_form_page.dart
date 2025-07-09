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
        'name': _nameController.text.trim(),
        'id': _idController.text.trim(),
        'age': int.parse(_ageController.text.trim()),
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
      appBar: AppBar(
        title: const Text('Add Staff'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Staff Registration',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _idController,
                      decoration: _inputDecoration('Staff ID'),
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Enter ID';
                        if (val.length < 3) return 'ID must be at least 3 characters';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration('Name'),
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Enter name';
                        if (val.length < 3) return 'Name must be at least 3 characters';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _ageController,
                      decoration: _inputDecoration('Age'),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Enter age';
                        final age = int.tryParse(val);
                        if (age == null || age < 18 || age > 60) return 'Age must be between 18–60';
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _submitData,
                        icon: const Icon(Icons.send),
                        label: const Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
