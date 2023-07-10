import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../Roles/Admin/admin_screen.dart'; // Importar la clase AdminScreen
import '../Roles/Enfermera/enfermeria_menu.dart'; // Importar la clase AdminScreen
import '../Roles/Instructora/instructora_menu.dart'; // Importar la clase AdminScreen
import '../Roles/Psicologa/psicologa_menu.dart'; // Importar la clase AdminScreen
import '../Roles/Recepcion/recepcion_menu.dart'; // Importar la clase AdminScreen

import '../hashPass.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final String email = _emailController.text;
    final String passSinHash = _passwordController.text;
    String password = calculateHash(passSinHash);

 //mostrar
    print("email: " + email);
    print("pass " + password);

    final response = await http.post(
      Uri.parse('${Config.apiUrl}/api/loginNormal'),
      body: {
        'email': email,
        'password': password,
      },
    );

   


    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final String role = responseData['role'];

      //////////////////////////////////////////// enfermeria
      if (role == 'Enfermería') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EnfermeriaScreen()),
        );
      } 
          //////////////////////////////////////////// administracion
      if (role == 'Administración') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminScreen()),
        );
      } 
          //////////////////////////////////////////// recepcion
      if (role == 'Recepción') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RecepcionScreen()),
        );
      } 
          //////////////////////////////////////////// instructor
      if (role == 'Instructor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => InstructoraScreen()),
        );
      } 
          //////////////////////////////////////////// instructor
      if (role == 'Psicología') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PsicoScreen()),
        );
      } 


      else {
        // Redirigir a otras pantallas según los roles necesarios
      }
    } else {
      setState(() {
        _errorMessage = 'Credenciales inválidas';
      });
    }
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese su correo electrónico';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese su contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login();
                  }
                },
                child: const Text('Iniciar sesión'),
              ),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }



}
