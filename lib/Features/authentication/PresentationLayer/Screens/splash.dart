import 'package:cellula_first_app/Features/authentication/PresentationLayer/Screens/sign_in.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // @override
  // void initState() {
  //   super.initState();
  //   navigationToHHomeScreen();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff001739),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.white),
                    width: MediaQuery.of(context).size.width - 280,
                    height: 40,
                    child: const Center(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          letterSpacing: 2,
                          color: Color(0xff001739),
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
              builder: (context) => const SignIn(),
            ));
      },
    );
  }
}
