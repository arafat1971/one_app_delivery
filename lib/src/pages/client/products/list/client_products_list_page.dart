import 'package:flutter/material.dart';
import 'package:one_app_delivery/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:one_app_delivery/src/utils/my_colors.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({super.key});

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  final ClientProductsListController _con = ClientProductsListController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    //var list = _con.user;
    //print('-- inicia user build scaffold');
    //print(list);
    //print('-- fin user build scaffold');

    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      body: Center(
        child: ElevatedButton(
          onPressed: _con.logout,
          child: const Text('cerrar'),
        ),
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
          margin: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/img/menu.png',
            width: 20,
            height: 20,
          )),
    );
  }

  Widget _drawer() {
    //int? numroles = _con.user?.roles!.length;
    int? numroles = _con.user != null ? _con.user?.roles!.length : 1;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: MyColors.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
                Text(
                  // ignore: unnecessary_string_interpolations
                  '${_con.user?.email ?? ''}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                ),
                Text(
                  // ignore: unnecessary_string_interpolations
                  '${_con.user?.phone ?? ''}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(top: 10),
                  child: const FadeInImage(
                    image: AssetImage('assets/img/no-image.png'),
                    fit: BoxFit.contain,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png'),
                  ),
                )
              ],
            ),
          ),
          const ListTile(
            title: Text('Editar perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          const ListTile(
            title: Text('Mis Pedidos'),
            trailing: Icon(Icons.shopping_cart),
          ),
          numroles! > 1
              ? ListTile(
                  onTap: _con.goToRoles,
                  title: const Text('Seleccionar Rol'),
                  trailing: const Icon(Icons.person_outline),
                )
              : Container(),
          ListTile(
            onTap: _con.logout,
            title: const Text('Cerrar sesion'),
            trailing: const Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
