import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  //metodo para almacenar nueva informacion en el storage
  void save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  //Metodo para leer la informacion almacenada
  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(key) == null) return null;
    String? pr = prefs.getString(key);
    return json.decode(pr!);
  }

  //metodo verifica si existe en el shared preferencs algun datos
  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  //Metodo para eliminar un dato de sharedpreferents
  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  void logout(BuildContext context) async {
    await remove('user');
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
  }
}
