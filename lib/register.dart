import 'package:flutter/material.dart';
import 'package:gasolinera_puma/SQL/db.dart';
import 'package:gasolinera_puma/main.dart';

import 'login.dart';

BuildContext? ContextoR;

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContextoR = context;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: drawers(),
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
      child: Formulario(),
    ),
  );
}

Widget drawers() {
  return Drawer(
    // Agrega un ListView al drawer. Esto asegura que el usuario pueda desplazarse
    // a través de las opciones en el Drawer si no hay suficiente espacio vertical
    // para adaptarse a todo.
    child: ListView(
      // Importante: elimina cualquier padding del ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            'Menu',
            style: TextStyle(color: Colors.white),
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
          leading: Icon(Icons.login_sharp),
          title: Text('Inicio de sesion'),
          onTap: () {
            Navigator.push(
                Contexto!, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
        ListTile(
          leading: Icon(Icons.person_add_alt_1_sharp),
          title: Text('Registrarse'),
          onTap: () {
            Navigator.push(
                Contexto!, MaterialPageRoute(builder: (context) => Register()));
          },
        ),
      ],
    ),
  );
}

final Controlleremail = TextEditingController();
final Controllerpassword = TextEditingController();
final Controllertelefono = TextEditingController();
final ControllerUser= TextEditingController();
Widget Formulario() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.symmetric(vertical:10),
      ),
      Text(
        'REGISTRO',
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
      Image.asset(
        'assets/logo.png',
        width: 200,
      ),
      Text(
        'Rellene los campos',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Padding(
            padding:EdgeInsets.symmetric(horizontal:15.00),
            child: TextField(
              keyboardType:
              TextInputType.text,
              controller: ControllerUser,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  labelText: 'Nombre de usuario',
                  hintText: 'Juan Carlos Bodoque',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
            ),
          ),

        ]
      ),
      Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.00),
            child: TextField(
              keyboardType:
                  TextInputType.text,
              controller: Controlleremail,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.question_mark,
                    color: Colors.white,
                  ),
                  labelText: 'Correo electronico o Numero de Dui',
                  hintText: 'Carlosgeek503@gmail.com',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 6.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  keyboardType:
                      TextInputType.visiblePassword,
                  controller: Controllerpassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.white,
                      ),
                      labelText: 'Contraseña',
                      hintText: '*************',
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                ),
              ),

              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                      keyboardType:
                          TextInputType.phone,
                      controller: Controllertelefono,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          labelText: 'Numero de telefono',
                          hintText: '7168-0706',
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white)),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      datos();
                    },
                    child: const Text('Registrate'),
                  ),
                ],
              )
            ],
          )
        ],
      )
    ],
  );
}

void limpieza() {
  Controlleremail.clear();
  Controllerpassword.clear();
  Controllertelefono.clear();
  ControllerUser.clear();
}

//Registro de datos
void datos() {
  String user = ControllerUser.text;
  String email = Controlleremail.text;
  String password = Controllerpassword.text;
  String telefono = Controllertelefono.text;
  if (email.isEmpty || password.isEmpty || telefono.isEmpty || user.isEmpty) {
    ScaffoldMessenger.of(ContextoR!).showSnackBar(SnackBar(
        content:
        Text('Todos los campos son obligatorios')));
  } else {
    Db.Validacion(email).then((value) {
      if (value == true) {
        ScaffoldMessenger.of(Contexto!).showSnackBar(
            SnackBar(
                content: Text(
                    'Existe el Correo electronico')));
      } else {
        Db.insertar(user, email, password, telefono);
        limpieza();
        Navigator.push(ContextoR!,
            MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }
}