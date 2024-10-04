import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visiosense/authenticate/forget_password.dart';
import 'package:visiosense/authenticate/signup_main.dart';
import 'package:visiosense/Home/homescreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInScreen(),
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }

  State<SignInScreen> createState() => SignInState();
}

class SignInState extends State<SignInScreen> {
  // Reference for FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Email and password states
  String email = "";
  String password = "";
  String error = ""; // To show errors to the user, if any

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background.jpg'), // Add your background image here
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello, Guest!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Welcome to Visio Sense",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Before Continue, Please Sign in First.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                validator: (val) =>
                    val?.isEmpty == true ? "Enter a valid email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                validator: (val) => val != null && val.length < 6
                    ? "Enter a valid Password"
                    : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      Text("Remember Me"),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPassword()),
                      );
                    },
                    child: Text("Forgot Password?"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    try {
                      UserCredential userCredential =
                          await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      // Handle successful sign-in here
                      print("Signed in: ${userCredential.user?.email}");
                      Navigator.pushNamed(context, '/homescreen');
                    } catch (e) {
                      // Handle sign-in error
                      setState(() {
                        error = e.toString();
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: Text("SIGN IN"),
              ),
              SizedBox(height: 16),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ), // Display error messages
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
