import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {

  const NavigationMenu({super.key});

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
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Handle navigation to the Home screen
              Navigator.of(context).pop(); // Close the drawer
              // Navigate to the Home screen
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text('Add Question'),
            onTap: () {
              // Handle navigation to the Quiz Questions screen
              Navigator.of(context).pop(); // Close the drawer
              // Navigate to the Quiz Questions screen
              Navigator.pushReplacementNamed(context, '/add-question');
            },
          ),
          // Add more list items for other menu options
        ],
      ),
    );
  }
}
