import '../../config.dart';
import './createExpediente.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchExpedienteSalud extends StatefulWidget {
  @override
  final String personalID; // Agrega esta variable

  SearchExpedienteSalud(
      {required this.personalID}); // Constructor que acepta userId

  _SearchExpedienteSaludState createState() => _SearchExpedienteSaludState();
}

class _SearchExpedienteSaludState extends State<SearchExpedienteSalud> {
  TextEditingController _usernameController = TextEditingController();
  String _searchResult = '';

  Future<void> searchUser() async {
    final username = _usernameController.text;
    String PersonalID = widget.personalID;
    // Realiza una solicitud HTTP al backend para buscar el usuario
    final response = await http.get(
      Uri.parse('${Config.apiUrl}/api/app-verify?username=$username'),
    );

    if (response.statusCode == 200) {
      // El usuario existe en el backend
      setState(() {
        _searchResult = 'El usuario "$username" existe en el backend.';
      });

      // Navegar a Ejemplo()
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NewExpedienteSalud(UserID: username, PersonalID: PersonalID)),
      );
    } else {
      // El usuario no existe en el backend
      setState(() {
        _searchResult = 'El usuario "$username" no existe en el backend.';
      });

      // Regresar atrás
      //Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String personalID = widget.personalID;

    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Usuario Salu $personalID'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                hintText: 'Ingrese el nombre de usuario',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                searchUser(); // Llama a la función para buscar al usuario
              },
              child: Text('Buscar'),
            ),
            SizedBox(height: 20),
            Text(_searchResult), // Muestra el resultado de la búsqueda
          ],
        ),
      ),
    );
  }
}

void main() {
  final String personalID =
      "valor_de_personalID"; // Reemplaza con el valor real de personalID
  runApp(MaterialApp(
    home: SearchExpedienteSalud(personalID: personalID),
  ));
}
