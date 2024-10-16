import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'Features/Home/DataLayer/repos/weather_data_repo.dart';
import 'Features/Home/Presentation/BuisinessLogic/weather_cubit.dart';
import 'Features/authentication/PresentationLayer/Screens/sign_in.dart';
import 'Features/authentication/PresentationLayer/Screens/splash.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (_) => WeatherCubit(WeatherDataRepo()),
        ),
      ],
      child: const WeatherExpectation(),
    ),
  );

  LocationPermission permission = await Geolocator.requestPermission();
}

class WeatherExpectation extends StatelessWidget {
  const WeatherExpectation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
            create: (_) => WeatherCubit(WeatherDataRepo()),
            child: FirebaseAuth.instance.currentUser == null
                ? const SignIn()
                : const Splash()));
  }
}
