import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'staff_form_page.dart';

class StaffListPage extends StatelessWidget {
  final CollectionReference staffRef = FirebaseFirestore.instance.collection('staff');

  void _deleteStaff(String docId) {
    staffRef.doc(docId).delete();
  }

  void _showEditDialog(BuildContext context, DocumentSnapshot doc) {
    final nameCtrl = TextEditingController(text: doc['name']);
    final ageCtrl = TextEditingController(text: doc['age'].toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit ${doc['id']}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: ageCtrl, decoration: InputDecoration(labelText: 'Age'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('staff').doc(doc.id).update({
                'name': nameCtrl.text,
                'age': int.tryParse(ageCtrl.text) ?? doc['age'],
              });
              Navigator.pop(context);
            },
            child: Text('Update'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StaffFormPage()),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: staffRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error fetching data'));
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, index) {
              final doc = docs[index];
              final staff = doc.data() as Map<String, dynamic>;

              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
                ),
                child: ListTile(
                  title: Text('${staff['name']} (ID: ${staff['id']})', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Age: ${staff['age']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit, color: Colors.orange), onPressed: () => _showEditDialog(context, doc)),
                      IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteStaff(doc.id)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
