






import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SIGN UP & STORE USER DATA
  Future<String?> signUp(String name, String email, String password) async {
    try {
      // Validate input
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        return "All fields are required.";
      }

      if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(name)) {
        return "Name should only contain letters.";
      }

      if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
        return "Please enter a valid email address.";
      }

      if (password.length < 6) {
        return "Password should be at least 6 characters long.";
      }

      // Create user in Firebase Authentication
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        String uid = user.uid;

        // Store user details in Firestore (excluding password)
        await _firestore.collection('users').doc(uid).set({
          'uid': uid,
          'name': name.trim(),
          'email': email.trim(),
          'createdAt': Timestamp.now(),
          'emailVerified': user.emailVerified,
        });

        // Send email verification
        await user.sendEmailVerification();
      }

      return null; // No error, success
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "This email is already in use.";
      } else if (e.code == 'weak-password') {
        return "Password should be at least 6 characters.";
      } else if (e.code == 'invalid-email') {
        return "Invalid email address.";
      }
      return e.message ?? "An error occurred.";
    }
  }

  // SIGN IN
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = result.user;

      // Check email verification before allowing login
      if (user != null && !user.emailVerified) {
        return null; // Prevent login if email is not verified
      }

      return user;
    } catch (e) {
      print('Error during sign in: $e');
      return null;
    }
  }

  // CHECK IF EMAIL IS VERIFIED
  bool isEmailVerified() {
    User? user = _auth.currentUser;
    return user != null && user.emailVerified;
  }

  // SIGN OUT
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // SEND EMAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
}
