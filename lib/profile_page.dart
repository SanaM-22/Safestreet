import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup/login.dart';
import 'settings.dart'; // Ensure this file exists

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser; // Get logged-in user

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.green[300],
            child: const Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            user?.displayName ?? "Sredha", // Show Firebase user name
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            user?.email ?? "sredhasp@gmail.com", // Show Firebase user email
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          _buildMenuItem(context, Icons.settings, "Settings", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
          }),
          _buildMenuItem(context, Icons.logout, "Logout", () async {
            await FirebaseAuth.instance.signOut(); // Sign out properly
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
