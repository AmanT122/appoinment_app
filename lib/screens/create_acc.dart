// import 'package:appoinment_sys/screens/doctor_dashboard.dart';
// import 'package:appoinment_sys/screens/patient_dashboard.dart';
import 'package:appoinment_app/screens/doctor_dashboard.dart';
import 'package:appoinment_app/screens/patient_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? selectedRole; // 'doctor' or 'patient'
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Add this function for sign up
  Future<void> _signUp() async {
    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role')),
      );
      return;
    }
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // You can also save additional user info (name, role) to Firestore here if needed

      // Navigate to dashboard
      if (selectedRole == 'doctor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DoctorDashboard()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PatientDashboard()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Sign up failed')),
      );
    }
  }

  Future<void> _signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User cancelled

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to dashboard (choose based on selectedRole or default)
      if (selectedRole == 'doctor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DoctorDashboard()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PatientDashboard()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedRole = 'doctor';
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: selectedRole == 'doctor' 
                            ? Colors.blue 
                            : Colors.grey,
                        width: selectedRole == 'doctor' ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      'Doctor',
                      style: TextStyle(
                        color: selectedRole == 'doctor' 
                            ? Colors.blue 
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedRole = 'patient';
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: selectedRole == 'patient' 
                            ? Colors.blue 
                            : Colors.grey,
                        width: selectedRole == 'patient' ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      'Patient',
                      style: TextStyle(
                        color: selectedRole == 'patient' 
                            ? Colors.blue 
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp, // <-- update here
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('or'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Continue with',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.g_mobiledata, size: 40),
                  onPressed: _signUpWithGoogle, // <-- update here
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.apple, size: 40),
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.circle, size: 40),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text('Have an account? Log in'),
            ),
          ],
        ),
      ),
    );
  }
}