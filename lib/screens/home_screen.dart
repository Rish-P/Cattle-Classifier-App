import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../app.dart';
import '../auth/auth.dart';
import '../auth/database.dart';
import '../models/data_test.dart';
import '../widget/list_test.dart';
import '../widget/input_widget.dart';
import '../widget/register.dart';
import '../widget/setting.dart';
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



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
          title: const Text('Home Screen'),
          centerTitle: true,
          actions: [
            TextButton.icon(
              onPressed: () => logOut(context),
              icon: const Icon(
                Icons.play_circle_fill_outlined,
                color: Colors.black,
              ),
              label: Text(
                'NEXT',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ] 
        ),
        // body: ListWidget(),
        body: Center(
        child: ElevatedButton(
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
      ,
    );
  }
}
