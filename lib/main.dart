import 'package:flutter/material.dart';
import 'package:v_webapp/envelope.dart';

import 'package:v_webapp/letter.dart';

void main() {
  runApp(const BirthdayApp());
}

class BirthdayApp extends StatelessWidget {
  const BirthdayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Special Message For You',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BirthdayCardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BirthdayCardScreen extends StatefulWidget {
  const BirthdayCardScreen({super.key});

  @override
  State<BirthdayCardScreen> createState() => _BirthdayCardScreenState();
}

class _BirthdayCardScreenState extends State<BirthdayCardScreen>
    with TickerProviderStateMixin {
  // State variables to track the animation progress
  bool _isEnvelopeOpen = false;
  bool _isLetterVisible = false;

  // Animation controller for the ripple effect on the envelope
  late final AnimationController _rippleController;
  late final Animation<double> _rippleAnimation;

  // Animation controller for the main envelope opening sequence
  late final AnimationController _openingController;

  @override
  void initState() {
    super.initState();

    // Setup for the ripple animation
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _rippleController,
        curve: Curves.easeInOut,
      ),
    );

    // Setup for the envelope opening animation
    _openingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _openingController.dispose();
    super.dispose();
  }

  // Method to trigger the opening animation
  void _openEnvelope() {
    if (_isEnvelopeOpen) return;
    setState(() {
      _isEnvelopeOpen = true;
    });
    // Start the main animation sequence
    _openingController.forward();

    // Make the letter content visible after a delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        _isLetterVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // --- Letter Content ---
            // This is initially hidden and appears during the animation
            if (_isLetterVisible)
              LetterContent(
                openingController: _openingController,
              ),

            // --- Envelope Widget ---
            // This is the main interactive element initially visible
            if (!_isLetterVisible)
              Envelope(
                openingController: _openingController,
                rippleAnimation: _rippleAnimation,
                isOpen: _isEnvelopeOpen,
              ),

            // --- "Open The Envelope" Button ---
            // This button fades out when clicked
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isEnvelopeOpen ? 0.0 : 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 280), // Position below the envelope
                  ElevatedButton(
                    onPressed: _openEnvelope,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Open The Envelope',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
