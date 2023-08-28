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
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final String passSinHash = _passwordController.text;
    String email = _emailController.text;
    String password = calculateHash(passSinHash);

    //String email = "administradora@dif.com";

    // mostrar
    print("email: $email");
    print("pass: $password"); // Agrega ':' después de "pass"
 print("pass: $passSinHash"); // Agrega ':' después de "pass"
 
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
      } else {
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
      backgroundColor: Color.fromRGBO(0, 128, 123, 1),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/logoSup.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                padding: EdgeInsets.all(16.0),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 25.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 45.0,
                          top: 30), // Agregar margen inferior al logo
                      child:
                          Image.asset('lib/assets/logo.png'), // Agregar el logo
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Correo electrónico',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              filled: true,
                              fillColor: Color.fromRGBO(207, 207, 207, 0.45),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 128, 123, 1)),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(26, 26, 26, 1)),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, ingrese su correo electrónico';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25.0),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Contraseña',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              filled: true,
                              fillColor: Color.fromRGBO(207, 207, 207, 0.45),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 128, 123, 1)),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(26, 26, 26, 1)),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, ingrese su contraseña';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    Size(double.infinity, 48.0)),
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromRGBO(0, 128, 123, 1)),
                                foregroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 0, 0, 0)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _login(); // Llamar a la función de inicio de sesión
                                }
                              },
                              child: const Text('Iniciar sesión'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
