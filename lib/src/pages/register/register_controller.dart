import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:one_app_delivery/src/models/response_api.dart';
import 'package:one_app_delivery/src/models/user.dart';
import 'package:one_app_delivery/src/provider/users_provider.dart';
import 'package:one_app_delivery/src/utils/my_snackbar.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  PickedFile? pickedFile;
  File? imageFile;
  Function? refresh;

  Future? init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    return null;
  }

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastname = lastNameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = passwordConfirmController.text.trim();

    if (email.isEmpty ||
        name.isEmpty ||
        lastname.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackbar.show(context, 'Debes de ingresar todos los campos');
      return;
    }

    if (confirmPassword != password) {
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }

    if (password.length < 6) {
      MySnackbar.show(
          context, 'Las contraseñas debe de tener almenso 6 caracteres');
      return;
    }

    if (imageFile == null) {
      MySnackbar.show(context, 'Selecciona una imagen');
      return;
    }

    User user = User(
      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      password: password,
    );
    Stream? stream = await usersProvider.createWithImage(user, imageFile!);
    stream?.listen((res) async {
      //ResponseApi? responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

      String? msn = responseApi.message;
      bool? suc = responseApi.success;
      MySnackbar.show(context, msn!);
      if (suc!) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context!, 'login');
        });
      }

      // ignore: avoid_print
      print('RESPUESTA: ${responseApi.toJson()}');
    });
  }

  Future selectImage(ImageSource imageSource) async {
    // ignore: deprecated_member_use
    pickedFile = await ImagePicker().getImage(source: imageSource);

    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
    }
    Navigator.pop(context!);
    refresh!();
  }

  void showAlertDialog() {
    // ignore: unused_local_variable
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: const Text('Galeria'));

    // ignore: unused_local_variable
    Widget camaeraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: const Text('Camara'));

    // ignore: unused_local_variable
    AlertDialog alertDialog = AlertDialog(
      title: const Text('Seleccionar tu imagen'),
      actions: [galleryButton, camaeraButton],
    );

    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void back() {
    Navigator.pop(context!);
  }
}
