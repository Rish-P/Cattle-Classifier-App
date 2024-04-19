

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../auth/auth.dart';
import '../classifier/classifier.dart';
import '../screens/home_screen.dart';
import '../styles.dart';
import 'cattle_photo_view.dart';

const _labelsFileName = 'assets/labels.txt';
const _modelFileName = 'model_unquant.tflite';

class CattleRecognizer extends StatefulWidget {
  const CattleRecognizer({super.key});

  @override
  State<CattleRecognizer> createState() => _CattleRecognizerState();
}

enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

class _CattleRecognizerState extends State<CattleRecognizer> {
  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;

  // Result
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _CattleLabel = ''; // Name of Error Message
  double _accuracy = 0.0;

  late Classifier _classifier;

  @override
  void initState() {
    super.initState();
    _loadClassifier();
  }


  //IMAGE LOCALLY SAVE
  Future<File> saveImageLocally(File imageFile) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final File localImage = await imageFile.copy('$path/${DateTime.now().millisecondsSinceEpoch}.png');
  return localImage;
}
// void back(BuildContext context){
//   CattleRecognizer.of(context).onBack();
// }

  Future<void> _loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
      'labels at $_labelsFileName, '
      'model at $_modelFileName',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier!;
  }

  //LOGOUT FUNCTIONALITY
  final AuthSerives _serives = AuthSerives();

  void logOut(BuildContext context) async {
    await _serives.logOut();
  }
  //

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: _buildTitle(),
          ),
          const SizedBox(height: 20),
          _buildPhotolView(),
          const SizedBox(height: 10),
          _buildResultView(),
          const Spacer(flex: 5),
          
          _buildPickPhotoButton(
            title: 'Pick from gallery',
            source: ImageSource.gallery,
          ),
          ElevatedButton(onPressed: (){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );}, 
          child: const Text('Enough of cattle today :)')),
          // _buildBackButton(title: 'Back'),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildPhotolView() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CattlePhotoView(file: _selectedImageFile),
        _buildAnalyzingText(),
      ],
    );
  }

  Widget _buildAnalyzingText() {
    if (!_isAnalyzing) {
      return const SizedBox.shrink();
    }
    return const Text('Analyzing...', style: kAnalyzingTextStyle);
  }

  Widget _buildTitle() {
    return const Text(
      'In the Mooo-d for some classification!',
      style: kTitleTextStyle,
      textAlign: TextAlign.center,
    );
  }

  //BACK BUTTON
  Widget _buildBackButton({
    required String title 
  }) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 300,
        height: 50,
        color: kColorLightRed,
        child: Center(
            child: Text('Enough of cattle today :)',
                style: const TextStyle(
                  fontFamily: kButtonFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                  color: kColorMayGreen,
                ))),
      ),
    );
  }

  Widget _buildPickPhotoButton({
    required ImageSource source,
    required String title,
  }) {
    return TextButton(
      onPressed: () => _onPickPhoto(source),
      child: Container(
        width: 300,
        height: 50,
        color: Colors.blue[500],
        child: Center(
            child: Text(title,
                style: const TextStyle(
                  fontFamily: kButtonFont,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ))),
      ),
    );
  }

  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }

  void _onPickPhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImageFile = imageFile;
    });

    _analyzeImage(imageFile);
  }

  void _analyzeImage(File image) {
    _setAnalyzing(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier.predict(imageInput);

    final result = resultCategory.score >= 0.82
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final plantLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    _setAnalyzing(false);

    setState(() {
      _resultStatus = result;
      _CattleLabel = plantLabel;
      _accuracy = accuracy;
    });
  }

  Widget _buildResultView() {
    var title = '';

    if (_resultStatus == _ResultStatus.notFound) {
      title = 'Fail to recognise';
    } else if (_resultStatus == _ResultStatus.found) {
      title = _CattleLabel;
    } else {
      title = '';
    }

    //
    var accuracyLabel = '';
    if (_resultStatus == _ResultStatus.found) {
      accuracyLabel = 'Accuracy: ${(_accuracy * 100).toStringAsFixed(2)}%';
    }

    return Column(
      children: [
        Text(title, style: kResultTextStyle),
        const SizedBox(height: 10),
        Text(accuracyLabel, style: kResultRatingTextStyle)
      ],
    );
  }
}
