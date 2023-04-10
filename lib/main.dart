import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gpt_flutter/providers/active_theme_provider.dart';
import 'package:gpt_flutter/screens/chat_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_preview/device_preview.dart';
import 'constants/themes.dart';

class TTS {
  static FlutterTts tts = FlutterTts();
  static init() async {
    // Set language Vietnamese
    await tts.setLanguage("vi-VN");
  }

  static Speak() async {
    await tts.awaitSpeakCompletion(true);
    tts.speak("Xin chao");
  }
}

void main() {
  TTS.init();
  runApp(DevicePreview(builder: (context) => ProviderScope(child: App())));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTheme = ref.watch(activeThemeProvider);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      themeMode: activeTheme == Themes.dark ? ThemeMode.dark : ThemeMode.light,
      home: const ChatScreen(),
    );
  }
}
