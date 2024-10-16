part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherCountryUpdated extends WeatherState {
  final String country;
  WeatherCountryUpdated(this.country);
}

class WeatherLoaded extends WeatherState {
  final WeatherDataModel weatherDataModel;
  WeatherLoaded(this.weatherDataModel);
}

class WeatherError extends WeatherState {
  final String errorMessage;
  WeatherError(this.errorMessage);
}
