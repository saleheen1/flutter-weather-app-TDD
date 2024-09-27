part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnCityChanged extends WeatherEvent {
  final String cityName;

  OnCityChanged(this.cityName);
}
