
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../DataLayer/Models/WeatherModel.dart';
import '../../DataLayer/repos/weather_data_repo.dart';
part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherDataRepo repo;
  String mySelectedDate = '';
  WeatherCubit(this.repo) : super(WeatherInitial());
  String country = '';

  Future<void> fetchWeatherData() async {
    emit(WeatherLoading());
    try {
      final weatherData = await repo.getWeatherData(country: country);
      emit(WeatherLoaded(weatherData));
    } catch (error) {
      print('Error message: $error');
      emit(WeatherError(error.toString()));
    }
  }
}
