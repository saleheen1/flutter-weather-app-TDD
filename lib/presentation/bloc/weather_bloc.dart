import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app_tdd/domain/entities/weather.dart';
import 'package:flutter_weather_app_tdd/domain/usecases/get_current_weather.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather _getCurrentWeather;

  WeatherBloc(this._getCurrentWeather) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) => emit(WeatherLoading()));
    on<OnCityChanged>(_onCityChanged);
  }

  void _onCityChanged(
    OnCityChanged event,
    Emitter<WeatherState> emit,
  ) async {
    final res = await _getCurrentWeather(event.cityName);

    res.fold(
      (error) => emit(WeatherLoadFailue(error.message)),
      (data) => emit(WeatherLoaded(data)),
    );
  }
}
