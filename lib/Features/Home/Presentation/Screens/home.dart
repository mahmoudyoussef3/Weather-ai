
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/colors.dart';
import '../../../authentication/PresentationLayer/Screens/sign_in.dart';
import '../../DataLayer/Models/WeatherModel.dart';
import '../BuisinessLogic/weather_cubit.dart';
import '../Widgets/buildAstroDetail.dart';
import '../Widgets/buildBarChart.dart';
import '../Widgets/buildLineChart.dart';
import '../Widgets/buildWeatherDetail.dart';

class Home extends StatefulWidget {
  Home({super.key});
  WeatherDataModel weatherDataModel = WeatherDataModel();

  @override
  State<Home> createState() => _HomeState();
  String myDateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().fetchWeatherData();
  }

  void updateDate(String selectedDate) {
    setState(() {
      widget.myDateTime = selectedDate; // Update the date
    });

    // Fetch weather data for the new date if necessary
    context.read<WeatherCubit>().fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
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
      backgroundColor: MyColors.appMainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Center(
                  child: BlocBuilder<WeatherCubit, WeatherState>(
                      builder: (context, state) {
                    if (state is WeatherLoaded) {
                      List<Forecastday>? forecastDays =
                          state.weatherDataModel.forecast?.forecastday;

                      Forecastday? selectedForecast = forecastDays?.firstWhere(
                        (forecast) => forecast.date == widget.myDateTime,
                        orElse: () => Forecastday(),
                      );

                      if (selectedForecast != null) {
                        return Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    state.weatherDataModel.location!.region!,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                ),
                                Text(
                                  widget.myDateTime,
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              ],
                            ),
                            Image.network(
                              "https:${selectedForecast.day?.condition?.icon ?? ''}", // Display weather icon
                            ),
                            Text(
                              "${selectedForecast.day?.maxtempC}°C / ${selectedForecast.day?.mintempC}°C",
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 24),
                            ),
                            const SizedBox(height: 10),
                            BuildWeatherDetail(
                              icon: Icons.air,
                              value: "${selectedForecast.day?.maxwindKph} km/h",
                              label: "Wind",
                            ),
                            BuildWeatherDetail(
                              icon: Icons.water_drop,
                              value: "${selectedForecast.day?.avghumidity}%",
                              label: "Humidity",
                            ),
                            BuildWeatherDetail(
                              icon: Icons.wb_sunny,
                              value: "${selectedForecast.day?.uv}",
                              label: "UV Index",
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BuildAstroDetails(
                                  label: "Sunrise",
                                  value: selectedForecast.astro?.sunrise ?? "",
                                ),
                                BuildAstroDetails(
                                  label: "Sunset",
                                  value: selectedForecast.astro?.sunset ?? "",
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            BuildLineChart(
                              label: 'Temperature (°C)',
                              data: [
                                selectedForecast.day!.mintempC!.toDouble(),
                                selectedForecast.day!.avgtempC!.toDouble(),
                                selectedForecast.day!.maxtempC!.toDouble(),
                              ],
                            ),
                            const SizedBox(height: 20),
                            BuildBarChart(
                              label: 'Wind Speed (km/h)',
                              data:
                                  selectedForecast.day!.maxwindKph!.toDouble(),
                            ),
                          ],
                        );
                      } else {
                        return const Text(
                          "No data for selected date",
                          style: TextStyle(color: Colors.white),
                        );
                      }
                    } else if (state is WeatherError) {
                      return Text(state.errorMessage);
                    } else if (state is WeatherLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return const Text(
                        "No data available",
                        style: TextStyle(color: Colors.white),
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
