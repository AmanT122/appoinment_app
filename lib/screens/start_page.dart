import 'package:appoinment_app/screens/create_acc.dart';
import 'package:appoinment_app/screens/login_main.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo Container
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color(0xFFD8D1FF), // Soft lavender background
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 180,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Your Go‑To App for Booking\nAppointments – Anytime, Anywhere.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7C74FF),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 60),

              _buildRoundedButton(
                label: 'Create Account',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateAccount()),
                  );
                },
              ),

              const SizedBox(height: 16),

              _buildRoundedButton(
                label: 'Log in',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginMain()),
                  );
                },
              ),

              const SizedBox(height: 40),

              const Text(
                'v 0.1',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedButton({required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF8C7BFF), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, color: Color(0xFF8C7BFF)),
        ),
      ),
    );
  }
}
