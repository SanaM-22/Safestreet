 import 'dart:async';
 import 'package:flutter/material.dart';
 import 'signup/login.dart'; // Import LoginPage

 class SplashScreen extends StatefulWidget {
   const SplashScreen({super.key});

   @override
   _SplashScreenState createState() => _SplashScreenState();
 }

 class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
   late AnimationController _controller;
   late Animation<double> _animation;

   @override
   void initState() {
     super.initState();

     _controller = AnimationController(
       vsync: this,
       duration: const Duration(seconds: 3),
     )..forward();

     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

     Future.delayed(const Duration(seconds: 3), () {
       if (mounted) {
         Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
         );
       }
     });
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [Colors.greenAccent.shade400, Colors.greenAccent.shade700],
             begin: Alignment.topLeft,
             end: Alignment.bottomRight,
           ),
         ),
         child: Center(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               // Logo Animation
               ScaleTransition(
                 scale: _animation,
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(60), // Logo style
                   child: Image.asset(
                     'assets/images/logo.png',
                     width: 120, // Logo size
                     height: 120,
                     fit: BoxFit.cover,
                   ),
                 ),
               ),
               const SizedBox(height: 20),
               // App Name
               FadeTransition(
                 opacity: _animation,
                 child: const Text(
                   'SafeStreet',
                   style: TextStyle(
                     fontSize: 32,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                     letterSpacing: 1.5,
                   ),
                 ),
               ),
             ],
           ),
         ),
       ),
     );
   }

   @override
   void dispose() {
     _controller.dispose();
     super.dispose();
   }
 }








