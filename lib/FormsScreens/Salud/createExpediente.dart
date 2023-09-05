import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config.dart';
import 'package:intl/intl.dart';

class NewExpedienteSalud extends StatefulWidget {
  final String UserID;
  final String PersonalID;

  NewExpedienteSalud({required this.UserID, required this.PersonalID});

  @override
  _NewExpedienteSaludState createState() => _NewExpedienteSaludState();
}

class _NewExpedienteSaludState extends State<NewExpedienteSalud> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedPadecimiento = "Ninguna"; // Valor inicial

  // Lista de opciones de padecimientos
  final List<String> padecimientosOptions = [
    "Ninguna",
    "Diabetes",
    "Hipertensión arterial",
    "Enfermedades cardiovasculares",
    "Enfermedad pulmonar obstructiva crónica",
    "Asma",
    "Artritis",
    "Osteoporosis",
    "Trastornos de salud mental",
    "Enfermedades renales crónicas",
    "Cáncer",
    "Enfermedad de Alzheimer y/u otras formas de demencia",
    "Cirrosis",
    "Hepatitis crónica",
    "Esclerosis múltiple",
    "Fibromialgia",
  ];

  TextEditingController alergiasController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Obtén la fecha actual en el formato deseado
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('d/M/yyyy').format(now);

      // Construcción del formData
      final formData = {
        'UserID': widget.UserID,
        'PersonalID': widget.PersonalID,
        'Alergias': alergiasController.text,
        'Padecimientos': selectedPadecimiento,
      
      };

      final response = await http.post(
        Uri.parse('${Config.apiUrl}/api/Salud-Insert-NewExpedient'),
        body: json.encode(formData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Éxito'),
              content: Text('El expediente se agregó correctamente.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('No se pudo agregar el expediente.'),
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
        title: Text('Crear nuevo expediente'),
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
                  child: DropdownButtonFormField(
                    value: selectedPadecimiento,
                    onChanged: (newValue) {
                      setState(() {
                        selectedPadecimiento = newValue.toString();
                      });
                    },
                    items: padecimientosOptions.map((padecimiento) {
                      return DropdownMenuItem(
                        value: padecimiento,
                        child: Text(padecimiento),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Padecimientos',
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
                  ),
                ),
                SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: TextFormField(
                    controller: alergiasController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Alergias',
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
                        return 'Por favor, ingrese las alergias';
                      }
                      return null;
                    },
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
