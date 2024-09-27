part of 'weather_bloc.dart';

@immutable
sealed class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WeatherInitial extends WeatherState {}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather result;

  WeatherLoaded(this.result);
}

class WeatherLoadFailue extends WeatherState {
  final String message;

  WeatherLoadFailue(this.message);
}
