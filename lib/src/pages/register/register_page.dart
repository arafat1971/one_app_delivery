import 'package:one_app_delivery/src/pages/register/register_controller.dart';
import 'package:one_app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _con = RegisterController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circleLogin(),
            ),
            Positioned(
              top: 75,
              left: 25,
              child: _textRegister(),
            ),
            Positioned(
              top: 60,
              left: -5,
              child: _iconBack(),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 150),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _imageUser(),
                    const SizedBox(height: 15),
                    _textFieldEmail(),
                    _textFieldName(),
                    _textFieldLastName(),
                    _textFieldPhone(),
                    _textFieldPassword(),
                    _textFieldConfirmPassword(),
                    _buttonRegister()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageUser() {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (_con.imageFile != null) {
      image = FileImage(_con.imageFile!);
    } else {
      image = const AssetImage('assets/img/user_profile_2.png');
    }

    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: image,
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 5,
      ),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Correo Electronico",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.email,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 5,
      ),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
          hintText: "Nombre",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.person,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 5,
      ),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.lastNameController,
        decoration: InputDecoration(
          hintText: "Apellido",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.person_outline,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 5,
      ),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: "Telefono",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.phone,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 5,
      ),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Contraseña",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.lock,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _textFieldConfirmPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 5,
      ),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.passwordConfirmController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Confirmar Contraseña",
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.lock,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.register,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text('REGISTRAR'),
      ),
    );
  }

  Widget _textRegister() {
    return const Text(
      'REGISTRO',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    );
  }

  Widget _iconBack() {
    return IconButton(
      onPressed: _con.back,
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
