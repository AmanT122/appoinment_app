import 'dart:async';
import 'package:appoinment_app/screens/login_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Screens
import 'screens/create_acc.dart' hide CreateAccount;           // ✅ Signup Screen
import 'screens/start_page.dart';           // ✅ Login Screen
import 'screens/patient_dashboard.dart';    // ✅ Patient Dashboard
import 'screens/doctor_dashboard.dart';     // ✅ Doctor Dashboard
import 'screens/doctor_details.dart';       // ✅ Doctor Details Page
import 'screens/start_page.dart';          // ✅ Login Main Screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.local_hospital, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Medical Booking',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
       routes: {
      '/start': (context) => const StartPage(),
      '/login': (context) => const LoginMain(),
      '/doctor': (context) => const CreateAccount(),
      '/patient': (context) => PatientDashboard(),
    },
    );
  }
}
