import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text('Drawer Header'),
      ),
      ListTile(
        title: const Text('Menu'),
        onTap: () {
          Navigator.pushNamed(context, '/main');
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: const Text('About Me'),
        onTap: () {
          Navigator.pushNamed(context, '/aboutMe');
          // Update the state of the app.
          // ...
        },
      ),
    ],
  ),
);
  }
}