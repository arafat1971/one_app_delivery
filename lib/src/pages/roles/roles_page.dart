import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:one_app_delivery/src/models/rol.dart';
import 'package:one_app_delivery/src/pages/roles/roles_controller.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  final RolesController _con = RolesController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = _con.user?.roles!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona un rol'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
        child: ListView(
          children: list != null
              ? list.map((Rol rol) {
                  return _cardRol(rol);
                }).toList()
              : [],
        ),
      ),
    );
  }

  /*Widget _cardRol(Rol rol) {
    return Text('hola');
  }*/

  Widget _cardRol(Rol rol) {
    var rout = rol.route;
    return GestureDetector(
      onTap: () {
        _con.goToPage(rout!);
      },
      child: Column(
        children: [
          const SizedBox(
            height: 100,
            child: FadeInImage(
              image: AssetImage('assets/img/no-image.png'),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            rol.name ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
