import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config.dart';
import 'package:intl/intl.dart';

class NewConsultSalud extends StatefulWidget {
  final String UserID;
  final String PersonalID;

  NewConsultSalud({required this.UserID, required this.PersonalID});

  @override
  _NewConsultSaludState createState() => _NewConsultSaludState();
}

class _NewConsultSaludState extends State<NewConsultSalud> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController frecuenciaCardiacaController = TextEditingController();
  TextEditingController frecuenciaRespiratoriaController = TextEditingController();
  TextEditingController glucosaController = TextEditingController();
  TextEditingController satOxigenoController = TextEditingController();
  TextEditingController presionArterialController = TextEditingController();
  TextEditingController medicacionController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('d/M/yyyy').format(now);

      // Construcción del formData
      final formData = {
        'UserID': widget.UserID,
        'PersonalID': widget.PersonalID,
        'FrecuenciaCardiaca': frecuenciaCardiacaController.text,
        'FrecuenciaRespiratoria': frecuenciaRespiratoriaController.text,
        'Glucosa': glucosaController.text,
        'SatOxigeno': satOxigenoController.text,
        'PresionArterial': presionArterialController.text,
        'Medicacion': medicacionController.text,
        'Fecha': formattedDate,
      };

      final response = await http.post(
        Uri.parse('${Config.apiUrl}/api/Salud-Insert-NewConsult'),
        body: json.encode(formData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Éxito'),
              content: Text('La consulta se agregó correctamente.'),
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
        title: Text('Crear nueva consulta de salud'),
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
                  child: TextFormField(
                    controller: frecuenciaCardiacaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Frecuencia Cardíaca',
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
                        return 'Por favor, ingrese la frecuencia cardíaca';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: TextFormField(
                    controller: frecuenciaRespiratoriaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Frecuencia Respiratoria',
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
                        return 'Por favor, ingrese la frecuencia respiratoria';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: TextFormField(
                    controller: glucosaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Glucosa',
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
                        return 'Por favor, ingrese el nivel de glucosa';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: TextFormField(
                    controller: satOxigenoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Saturación de Oxígeno',
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
                        return 'Por favor, ingrese la saturación de oxígeno';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: TextFormField(
                    controller: presionArterialController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Presión Arterial',
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
                        return 'Por favor, ingrese la presión arterial';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: TextFormField(
                    controller: medicacionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Medicación',
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
                        return 'Por favor, ingrese la medicación';
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
