import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app_tdd/core/error/failure.dart';
import 'package:flutter_weather_app_tdd/data/data_sources/weather_remote_data_source.dart';
import 'package:flutter_weather_app_tdd/domain/repositories/weather_repository.dart';
import 'package:flutter_weather_app_tdd/domain/entities/weather.dart';

import '../../core/error/exception.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
