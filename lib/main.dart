import 'package:flutter/material.dart';
import 'package:flutters/providers/tts.provider.dart';
import 'package:flutters/screens/ads.screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  RequestConfiguration requestConfiguration = RequestConfiguration(
    testDeviceIds: ['92ee116e-bb49-4e82-a7ee-4d9a7cf920a7'],
  );
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  runApp(ChangeNotifierProvider(create: (_) => TTSProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AdsScreen());
  }
}
