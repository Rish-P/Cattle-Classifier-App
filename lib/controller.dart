import 'package:flutter/material.dart';
import '../models/user_model.dart';
import './screens/welcome_screen.dart';
import './screens/home_screen.dart';
import 'package:provider/provider.dart';

class Controller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    return user != null ? HomeScreen() : WelcomeScreen();
  }
}
