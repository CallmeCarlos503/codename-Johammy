import 'package:flutter/material.dart';
import 'package:gasolinera_puma/perfil.dart';
import 'package:gasolinera_puma/register.dart';
import 'login.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'maps.dart';

BuildContext? ContextP;
CarouselController buttonCarouselController = CarouselController();

class Principal extends StatelessWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContextP = context;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: drawerP(),
      appBar: AppBar(
        title: const Text('Gasolinera Puma'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: background(),
    );
  }
}

Widget background() {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/fondo.jpg'),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
      ),
    ),
    child: Center(
      child: anunciantes(),
    ),
  );
}

Widget anunciantes() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      CarouselSlider(
        options: CarouselOptions(height: 300.0, autoPlay: true),
        items: [1, 2, 3, 4, 5].map((i) {
          return GestureDetector(
            onTap: () {
              //snackbar
              ScaffoldMessenger.of(ContextP!).showSnackBar(SnackBar(
                content: Text('Promociones patrocinados por super 7'),
              ));
            },
            child: Container(
              width: 300,
              height: 300,
              //margin
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/promos/promos$i.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}

Widget drawerP() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            'BIENVENIDO',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'assets/fondo.jpg',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.darken),
          )),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Pagina Principal'),
          onTap: () {
            Navigator.push(ContextP!,
                MaterialPageRoute(builder: (context) => Principal()));
          },
        ),
        ListTile(
          leading: Icon(Icons.map_rounded),
          title: Text('Mapa'),
          onTap: () {
            Navigator.push(
                ContextP!, MaterialPageRoute(builder: (context) => Maps()));
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Perfil'),
          onTap: () {
            Navigator.push(
                ContextP!, MaterialPageRoute(builder: (context) => Perfil()));
          },
        ),
      ],
    ),
  );
}
