import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'calendar_page.dart';
import 'googlemap.dart';
import 'chat_page.dart';
import 'moments_page.dart';
import 'contacts_page.dart';
import 'profile_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SAFE STREET',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.green[700],
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Text(
            "SAFE STREET",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(30),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _buildFeatureTile(context, Icons.contacts, "Contacts", const ContactsPage(), 30),
                _buildFeatureTile(context, Icons.camera_alt, "Clicks", const MomentsPage(), 30),
                _buildFeatureTile(context, Icons.chat, "Chats", const ChatPage(), 30),
                _buildFeatureTile(context, Icons.event, "Events", const CalendarPage(), 30),
                _buildFeatureTile(context, Icons.map, "Map", const GoogleMapPage(), 30),
              ],
            ),
          ),
          const SizedBox(height: 80),
          _buildFingerprintButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildFingerprintButton() {
    return Column(
      children: [
        const Text(
          "Press & Hold \n        Help!  ",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onLongPress: () {
            _sendEmergencyNotification();
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green[200],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.fingerprint,
              size: 80,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _sendEmergencyNotification() {
    Fluttertoast.showToast(
      msg: "Emergency notification sent to contacts!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  Widget _buildFeatureTile(BuildContext context, IconData icon, String label, Widget page, double iconSize) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize, color: Colors.white),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green[700]),
            child: const Text(
              'Emergency Contacts',
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          _buildEmergencyContact('Police Station', '📞 100'),
          _buildEmergencyContact('Fire Force', '📞 101'),
          _buildEmergencyContact('Ambulance', '📞 102'),
          _buildEmergencyContact('Women Helpline', '📞 1091'),
          _buildEmergencyContact('Child Helpline', '📞 1098'),
          _buildEmergencyContact('Roadside Assistance', '📞 1033'),
          _buildEmergencyContact('Disaster Management', '📞 1070'),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(String title, String number) {
    return ListTile(
      leading: const Icon(Icons.phone, color: Colors.blue),
      title: Text(title),
      subtitle: Text(number),
      trailing: IconButton(
        icon: const Icon(Icons.call, color: Colors.green),
        onPressed: () {
          // Add functionality to call
        },
      ),
    );
  }
}