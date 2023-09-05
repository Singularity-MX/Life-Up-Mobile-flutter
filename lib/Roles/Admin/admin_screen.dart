import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../FormsScreens/Users/formAddUser1.dart';
import '../../FormsScreens/QR/utilQR.dart';
import '../../LoginUser/login_form.dart'; // Importa la clase LoginForm desde el archivo correspondiente

import '../../FormsScreens/Psicologia/newConsult.dart';
import '../../FormsScreens/Psicologia/searchPsicology.dart';
import '../../FormsScreens/Actividades/searchActivities.dart';

import '../../FormsScreens/Salud/searchConsultSalud.dart';
import '../../FormsScreens/Salud/searchExpedienteSalud.dart';

enum MenuSection {
  Home,
  Users,
  Health,
  Psychology,
  Activities,
}

class MenuItem {
  final MenuSection section;
  final IconData icon;

  MenuItem({required this.section, required this.icon});
}

final List<MenuItem> menuItems = [
  MenuItem(section: MenuSection.Home, icon: Icons.home),
  MenuItem(section: MenuSection.Users, icon: Icons.person),
  MenuItem(section: MenuSection.Health, icon: Icons.favorite),
  MenuItem(section: MenuSection.Psychology, icon: Icons.lightbulb_outline),
  MenuItem(section: MenuSection.Activities, icon: Icons.directions_run),
];

class AdminScreen extends StatefulWidget {
  final String personalID; // Agrega esta variable

