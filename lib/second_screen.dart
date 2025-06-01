import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Details'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: args == null
          ? const Center(
              child: Text(
                'No data received.',
                style: TextStyle(color: Colors.black),
              ),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Table(
                  border: TableBorder.all(
                    color: Colors.deepPurple,
                    width: 1.5,
                  ),
                  columnWidths: const {
                    0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    _buildRow('Name', args['name']),
                    _buildRow('Age', args['age']),
                    _buildRow(
                      'Date of Birth',
                      args['dateOfBirth'] is DateTime
                          ? DateFormat('yyyy-MM-dd').format(args['dateOfBirth'])
                          : args['dateOfBirth'].toString().split(' ')[0],
                    ),
                    _buildRow('Gender', args['gender']),
                  ],
                ),
              ),
            ),
    );
  }

  TableRow _buildRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            '$label:',
            style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ],
    );
  }
}
