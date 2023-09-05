import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import './newConsult.dart';

class SearchPsicologyScreen extends StatefulWidget {
  final String personalID; // Agrega esta variable

  SearchPsicologyScreen({required this.personalID});

  @override
  _SearchPsicologyScreenState createState() => _SearchPsicologyScreenState();
}

class _SearchPsicologyScreenState extends State<SearchPsicologyScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escáner QR'),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
     final username = scanData.code ?? ""; // Usar un valor predeterminado si es nulo
final personalID = widget.personalID ?? ""; // Usar un valor predeterminado si es nulo

// Resto del código...


      // Realiza una solicitud HTTP al backend para buscar el usuario
      final response = await http.get(
        Uri.parse('${Config.apiUrl}/api/app-verify?username=$username'),
      );

      if (response.statusCode == 200) {
        // El usuario existe en el backend
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NewConsultForm(UserID: username, PersonalID: personalID),
          ),
        );
      } else {
        // El usuario no existe en el backend
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Usuario No Encontrado'),
              content: Text('El usuario "$username" no existe en el backend.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cerrar'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
