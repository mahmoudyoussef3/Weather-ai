import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../Home/Presentation/BuisinessLogic/weather_cubit.dart';
import '../../../Home/Presentation/Screens/search.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

late StreamSubscription<User?> user;

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    getLocationData();
    navigationToHHomeScreen();
  }

  Future<void> getLocationData() async {
    final weatherCubit = context.read<WeatherCubit>();

    try {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Update the country first

      // BlocConsumer will now listen for WeatherCountryUpdated and fetch weather data
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff001739),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/logo/my_logo.jpg'),
            ),
          ],
        ),
      ),
    );
  }

  navigationToHHomeScreen() async {
    await Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Search(),
            ));
      },
    );
  }
}
