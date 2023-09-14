import 'package:flutter/material.dart';
import 'package:gasolinera_puma/Principal.dart';

import 'SQL/db.dart';

class Maps extends StatelessWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: drawerP(),
      appBar: AppBar(
        title: const Text('Gasolinera puma'),
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
        child: ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
            ),

            Lista(),
          ],
        )
      ],
    )),
  );
}

Widget cartas( String nombre, int ID ) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.local_gas_station,
                color: Colors.amberAccent,
                size: 40,
              ),
              title: Text(
                nombre
              ),
              subtitle: Text('Gasolineria Puma '+nombre),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Detalles'),
                  onPressed: () {/* ... */},
                ),
                TextButton(
                  child: const Text('Ver el mapa'),
                  onPressed: () {
                    //snackbar que muestre ID
                    ScaffoldMessenger.of(ContextP!).showSnackBar(
                      SnackBar(
                        content: Text('ID: $ID'),
                      ),
                    );
                  },
                ),
                
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget Lista() {
  return FutureBuilder<List<Map<String, dynamic>>>(
      future: Db.mostrarDepartamento(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error al cargar los datos');
        } else {
          List<Map<String, dynamic>> data = snapshot.data ?? [];
          List<String> nombres = data.map((item) => item['NOMBRE'] as String).toList();
          List<int> valores = data.map((item) => item['ID'] as int).toList();

          int cantidad=nombres.length;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(cantidad, (index) {
              return cartas(nombres[index],valores[index]);
            }),
          );

        }
      }
  );
}