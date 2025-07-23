import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class TelephonyHandler {
  static Future<bool> canMakePhoneCalls() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        final telUri = Uri.parse('tel:+1234567890');
        return await canLaunchUrl(telUri);
      }
      return false;
    } catch (e) {
      print("Telephony check error: $e");
      return false;
    }
  }

  static Future<void> makeCall(BuildContext context, String number) async {
    String sanitizedNumber = number.replaceAll(RegExp(r'[^0-9+]'), '');

    if (sanitizedNumber.isEmpty || sanitizedNumber.length < 10) {
      _showErrorSnackbar(context, "Invalid phone number");
      return;
    }

    if (!sanitizedNumber.startsWith('') && sanitizedNumber != "911") {
      sanitizedNumber = '+$sanitizedNumber';
    }

    final Uri callUri = Uri.parse('tel:$sanitizedNumber');

    try {
      if (Platform.isAndroid || Platform.isIOS) {
        bool launched = await launchUrl(
          callUri,
          mode: LaunchMode.externalApplication,
        );

        if (!launched) {
          bool canMakeCalls = await canMakePhoneCalls();
          if (!canMakeCalls) {
            _showErrorSnackbar(context, "No telephony apps available on this device");
          } else {
            _showErrorSnackbar(context, "Could not launch phone dialer");
          }
        }
      } else {
        _showErrorSnackbar(context, "Telephony not supported on this platform");
      }
    } catch (e) {
      print("Call launch error: $e");
      _showErrorSnackbar(context, "Error initiating call: $e");
    }
  }

  static void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final List<Map<String, String>> _contacts = [
    {"name": "John Doe", "number": "+91 9061697412"},
    {"name": "Jane Smith", "number": "+1 987 654 321"},
    {"name": "Emergency Hotline", "number": "911"},
    {"name": "Nadhitha", "number": "8078847135"}
  ];

  void _addContact(String name, String number) {
    setState(() {
      _contacts.add({"name": name, "number": number});
    });
  }

  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  void _showAddContactDialog() {
    String name = "";
    String number = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                onChanged: (value) => number = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (name.isNotEmpty && number.isNotEmpty) {
                  _addContact(name, number);
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddContactDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: Text(contact["name"]!),
            subtitle: Text("📞 ${contact["number"]}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.call, color: Colors.green),
                  onPressed: () => TelephonyHandler.makeCall(
                      context,
                      contact["number"]!
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteContact(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}