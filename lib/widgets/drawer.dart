import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class DrawerProfile extends StatefulWidget {
  const DrawerProfile({super.key});

  @override
  State<DrawerProfile> createState() => _DrawerProfile();
}

class _DrawerProfile extends State<DrawerProfile> {
  String? username;
  String? email = FirebaseAuth.instance.currentUser?.email;
  @override
  void initState() {
    super.initState();
    // Obtén el nombre del usuario antes de construir el cajón de navegación
    // getUserName();
    // getUserEmail();
  }

 

  @override
  Widget build(BuildContext context) {
 
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.green.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text(
              username ?? '           ',
              style: TextStyle(fontSize: 19.0),
            ),
            accountEmail: Text(
              email ?? 'Email',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          
          ListTile(
            leading: const Icon(Icons.favorite_outlined),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.pushNamed(context, 'favorites');
              // final route = MaterialPageRoute(builder: (context) => Page2());
              // Navigator.push(context, route);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ConfiguracionesScreen(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sing out'),
            onTap: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
    );
  }
}
