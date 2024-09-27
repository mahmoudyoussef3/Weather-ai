import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.isAuthentication});
  final bool isAuthentication;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: const Color.fromARGB(255, 1, 88, 160),
        ),
        width: MediaQuery.of(context).size.width - 100,
        height: 50,
        child: Center(
          child: isAuthentication
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
            'LOGIN',
            style: TextStyle(
              letterSpacing: 3,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