  AdminScreen({required this.personalID}); // Constructor que acepta userId

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  MenuSection currentSection = MenuSection.Home;
  CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgFondo.png'), // Ruta de la imagen
            fit: BoxFit.cover, // Ajustar la imagen al tamaño del contenedor
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: getScreenWidget(currentSection),
              ),
            ),
            SizedBox(height: 10), // Espacio adicional entre el menú y el texto
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 70.0,
                aspectRatio: 1.0,
                viewportFraction: 0.2,
                enlargeCenterPage: true,
                onPageChanged: (index, _) {
                  setState(() {
                    currentSection = menuItems[index].section;
                  });
                },
              ),
              items: menuItems.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        int newIndex = menuItems.indexOf(item);
                        _carouselController.animateToPage(newIndex);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: currentSection == item.section ? 6 : 4,
                        color: currentSection == item.section
                            ? Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(0, 128, 123, 1),
                        child: Center(
                          child: Icon(
                            item.icon,
                            color: currentSection == item.section
                                ? const Color.fromRGBO(0, 128, 123, 1)
                                : const Color.fromRGBO(0, 34, 33, 1),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                getMenuSectionTitle(currentSection),
                style: TextStyle(
                  fontSize: 20, // Tamaño de fuente de 20
                  fontWeight: FontWeight.w300, // Inter Light
                  color: const Color.fromARGB(
                      255, 255, 255, 255), // Cambia el color aquí
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getScreenWidget(MenuSection section) {
     String ID = widget.personalID;
    switch (section) {
      case MenuSection.Home:
        return Container(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: Offset(
                  0.0, -0.1), // Mueve el contenido hacia arriba en un 20%
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        20.0), // Agrega un margen lateral de 20 unidades
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: Colors
                                .white, // Cambia el color del icono a blanco
                          ),
                          onPressed: () {
                            // Agrega aquí la lógica para cerrar sesión
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginForm()), // Redirige al inicio de sesión
                            );
                          },
                        ),
                        // Otros elementos de la fila si los tienes
                      ],
                    ),
                    Text(
                      'Bienvenidos a',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        fontWeight:
                            FontWeight.w100, // FontWeight para Extra Light
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${getMenuSectionTitle(currentSection)}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 36,
                        fontWeight: FontWeight.w600, // FontWeight para Semibold
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Esta es una app que te permite realizar el registro en los diferentes módulos del sistema de Life-Up',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.justify, // Justificar el texto
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

      case MenuSection.Users:
        return Container(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: Offset(
                  0.0, -0.0), // Mueve el contenido hacia arriba en un 20%
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        20.0), // Agrega un margen lateral de 20 unidades
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: Colors
                                .white, // Cambia el color del icono a blanco
                          ),
                          onPressed: () {
                            // Agrega aquí la lógica para cerrar sesión
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginForm()), // Redirige al inicio de sesión
                            );
                          },
                        ),
                        // Otros elementos de la fila si los tienes
                      ],
                    ),
                    Text(
                      'Bienvenidos a',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        fontWeight:
                            FontWeight.w100, // FontWeight para Extra Light
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${getMenuSectionTitle(currentSection)}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 36,
                        fontWeight: FontWeight.w600, // FontWeight para Semibold
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Este apartado te permite registrar nuevos usuarios a Life-Up, solicitamos información personal, un el contacto de emergencia del adulto mayor.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.justify, // Justificar el texto
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFD9D9D9), // Color de fondo
                          onPrimary: const Color(0xFF161616), // Color del texto
                          padding: EdgeInsets.all(12), // Espaciado interno
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // Border radius de 15
                          ),
                        ),
                        child: Text(
                          'Proximamente...',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w100, // FontWeight para Extra Light
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

      case MenuSection.Health:
        return Container(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: Offset(
                  0.0, -0.0), // Mueve el contenido hacia arriba en un 20%
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        20.0), // Agrega un margen lateral de 20 unidades
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: Colors
                                .white, // Cambia el color del icono a blanco
                          ),
                          onPressed: () {
                            // Agrega aquí la lógica para cerrar sesión
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginForm()), // Redirige al inicio de sesión
                            );
                          },
                        ),
                        // Otros elementos de la fila si los tienes
                      ],
                    ),
                    Text(
                      'Bienvenidos a',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        fontWeight:
                            FontWeight.w100, // FontWeight para Extra Light
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${getMenuSectionTitle(currentSection)}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 36,
                        fontWeight: FontWeight.w600, // FontWeight para Semibold
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Este apartado te permite registrar las consultas médicas y los expedientes de los usuarios registrados.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.justify, // Justificar el texto
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchExpedienteSalud(personalID: ID)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFD9D9D9), // Color de fondo
                          onPrimary: const Color(0xFF161616), // Color del texto
                          padding: EdgeInsets.all(12), // Espaciado interno
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // Border radius de 15
                          ),
                        ),
                        child: Text(
                          'Crear un expediente',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w100, // FontWeight para Extra Light
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchConsultSalud(personalID: ID)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFD9D9D9), // Color de fondo
                          onPrimary: const Color(0xFF161616), // Color del texto
                          padding: EdgeInsets.all(12), // Espaciado interno
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // Border radius de 15
                          ),
                        ),
                        child: Text(
                          'Crear una consulta',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w100, // FontWeight para Extra Light
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

      case MenuSection.Psychology:
       
        return Container(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: Offset(
                  0.0, -0.0), // Mueve el contenido hacia arriba en un 20%
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        20.0), // Agrega un margen lateral de 20 unidades
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: Colors
                                .white, // Cambia el color del icono a blanco
                          ),
                          onPressed: () {
                            // Agrega aquí la lógica para cerrar sesión
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginForm()), // Redirige al inicio de sesión
                            );
                          },
                        ),
                        // Otros elementos de la fila si los tienes
                      ],
                    ),
                    Text(
                      'Bienvenidos a',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        fontWeight:
                            FontWeight.w100, // FontWeight para Extra Light
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${getMenuSectionTitle(currentSection)}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 36,
                        fontWeight: FontWeight.w600, // FontWeight para Semibold
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Recuerda que la salud mental de tus usuarios es vital para que vivan plenamente, aquí puedes registrar las consultas con ellos. ',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.justify, // Justificar el texto
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchPsicologyScreen(personalID: ID)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFD9D9D9), // Color de fondo
                          onPrimary: const Color(0xFF161616), // Color del texto
                          padding: EdgeInsets.all(12), // Espaciado interno
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // Border radius de 15
                          ),
                        ),
                        child: Text(
                          'Crear consulta',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w100, // FontWeight para Extra Light
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

      case MenuSection.Activities:
        return Container(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: Offset(
                  0.0, -0.0), // Mueve el contenido hacia arriba en un 20%
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        20.0), // Agrega un margen lateral de 20 unidades
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: Colors
                                .white, // Cambia el color del icono a blanco
                          ),
                          onPressed: () {
                            // Agrega aquí la lógica para cerrar sesión
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginForm()), // Redirige al inicio de sesión
                            );
                          },
                        ),
                        // Otros elementos de la fila si los tienes
                      ],
                    ),
                    Text(
                      'Bienvenidos a',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        fontWeight:
                            FontWeight.w100, // FontWeight para Extra Light
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${getMenuSectionTitle(currentSection)}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 36,
                        fontWeight: FontWeight.w600, // FontWeight para Semibold
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Este apartado te permite registrar la asistencia de tus pacientes en las actividades y talleres que se realicen en los centros gerontológicos.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Cambia el color aquí
                      ),
                      textAlign: TextAlign.justify, // Justificar el texto
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchActivitiesScreen(personalID: ID)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFD9D9D9), // Color de fondo
                          onPrimary: const Color(0xFF161616), // Color del texto
                          padding: EdgeInsets.all(12), // Espaciado interno
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // Border radius de 15
                          ),
                        ),
                        child: Text(
                          'Registrar asistencia',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w100, // FontWeight para Extra Light
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

      default:
        return Container();
    }
  }

  String getMenuSectionTitle(MenuSection section) {
    switch (section) {
      case MenuSection.Home:
        return 'Life-Up';
      case MenuSection.Users:
        return 'Usuarios';
      case MenuSection.Health:
        return 'Salud';
      case MenuSection.Psychology:
        return 'Psicología';
      case MenuSection.Activities:
        return 'Actividades';
      default:
        return '';
    }
  }
}
