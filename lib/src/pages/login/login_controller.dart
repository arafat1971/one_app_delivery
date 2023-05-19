import 'package:flutter/material.dart';
import 'package:one_app_delivery/src/models/response_api.dart';
import 'package:one_app_delivery/src/models/user.dart';
import 'package:one_app_delivery/src/provider/users_provider.dart';
import 'package:one_app_delivery/src/utils/my_snackbar.dart';
import 'package:one_app_delivery/src/utils/shared_pref.dart';

class LoginController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  final SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    // ignore: avoid_print
    print('Usuario: ${user.toJson()}');

    if (user.sessionToken != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, 'client/products/list', (route) => false);
    }
    return null;
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context!, 'register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    ResponseApi? responseApi = await usersProvider.login(email, password);

    bool? suc = responseApi?.success;
    String? msn = responseApi?.message;
    //dynamic data = responseApi?.data;
    MySnackbar.show(context, msn!);

    if (suc!) {
      User user = User.fromJson(responseApi?.data);
      _sharedPref.save('user', user.toJson());
      dynamic roles = user.roles;
      //print('user data inicio');
      //print(responseApi?.toJson());
      //print('user data fin');

      if (roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context!, roles[0].route, (route) => false);
      }
    }
  }
}
