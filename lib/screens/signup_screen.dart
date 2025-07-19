// import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _nameController = TextEditingController();
//   // final FirebaseAuth _auth = FirebaseAuth.instance;
//   // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> _signup() async {
//     try {
//       final userCredential = await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'name': _nameController.text.trim(),
//         'email': _emailController.text.trim(),
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//       Navigator.pushReplacementNamed(context, '/patient');
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup failed: $e')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Sign Up')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
//             TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
//             TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
//             const SizedBox(height: 16),
//             ElevatedButton(onPressed: _signup, child: const Text('Sign Up')),
//             TextButton(
//               onPressed: () => Navigator.pushNamed(context, '/login'),
//               child: const Text('Already have an account? Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }