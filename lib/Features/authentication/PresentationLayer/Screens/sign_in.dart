import 'package:cellula_first_app/Features/Home/Presentation/Screens/search.dart';
import 'package:cellula_first_app/Features/authentication/PresentationLayer/Screens/sign_up.dart';
import 'package:cellula_first_app/Features/authentication/PresentationLayer/Widgets/custom_button.dart';
import 'package:cellula_first_app/Features/authentication/PresentationLayer/Widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth fireBase = FirebaseAuth.instance;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final eMailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isAuthentication = false;

  @override
  void dispose() {
    eMailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff001739),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 180),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      letterSpacing: 4,
                      color: Colors.white,
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextFormField(
                    controller: eMailController,
                    labelText: 'Email',
                    prefixIcon: Icons.email,
                    validator: (value) =>
                        value!.isEmpty ? "Please enter your email" : null,
                  ),
                  const SizedBox(height: 26),
                  CustomTextFormField(
                      controller: passwordController,
                      labelText: 'Password',
                      validator: (value) =>
                          value!.isEmpty ? "Please enter your password" : null,
                      prefixIcon: Icons.lock),
                  const SizedBox(height: 12),
                  buildForgotPassword(),
                  const SizedBox(height: 46),
                  buildLoginButton(context),
                  const SizedBox(height: 18),
                  buildSignUpLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForgotPassword() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Forgot Password?',
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_formKey.currentState!.validate()) {
          setState(() {});
          return;
        }
        login(context);
      },
      child: CustomButton(isAuthentication: isAuthentication),
    );
  }

  Widget buildSignUpLink(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const SignUp()));
        },
        child: const Text(
          'Don`t have an account?',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isAuthentication = true);

    try {
      await fireBase.signInWithEmailAndPassword(
        email: eMailController.text,
        password: passwordController.text,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Search()),
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      setState(() => isAuthentication = false);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          error.message ?? 'Authentication Failed',
          style: const TextStyle(
            color: Color(0xff001739),
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }
  }
}
