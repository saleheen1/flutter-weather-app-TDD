import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app_tdd/core/error/failure.dart';
import 'package:flutter_weather_app_tdd/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
