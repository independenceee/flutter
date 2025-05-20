import 'package:flutter/material.dart';
import 'package:flutters/providers/tts.provider.dart';
import 'package:provider/provider.dart';

class TTSScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TTSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter TTS Voice Selection')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<TTSProvider>(
          builder: (context, tts, _) {
            _controller.text = tts.text;
            return Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'Nhập văn bản'),
                  onChanged: (value) => tts.updateText(value),
                ),
                SizedBox(height: 20),
                DropdownButton<String>(
                  value: tts.selectedVoice,
                  hint: Text('Chọn giọng nói'),
                  items:
                      tts.voices.map((voice) {
                        return DropdownMenuItem<String>(
                          value:
                              voice['name']
                                  as String, // Explicitly cast to String
                          child: Text('${voice['name']} (${voice['locale']})'),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      final selected = tts.voices.firstWhere(
                        (voice) => voice['name'] == value,
                      );
                      tts.setVoice(
                        selected['name'] as String,
                        selected['locale'] as String,
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: tts.isSpeaking ? null : () => tts.speak(),
                      child: Text('Phát'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: tts.isSpeaking ? () => tts.stop() : null,
                      child: Text('Dừng'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(tts.isSpeaking ? 'Đang phát...' : 'Đã dừng'),
              ],
            );
          },
        ),
      ),
    );
  }
}
