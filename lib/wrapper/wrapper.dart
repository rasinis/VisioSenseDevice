import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visiosense/Home/homescreen.dart';
import 'package:visiosense/authenticate/authenticate.dart';
import 'package:visiosense/models/UserModel.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user != null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
