import 'package:flutter/material.dart';
import 'dart:async';
import 'package:visiosense/authenticate/signin.dart';
import 'package:visiosense/wrapper/wrapper.dart';

void main() async {
  runApp(VisiosenseApp());
}

class VisiosenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  bool _showSignInButton = false;
  late Timer timer;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 400, end: 200).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    timer = Timer(Duration(seconds: 5), () {
      // After 5 seconds, shrink the image and show the sign-in button
      setState(() {
        _showSignInButton = true;
      });
      _controller.forward(); // Start the image shrinking animation
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Visio Sense title (unchanged)
                  Text(
                    'Visio Sense',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Subtitle (unchanged)
                  Text(
                    'Mobile Vision Enhancer',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Blind person image (shrinks after 5 seconds)
                  Image.asset(
                    'assets/blind.png', // Walking person image
                    height: _animation.value, // Animates shrinking of image
                  ),
                  SizedBox(height: 40),
                  // Show Sign In button after 5 seconds
                  if (_showSignInButton)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black // Button color
                          ),
                      child: Text('SIGN IN'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
