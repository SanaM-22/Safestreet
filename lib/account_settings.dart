import 'package:flutter/material.dart';
import 'signup/signup.dart'; // Import SignupPage

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  String _selectedTheme = "System default";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildMenuItem(Icons.person, "Edit Profile", () {
            // Navigate to Edit Profile Page
          }),
          _buildMenuItem(Icons.add, "Add Account", () {
            // Navigate to Signup Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            );
          }),
          _buildMenuItem(Icons.delete, "Delete Account", () {
            _confirmDeleteAccount();
          }),
          _buildMenuItem(Icons.color_lens, "Theme", () {
            _showThemeDialog();
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: const Text(
              "Are you sure you want to delete your account? This action is irreversible."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Implement delete account logic
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Account Deleted Successfully!')),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose Theme",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThemeOption("System default"),
              _buildThemeOption("Light"),
              _buildThemeOption("Dark"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text("Cancel", style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                // Apply theme logic
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Theme changed to $_selectedTheme')),
                );
              },
              child: const Text("OK", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeOption(String theme) {
    return RadioListTile(
      title: Text(theme),
      value: theme,
      groupValue: _selectedTheme,
      activeColor: Colors.green,
      onChanged: (value) {
        setState(() {
          _selectedTheme = value.toString();
        });
        Navigator.pop(context);
        _showThemeDialog(); // Reopen dialog to reflect selection
      },
    );
  }
}
