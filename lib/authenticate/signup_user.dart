import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visiosense/authenticate/signup_main.dart';
import 'package:visiosense/authenticate/signup_main.dart';

void main() {
  runApp(VisiosenseApp());
}

class VisiosenseApp extends StatelessWidget {
  // Corrected the class name
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpUser(),
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/SignUpUser': (context) => SignUpScreen(),
      },
    );
  }
}

class SignUpUser extends StatefulWidget {
  const SignUpUser({super.key});

  @override
  State<SignUpUser> createState() => SignUpState();
}

class SignUpState extends State<SignUpUser> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String createPassword = "";
  String confirmPassword = "";
  String error = "";
  bool _obscurePassword = true; // For password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'User',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (val) => val?.isEmpty == true
                                ? "Enter your first name"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                firstName = val;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            validator: (val) => val?.isEmpty == true
                                ? "Enter your last name"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                lastName = val;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) =>
                          val?.isEmpty == true ? "Enter a valid email" : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) => val != null && val.length < 9
                          ? "Enter a valid Phone Number"
                          : null,
                      onChanged: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 5),
                              Text('+94'),
                            ],
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) => val != null && val.length < 8
                          ? "Enter a valid Password"
                          : null,
                      onChanged: (val) {
                        setState(() {
                          createPassword = val;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Create your Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) {
                        if (val != createPassword) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          confirmPassword = val;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    SizedBox(height: 20),
                    if (error.isNotEmpty)
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() == true) {
                          try {
                            UserCredential userCredential =
                                await _auth.createUserWithEmailAndPassword(
                              email: email,
                              password: createPassword,
                            );

                            await _firestore
                                .collection('users')
                                .doc(userCredential.user!.uid)
                                .set({
                              'firstName': firstName,
                              'lastName': lastName,
                              'email': email,
                              'mobileNumber': phoneNumber,
                            });

                            Navigator.pushNamed(context, '/');
                          } catch (e) {
                            setState(() {
                              error = e.toString();
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
