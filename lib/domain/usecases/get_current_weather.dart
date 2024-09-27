import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app_tdd/core/error/failure.dart';
import 'package:flutter_weather_app_tdd/core/usecases/usecase.dart';
import 'package:flutter_weather_app_tdd/domain/entities/weather.dart';
import 'package:flutter_weather_app_tdd/domain/repositories/weather_repository.dart';

class GetCurrentWeather implements UseCase<Weather, String> {
  final WeatherRepository weatherRepository;

  GetCurrentWeather({required this.weatherRepository});

  @override
  Future<Either<Failure, Weather>> call(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
