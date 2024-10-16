import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/PresentationLayer/Screens/sign_in.dart';
import '../../../authentication/PresentationLayer/Widgets/custom_button.dart';
import '../../../authentication/PresentationLayer/Widgets/text_form_field.dart';
import '../../DataLayer/repos/weather_data_repo.dart';
import '../BuisinessLogic/weather_cubit.dart';
import 'home.dart';
import 'package:geolocator/geolocator.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ));
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: const Color(0xff001739),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: BlocProvider(
            create: (context) => WeatherCubit(WeatherDataRepo()),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                  controller: searchController,
                  labelText: 'Search',
                  prefixIcon: Icons.sunny),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  if (searchController.text.isNotEmpty) {
                    context.read<WeatherCubit>().country =
                        searchController.text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                  }
                },
                child: const CustomButton(
                  isAuthentication: false,
                  buttonText: 'Search',
                ),
              )
            ]),
          ),
        ));
  }
}
