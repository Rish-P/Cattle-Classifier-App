import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class NetworkManager {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  void startMonitoring() {
    _connectivitySubscription = 
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi || 
    result == ConnectivityResult.mobile) 
    {
      // Trigger file uploads when connected to internet
      uploadImages();
    }
  }

  Future<void> uploadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagesDirectory = Directory('${directory.path}');
    final imageFiles = imagesDirectory.listSync().whereType<File>().toList();

    for (var file in imageFiles) {
      try {
        await FirebaseStorage.instance.ref('uploads/${file.uri.pathSegments.last}').putFile(file);
        // Optionally delete the file after upload
        await file.delete();
      } catch (e) {
        print('Error uploading file: $e');
      }
    }
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
