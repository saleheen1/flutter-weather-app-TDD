import 'package:flutter_weather_app_tdd/domain/usecases/get_current_weather.dart';
import 'package:get_it/get_it.dart';
import 'data/data_sources/weather_remote_data_source.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/weather_repository.dart';
import 'presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // bloc
  serviceLocator.registerFactory(() => WeatherBloc(serviceLocator()));

  // usecase
  serviceLocator.registerLazySingleton(
      () => GetCurrentWeather(weatherRepository: serviceLocator()));

  // repository
  serviceLocator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: serviceLocator()),
  );

  // data source
  serviceLocator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: serviceLocator(),
    ),
  );

  // external
  serviceLocator.registerLazySingleton(() => http.Client());
}
