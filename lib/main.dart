import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Features/authentication/PresentationLayer/Screens/splash.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      const WeatherExpectation()
  );
}
class WeatherExpectation extends StatelessWidget {
  const WeatherExpectation({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  Splash());
  }
}
