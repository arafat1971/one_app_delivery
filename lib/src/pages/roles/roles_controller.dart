import 'package:flutter/material.dart';
import 'package:one_app_delivery/src/models/user.dart';
import 'package:one_app_delivery/src/utils/shared_pref.dart';

class RolesController {
  BuildContext? context;
  Function? refresh;

  User? user;
  SharedPref sharedPref = SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    // OBTENER EL USUARIO DE SESION
    user = User.fromJson(
        await sharedPref.read('user')); // PODRIA TARDAR UN TIEMPO EN OBTENERSE
    refresh();
  }

  void goToPage(String route) {
    Navigator.pushNamedAndRemoveUntil(context!, route, (route) => false);
  }
}
