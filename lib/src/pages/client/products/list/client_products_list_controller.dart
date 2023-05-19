import 'package:flutter/material.dart';
import 'package:one_app_delivery/src/utils/shared_pref.dart';
import 'package:one_app_delivery/src/models/user.dart';

class ClientProductsListController {
  late BuildContext context;
  final SharedPref _sharedPref = SharedPref();

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  User? user;
  Function? refresh;

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
    // ignore: avoid_print
    print("-- inicio instancia init controller");
    // ignore: avoid_print
    print(user);
    // ignore: avoid_print
    print("-- fin instancia init controller");
  }

  logout() {
    _sharedPref.logout(context);
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
}
