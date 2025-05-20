import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSProvider with ChangeNotifier {
  List<Map<String, String>> voices = [];
  String? selectedVoice;
  String text = '';
  bool isSpeaking = false;
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> initVoices() async {
    try {
      // Fetch voices from flutter_tts
      List<dynamic> rawVoices = await _flutterTts.getVoices;
      voices =
          rawVoices
              .map((voice) {
                // Convert Map<Object?, Object?> to Map<String, String>
                return {
                  'name': voice['name']?.toString() ?? 'Unknown',
                  'locale': voice['locale']?.toString() ?? 'Unknown',
                };
              })
              .toList()
              .cast<Map<String, String>>();
      selectedVoice = voices.isNotEmpty ? voices.first['name'] : null;
      notifyListeners();
    } catch (e) {
      print('Error loading voices: $e');
    }
  }

  void updateText(String value) {
    text = value;
    notifyListeners();
  }

  void setVoice(String name, String locale) {
    selectedVoice = name;
    notifyListeners();
  }

  void speak() async {
    // if (text.isNotEmpty && selectedVoice != null) {
    //   await _flutterTts.setVoice({
    //     'name': selectedVoice,
    //     'locale':
    //         voices.firstWhere((v) => v['name'] == selectedVoice)['locale'],
    //   });
    //   await _flutterTts.speak(text);
    //   isSpeaking = true;
    //   notifyListeners();
    // }
  }

  void stop() async {
    await _flutterTts.stop();
    isSpeaking = false;
    notifyListeners();
  }
}
