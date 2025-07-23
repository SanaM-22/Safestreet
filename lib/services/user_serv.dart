import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String name, String email, String password) async {
    try {
      await _firestore.collection('users').add({
        'Name': name,
        'email': email,
        'password': password,
      });
      print('User added successfully!');
    } catch (e) {
      print('Failed to add user: $e');
    }
  }
}
