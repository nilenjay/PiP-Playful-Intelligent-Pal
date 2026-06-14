import 'dart:async';
import 'dart:ui';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  TtsService() {
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4); // Slower for children
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.2); // Slightly higher pitch
  }

  Future<void> speak(String text, {
    required VoidCallback onStart,
    required VoidCallback onComplete,
    required Function(String) onError,
  }) async {
    _flutterTts.setStartHandler(() {
      onStart();
    });

    _flutterTts.setCompletionHandler(() {
      onComplete();
    });

    _flutterTts.setErrorHandler((msg) {
      onError(msg.toString());
    });

    try {
      await _flutterTts.speak(text);
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
