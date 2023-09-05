import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart'; // Importa el paquete necesario

class NewConsultForm extends StatefulWidget {
  @override
  final String UserID; // Agrega esta variable
  final String PersonalID;
  NewConsultForm({required this.UserID, required this.PersonalID}); // Constructor que acepta userId

  _NewConsultFormState createState() => _NewConsultFormState();
}

class _NewConsultFormState extends State<NewConsultForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userIdController = TextEditingController();
  TextEditingController motivoController = TextEditingController();
  TextEditingController objetivosController = TextEditingController();
  TextEditingController recomendacionesController = TextEditingController();

  Future<void> _submitForm() async {
    
    if (_formKey.currentState!.validate()) {
      // Datos válidos, enviar la solicitud al servidor
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('d/M/yyyy').format(now);
      final formData = {
        'UserID': widget.UserID,
        'Motivo': motivoController.text.toUpperCase(),
        'Objetivos': objetivosController.text.toUpperCase(),
        'Recomendaciones': recomendacionesController.text.toUpperCase(),
        'Fecha': formattedDate,
        'PersonalID': widget.PersonalID,
      };

      final response = await http.post(
        Uri.parse('${Config.apiUrl}/api/Psicologia-Insert-NewConsult'),
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
  Widget build(BuildContext context) {
    String UserID = widget.UserID;
    String PersonalID = widget.PersonalID;
return Scaffold(
  appBar: AppBar(
    title: Text('Registrar una consulta'),
  ),
  body: SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 243, 243, 243),
            Color.fromARGB(159, 255, 255, 255), // Este valor establece la transparencia
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
              widthFactor: 1, // Ocupa el 65% del ancho de la pantalla
              child: TextFormField(
                controller: motivoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Motivo de consulta',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(207, 207, 207, 0.45),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 128, 123, 1),
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(26, 26, 26, 1),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese el motivo de consulta';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: 1, // Ocupa el 65% del ancho de la pantalla
              child: TextFormField(
                controller: objetivosController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Objetivos Terapéuticos',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(207, 207, 207, 0.45),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 128, 123, 1),
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(26, 26, 26, 1),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese los objetivos terapéuticos';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: 1, // Ocupa el 65% del ancho de la pantalla
              child: TextFormField(
                controller: recomendacionesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recomendaciones',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(207, 207, 207, 0.45),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(0, 128, 123, 1),
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(26, 26, 26, 1),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese las recomendaciones';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: 1, // Ocupa el 65% del ancho de la pantalla
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF1B8D71), // Color de fondo del botón
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
