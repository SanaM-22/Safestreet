import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Add a new user
  Future<void> addUser(String userId, String name, String email, String phone, String address) async {
    await _db.collection("users").doc(userId).set({
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
    });
  }

  /// Add a new incident report
  Future<void> addIncident(String title, String description, String userId) async {
    await _db.collection("incidents").add({
      "title": title,
      "description": description,
      "reportedBy": userId,
      "timestamp": FieldValue.serverTimestamp(),
    });
  }

  /// Retrieve all incidents
  Stream<QuerySnapshot> getIncidents() {
    return _db.collection("incidents").orderBy("timestamp", descending: true).snapshots();
  }

  /// Update a user's phone number
  Future<void> updateUserPhone(String userId, String newPhone) async {
    await _db.collection("users").doc(userId).update({"phone": newPhone});
  }

  /// Delete an incident report
  Future<void> deleteIncident(String incidentId) async {
    await _db.collection("incidents").doc(incidentId).delete();
  }
}
