import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:one_app_delivery/src/pages/login/login_controller.dart';
import 'package:one_app_delivery/src/utils/my_colors.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _con = LoginController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity, //se obtiene el ancho de toda la pantalla
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circleLogin(),
            ),
            Positioned(
              top: 60,
              left: 25,
              child: _textLogin(),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _lottinAnimation(),
                  //_imageBanner(),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _buttonIngresar(),
                  _textDowHaveAccount()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textLogin() {
    return const Text(
      'LOGIN',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        fontFamily: 'NimbusSans',
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

  Widget _lottinAnimation() {
    return Container(
      margin: EdgeInsets.only(
        top: 150,
        bottom: MediaQuery.of(context).size.height * 0.11,
      ),
      child: Lottie.asset(
        'assets/json/delivery.json',
        width: 350,
        height: 200,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _textDowHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes cuenta?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.primaryColor,
          ),
        ),
        const SizedBox(width: 7),
        GestureDetector(
          onTap: _con.goToRegisterPage,
          child: Text(
            'Registrate',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.primaryColor,
            ),
          ),
        )
      ],
    );
  }

  Widget _buttonIngresar() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.login,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text('INGRESAR'),
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
          hintText: "Password",
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

  /*Widget _imagenBanner() {
    return Image.asset(
      'assets/img/delivery.png',
      width: 200,
      height: 200,
    );
  }*/
}
