import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {

      static String tabla1="CREATE TABLE USUARIOS (ID INTEGER,NOMBRE TEXT NOT NULL,CORREO TEXT NOT NULL,PASSWORD TEXT NOT NULL,TELEFONO TEXT NOT NULL, ID_ESTADOS INTEGER NOT NULL, ID_ROL INTEGER NOT NULL,PRIMARY KEY(ID AUTOINCREMENT));";
      static String tabla2="CREATE TABLE ESTADOS (ID INTEGER,NOMBRE TEXT NOT NULL,PRIMARY KEY(ID AUTOINCREMENT));";
      static String tabla3="CREATE TABLE ROL (ID INTEGER,NOMBRE TEXT NOT NULL,PRIMARY KEY(ID AUTOINCREMENT));";
      static String tabla4="CREATE TABLE AREAS(ID INTEGER,NOMBRE TEXT NOT NULL,ID_ESTADOS INTEGER,PRIMARY KEY(ID AUTOINCREMENT));";
      static String tabla5= "CREATE TABLE TIPO_GAS(ID INTEGER,NOMBRE TEXT NOT NULL,ID_ESTADOS INTEGER,PRIMARY KEY(ID AUTOINCREMENT));";
      static String tabla6= "CREATE TABLE PROMOS(ID INTEGER,NOMBRE TEXT NOT NULL,IMAGEN TEXT NOT NULL,ID_ESTADOS INTEGER,PRIMARY KEY(ID AUTOINCREMENT));";
      static String tabla7= "CREATE TABLE GASOLINA(ID INTEGER,NOMBRE TEXT NOT NULL,PRECIO DECIMAL(2,4) NOT NULL,ID_AREA INTEGER,ID_TIPO_GAS INTEGER,PRIMARY KEY(ID AUTOINCREMENT));";
      static String tabla8= "CREATE TABLE DEPARTAMENTO(ID INTEGER,NOMBRE TEXT NOT NULL,ID_AREA INTEGER,COORDENADAS TEXT,PRIMARY KEY(ID AUTOINCREMENT));";
      static String insert1="INSERT INTO ROL(ID, NOMBRE) VALUES (1, 'Administrador');";
      static String insert2="INSERT INTO ROL(ID, NOMBRE) VALUES (2, 'Usuario');";
      static String insert3="INSERT INTO ESTADOS(ID, NOMBRE) VALUES (1, 'Activo');";
      static String insert4="INSERT INTO ESTADOS(ID, NOMBRE) VALUES (2, 'Inactivo');";
      //insert para departamento
      static String insert5="INSERT INTO DEPARTAMENTO(NOMBRE,ID_AREA,COORDENADAS) VALUES ('Nejapa', 1,'123,145,123');";
      static String insert6="INSERT INTO DEPARTAMENTO(NOMBRE,ID_AREA,COORDENADAS) VALUES ('Apopa', 2,'123,145,123');";
      static String insert7="INSERT INTO DEPARTAMENTO(NOMBRE,ID_AREA,COORDENADAS) VALUES ('Ahuachapan', 3,'123,145,123');";
      static String insert8="INSERT INTO DEPARTAMENTO(NOMBRE,ID_AREA,COORDENADAS) VALUES ('San Salvador', 4,'123,145,123');";
      static String insert9="INSERT INTO DEPARTAMENTO(NOMBRE,ID_AREA,COORDENADAS) VALUES ('Santa Rosa', 5,'123,145,123');";
      static String Nombre="";
      static String Correo="";
      static String Telefono="";
      // map dynamic de promos de la clase promos

     
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'puma.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(tabla1);
        await db.execute(tabla2);
        await db.execute(tabla3);
        await db.execute(tabla4);
        await db.execute(tabla5);
        await db.execute(tabla6);
        await db.execute(tabla7);
        await db.execute(tabla8);
        await db.execute(insert1);
        await db.execute(insert2);
        await db.execute(insert3);
        await db.execute(insert4);
        await db.execute(insert5);
        await db.execute(insert6);
        await db.execute(insert7);
        await db.execute(insert8);
        await db.execute(insert9);
      },
    );
  }
  //CRUD DE USUARIO
  //INSERTAR
  static Future<void> insertar(
      String nombre, String correo, String password, String telefono) async {
    Database db = await _openDB();
    await db.insert('USUARIOS', {
      'NOMBRE': nombre,
      'CORREO': correo,
      'PASSWORD': password,
      'TELEFONO': telefono,
      'ID_ESTADOS': 1,
      'ID_ROL': 2
    });
    db.close();
  }

  //ELIMINAR
  static Future<void> eliminar(int id) async {
    Database db = await _openDB();
    await db.delete('USUARIOS', where: 'ID =?', whereArgs: [id]);
    db.close();
  }

  //MODIFICAR
  static Future<void> modificar(int id, String nombre, String correo,
      String password, String telefono) async {
    Database db = await _openDB();
    await db.update(
      'USUARIOS',
      {
        'NOMBRE': nombre,
        'CORREO': correo,
        'PASSWORD': password,
        'TELEFONO': telefono,
      },
      where: 'ID =?',
      whereArgs: [id],
    );
    db.close();
  }

  //CONSULTAR
  static Future<List<Map<String, dynamic>>> consultar() async {
    Database db = await _openDB();
    List<Map<String, dynamic>> data = await db.query('USUARIOS');
    db.close();
    return data;
  }

  //LOGIN
  static Future<bool> login(String correo, String password) async {
    Database db = await _openDB();
    List<Map<String, dynamic>> data = await db.query('USUARIOS');
    db.close();
    for (int i = 0; i < data.length; i++) {
      if (data[i]['CORREO'] == correo && data[i]['PASSWORD'] == password) {
          Nombre= data[i]['NOMBRE'];
          Correo = data[i]['CORREO'];
          Telefono = data[i]['TELEFONO'];
        return true;
      }
    }
    return false;
  }
      static Future<bool> Validacion(String correo) async {
        Database db = await _openDB();
        List<Map<String, dynamic>> data = await db.query('USUARIOS');
        db.close();
        for (int i = 0; i < data.length; i++) {
          if (data[i]['CORREO'] == correo) {
            Nombre= data[i]['NOMBRE'];
            Correo = data[i]['CORREO'];
            Telefono = data[i]['TELEFONO'];
            return true;
          }
        }
        return false;
      }



  //CRUD DE LA TABLA AREAS

  //INSERT DE LA TABLA AREAS
  static Future<void> insertarArea(String nombre, int idEstado) async {
    Database db = await _openDB();
    await db.insert('AREAS', {
      'NOMBRE': nombre,
      'ID_ESTADOS': idEstado
    });
    db.close();
  }
  //MODIFICAR EL AREA
  static Future<void> modificarArea(int idArea, String nombre, int idEstado) async {
    Database db = await _openDB();
    await db.update(
      'AREAS',
      {
        'NOMBRE': nombre,
        'ID_ESTADOS': idEstado
      },
      where: 'ID =?',
      whereArgs: [idArea],
    );
    db.close();
  }
  //ELIMINAR EL AREA
  static Future<void> eliminarArea(int idArea) async {
    Database db = await _openDB();
    await db.delete('AREAS', where: 'ID =?', whereArgs: [idArea]);
    db.close();
  }
  //MOSTRAR AREAS
  static Future<List<Map<String, dynamic>>> mostrarArea() async {
    Database db = await _openDB();
    List<Map<String, dynamic>> data = await db.query('AREAS');
    db.close();
    return data;
  }

  //CRUD DE TABLA PROMOS

  // Mostrar datos de Promos
  static Future<List<Map<String, dynamic>>> mostrarPromos() async {
    Database db = await _openDB();
    List<Map<String, dynamic>> data = await db.query('PROMOS');
    db.close();
    return data;
  }
      //mostrar datos de departamentos
      static Future<List<Map<String, dynamic>>> mostrarDepartamento() async {
        Database db = await _openDB();
        List<Map<String, dynamic>> data = await db.query('DEPARTAMENTO');
        db.close();
        return data;
      }
}

