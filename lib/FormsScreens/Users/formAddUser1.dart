import 'package:flutter/material.dart';

class FormAddUser1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Formulario de Agregar Usuario'),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Text(
            'Hola',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
