import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config.dart';
import 'package:intl/intl.dart';

class RegistrarAsistenciaForm extends StatefulWidget {
  @override
  final String UserID;
  final String PersonalID;

  RegistrarAsistenciaForm({required this.UserID, required this.PersonalID});

  _RegistrarAsistenciaFormState createState() => _RegistrarAsistenciaFormState();
}

class _RegistrarAsistenciaFormState extends State<RegistrarAsistenciaForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userIdController = TextEditingController();
  TextEditingController motivoController = TextEditingController();
  TextEditingController objetivosController = TextEditingController();
  TextEditingController recomendacionesController = TextEditingController();
  List<String> talleres = []; // Variable para almacenar la lista de talleres
  String? _selectedTaller; // Variable para almacenar el valor seleccionado

  Future<void> _getTalleres() async {
    final response = await http.get(
      Uri.parse('${Config.apiUrl}/api/GetTalleres'), // Reemplaza con la URL de tu backend
    );

    if (response.statusCode == 200) {
      // Si la solicitud es exitosa, analiza la respuesta JSON
      final List<dynamic> data = json.decode(response.body);
      List<String> listaTalleres = [];
      for (var tallerData in data) {
        listaTalleres.add(tallerData['Nombre']); // Supongo que 'Nombre' es el nombre del taller en tu respuesta JSON
      }

      setState(() {
        talleres = listaTalleres;
      });
    } else {
      // Si la solicitud no es exitosa, maneja el error adecuadamente
      // Aquí puedes mostrar un mensaje de error al usuario o realizar cualquier otra acción necesaria.
    }
  }

Future<void> _submitForm() async {
  if (_formKey.currentState!.validate()) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('d/M/yyyy').format(now);

    // Datos válidos, enviar la solicitud al servidor
    final formData = {
      'TallerID': _selectedTaller, // Cambiar a TallerID
      'UserID': widget.UserID,
      'Fecha': formattedDate,
    };

    final response = await http.post(
      Uri.parse('${Config.apiUrl}/api/New-Assistance-Taller'),
      body: json.encode(formData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Consulta agregada con éxito
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Éxito'),
            content: Text('La consulta se agregó correctamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra la alerta
                  Navigator.of(context).pop(); // Regresa al menú anterior
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else {
      // Error al agregar la consulta
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No se pudo agregar la consulta.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }
}

  @override
  void initState() {
    super.initState();
    _getTalleres(); // Llama a _getTalleres al abrir la pantalla
  }

  @override
  Widget build(BuildContext context) {
    String UserID = widget.UserID;
    String PersonalID = widget.PersonalID;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar la asistencia'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 243, 243, 243),
                Color.fromARGB(159, 255, 255, 255),
              ],
              stops: [0, 0.5, 1.0],
              center: Alignment.center,
              focal: Alignment.center,
              focalRadius: 1,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Usuario : $UserID',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 17, 17, 17),
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: DropdownButton<String>(
                    value: _selectedTaller, // Usar _selectedTaller como valor seleccionado
                    onChanged: (String? newValue) {
                      // Actualizar _selectedTaller cuando se cambie la selección
                      setState(() {
                        _selectedTaller = newValue;
                      });
                    },
                    items: talleres
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF1B8D71),
                    ),
                    child: Text(
                      'Enviar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
