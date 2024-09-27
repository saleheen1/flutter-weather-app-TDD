import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app_tdd/core/error/failure.dart';
import 'package:flutter_weather_app_tdd/domain/entities/weather.dart';
import 'package:flutter_weather_app_tdd/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository weatherRepository;

  GetCurrentWeather(this.weatherRepository);

  Future<Either<Failure, Weather>> call(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
