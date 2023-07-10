import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de administrador'),
      ),
      body: const Center(
        child: Text('Admin'),
      ),
    );
  }
}
