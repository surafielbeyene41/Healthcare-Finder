import 'package:flutter/material.dart';

class EmergencyTile extends StatelessWidget {
  final String name;
  final String number;

  const EmergencyTile({super.key, required this.name, required this.number});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(number),
      trailing: IconButton(
        icon: Icon(Icons.phone),
        onPressed: () {
          // Call the emergency number
        },
      ),
    );
  }
}