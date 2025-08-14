import 'package:flutter/material.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  // Dummy user data
  final String profileImage =
      'https://www.w3schools.com/howto/img_avatar.png'; // Replace with network/local image
  final String name = 'John Doe';
  final String email = 'john.doe@example.com';
  final String phone = '+1 123 456 7890';
  final String bio = 'Flutter developer and UI/UX enthusiast.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(profileImage),
            ),

            const SizedBox(height: 16),

            // Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            // Email
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 20),

            // Divider
            const Divider(),

            // User Info List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: Text(phone),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Bio'),
                    subtitle: Text(bio),
                  ),
                  const Divider(),
                  // Add more fields if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
