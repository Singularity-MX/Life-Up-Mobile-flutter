import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../FormsScreens/Users/formAddUser1.dart';

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
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: getScreenWidget(currentSection),
              ),
            ),
            SizedBox(height: 20), // Espacio adicional entre el menú y el texto
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 80.0,
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
                            ? Colors.blue
                            : Colors.white,
                        child: Center(
                          child: Icon(
                            item.icon,
                            color: currentSection == item.section
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Text(
              getMenuSectionTitle(currentSection),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget getScreenWidget(MenuSection section) {
    switch (section) {
      case MenuSection.Home:
        return Container(
          color: Colors.green,
          child: Column(
            children: [
              Text(
                'Bienvenidos a ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '${getMenuSectionTitle(currentSection)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tempor, velit vitae auctor convallis, sem dolor sodales turpis, sed rutrum justo nunc non magna.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),

            ],
          ),
        );
      case MenuSection.Users:
        return Container(
          color: Colors.blue,
          child: Column(
            children: [
              Text(
                'Bienvenidos a ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '${getMenuSectionTitle(currentSection)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tempor, velit vitae auctor convallis, sem dolor sodales turpis, sed rutrum justo nunc non magna.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FormAddUser1()),
                    );
                  },
                  child: Text('Abrir pantalla FormAddUser1'),
                ),
              )
            ],
          ),
        );
      case MenuSection.Health:
        return Container(
          color: Colors.red,
          child: Center(
            child: Text('Pantalla de salud'),
          ),
        );
      case MenuSection.Psychology:
        return Container(
          color: Colors.yellow,
          child: Center(
            child: Text('Pantalla de psicología'),
          ),
        );
      case MenuSection.Activities:
        return Container(
          color: Colors.orange,
          child: Center(
            child: Text('Pantalla de actividades'),
          ),
        );
      default:
        return Container();
    }
  }

  String getMenuSectionTitle(MenuSection section) {
    switch (section) {
      case MenuSection.Home:
        return 'Inicio';
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
