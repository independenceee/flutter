import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TssScreen extends StatefulWidget {
  const TssScreen({super.key});

  @override
  State<TssScreen> createState() {
    return _TssScreenState();
  }
}

class _TssScreenState extends State<TssScreen> {
  FlutterTts _flutterTts = FlutterTts();
  Map? _currentVoice;
  void initTts() {
    _flutterTts.getVoices.then((data) {
      try {
        List<Map> _voices = List<Map>.from(data);
        setState(() {
          _voices =
              _voices.where((_voice) => _voice['name'].contains('en')).toList();
          print(_voices);
        });
      } catch (error) {
        print(error);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
