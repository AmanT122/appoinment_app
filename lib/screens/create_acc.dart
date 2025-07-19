// import 'package:appoinment_sys/screens/doctor_dashboard.dart';
// import 'package:appoinment_sys/screens/patient_dashboard.dart';
import 'package:appoinment_app/screens/doctor_dashboard.dart';
import 'package:appoinment_app/screens/patient_dashboard.dart';
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
              onPressed: () {
                if (selectedRole == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a role')),
                  );
                  return;
                }
                
                // Here you would typically validate the form and send data to server
                // For now, we'll just navigate to the appropriate dashboard
                
                if (selectedRole == 'doctor') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  DoctorDashboard(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  PatientDashboard(),
                    ),
                  );
                }
              },
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
                  onPressed: () {},
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