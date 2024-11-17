import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => const WritingPopup(),
            );
          },
          child: const Text('Win Certificate'),
        ),
      ),
    );
  }
}

class WritingPopup extends StatefulWidget {
  const WritingPopup({super.key});

  @override
  State<WritingPopup> createState() => _WritingPopupState();
}

class _WritingPopupState extends State<WritingPopup> {
  TextEditingController _answerController = TextEditingController();
  late Timer _timer;
  int _remainingTime = 30;
  bool _isTimeUp = false;
  bool _isSubmitClicked = false; // Track whether Submit was clicked

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        setState(() {
          _isTimeUp = true;
        });
        _timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Time is over!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void submitAnswer() async {
    // Stop the countdown timer when Submit is clicked
    _timer.cancel();

    // Disable the Submit button after it's clicked
    setState(() {
      _isSubmitClicked = true; // Disable Submit button
    });

    // Check if the text area is empty
    if (_answerController.text.isEmpty) {
      // Show snackbar if the answer is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write something before submitting!')),
      );
    } else {
      try {
        // Add the answer to Firestore
        await FirebaseFirestore.instance.collection('answers').add({
          'answer': _answerController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show a success message immediately after submission
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your answer has been submitted!')),
        );

        // Add a delay before closing the dialog to show the Snackbar message
        await Future.delayed(const Duration(seconds: 2));

        // Close the dialog after submission
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error submitting answer')),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tell me about yourself?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You have $_remainingTime seconds remaining.',
            style: const TextStyle(fontSize: 16, color: Colors.red),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _answerController,
            enabled: !_isSubmitClicked, // Disable text field if Submit is clicked
            maxLines: 5,
            maxLength: 100,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Write your answer here...',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: _isTimeUp || _isSubmitClicked
              ? null
              : submitAnswer, // Disable button if time is up or already submitted
          child: const Text('Submit'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
