import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../app.dart';
import '../auth/auth.dart';
import '../auth/database.dart';
import '../models/data_test.dart';
import '../widget/input_widget.dart';
import '../widget/register.dart';
import '../widget/sign.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:firebase_storage/firebase_storage.dart';


class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/cow_bg.jpg'), // Replace with your image path
          fit: BoxFit.cover, // This ensures the image covers the whole screen
        ),
      ),
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BackgroundImage(),
      ),
    );
  }

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthSerives _serives = AuthSerives();

  void logOut(BuildContext context) async {
    await _serives.logOut();
  }
 

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TestData?>?>.value(
      value: DataBaseService().datas,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Know your cattle!'),
          centerTitle: true,
          actions: [
            TextButton.icon(
              onPressed: () => logOut(context),
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              label: Text(
                'log out',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            
          ] 
        ),
        // body: ListWidget(),
        body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/cow_bg.jpg'), // Replace with your image path
            fit: BoxFit.cover, // Ensures the image covers the whole screen
          ),
        ),
        child: Align(
          alignment: Alignment.center, // Adjust this value to move the button
          child: Padding(
            padding: EdgeInsets.only(top: 200.0),
        
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, 
            backgroundColor: Colors.lightGreen[400] // Background color
          ),
          
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainApp()),
            );
          },
          
          child: Text('CATTLE CLASSIFIER'),
        ),
        
      ),
      
    )
      ) 
      )
    );
  }
}
