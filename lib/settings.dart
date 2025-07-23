import 'package:flutter/material.dart';
import 'edit_profile.dart'; // Import Edit Profile Page
import 'account_settings.dart'; // Import Account Settings Page

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildMenuItem(context, Icons.edit, "Edit Profile", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
          }),
          _buildMenuItem(context, Icons.account_circle, "Account Settings", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountSettingsPage()));
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

