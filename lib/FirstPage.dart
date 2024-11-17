import 'package:flutter/material.dart';
import 'ProfilePage.dart';  // Make sure to import the ProfilePage.dart

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Certificate Button
            ElevatedButton(
              onPressed: () {
                // Add navigation logic or action for Certificate button
                print("Certificate button pressed");
              },
              child: const Text('Certificate'),
            ),
            const SizedBox(height: 20),

            // Profile Button
            ElevatedButton(
              onPressed: () {
                // Navigate to ProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const Text('Profile'),
            ),
            const SizedBox(height: 20),

            // Chat Button
            ElevatedButton(
              onPressed: () {
                // Add navigation logic or action for Chat button
                print("Chat button pressed");
              },
              child: const Text('Chat'),
            ),
            const SizedBox(height: 20),

            // Score Button
            ElevatedButton(
              onPressed: () {
                // Add navigation logic or action for Score button
                print("Score button pressed");
              },
              child: const Text('Score'),
            ),
          ],
        ),
      ),
    );
  }
}
