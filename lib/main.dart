
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './auth/auth.dart';
import 'package:provider/provider.dart';
import 'controller.dart';
import 'models/user_model.dart';
import 'networkmanager.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(const MainApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
final networkManager = NetworkManager();
  networkManager.startMonitoring();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Users?>.value(
          value: AuthSerives().user,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cattle Classifier Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Controller(),
      ),
    );
  }
}