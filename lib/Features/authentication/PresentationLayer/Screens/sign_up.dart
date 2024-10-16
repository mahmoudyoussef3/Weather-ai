import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tset_github/Features/authentication/PresentationLayer/Screens/sign_in.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/text_form_field.dart';

FirebaseAuth fireBase = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final eMailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    eMailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool authenticated = false;

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
                    'Create a new account',
                    style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),

                  CustomTextFormField(
                    controller: fullNameController,
                    labelText: 'Full Name',
                    prefixIcon: Icons.person,
                    validator: (value) =>
                        value!.isEmpty ? "Enter your full name!" : null,
                  ),

                  const SizedBox(height: 26),

                  // Email TextFormField
                  CustomTextFormField(
                    controller: eMailController,
                    labelText: 'Email',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.isEmpty ? "Enter a valid email!" : null,
                  ),

                  const SizedBox(height: 26),

                  // Password TextFormField
                  CustomTextFormField(
                    controller: passwordController,
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? "Enter your password!" : null,
                  ),

                  const SizedBox(height: 46),

                  GestureDetector(
                      onTap: () {
                        validateCreateAccount(context)
                            ? setState(() {
                                authenticated = true;
                                createAccount(context);
                              })
                            : () {
                                null;
                              };
                      },
                      child: CustomButton(
                        isAuthentication: authenticated,
                        buttonText: 'SIGN-UP',
                      )),

                  const SizedBox(height: 18),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignIn(),
                          ),
                        );
                      },
                      child: const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateCreateAccount(BuildContext context) {
    return _formKey.currentState!.validate();
  }

  void createAccount(BuildContext context) async {
    if (validateCreateAccount(context)) {
      setState(() {
        authenticated = true;
      });
      _formKey.currentState!.save();
      try {
        final userCredential = await fireBase.createUserWithEmailAndPassword(
            email: eMailController.text, password: passwordController.text);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Account Created Successfully',
            style: TextStyle(
              color: Color(0xff001739),
              fontWeight: FontWeight.bold,
            ),
          ),
        ));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignIn(),
          ),
        );
      } on FirebaseAuthException catch (error) {
        setState(() {
          authenticated = false;
        });
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
}
