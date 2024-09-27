part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class OnCityChanged extends WeatherEvent {
  final String cityName;

  OnCityChanged(this.cityName);
}
