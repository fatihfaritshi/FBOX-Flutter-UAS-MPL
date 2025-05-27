import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color.fromARGB(255, 5, 13, 67),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Bahasa'),
            subtitle: Text('Indonesia'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Mode Gelap'),
            subtitle: Text('Nonaktif'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Privasi & Keamanan'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Tentang Aplikasi'),
            subtitle: Text('Versi 1.0.0'),
          ),
        ],
      ),
    );
  }
}
  