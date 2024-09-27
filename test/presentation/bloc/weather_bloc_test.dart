import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app_tdd/core/error/failure.dart';
import 'package:flutter_weather_app_tdd/domain/entities/weather.dart';
import 'package:flutter_weather_app_tdd/presentation/bloc/weather_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeather mockGetCurrentWeather;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    weatherBloc = WeatherBloc(mockGetCurrentWeather);
  });

  const testWeather = Weather(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherInitial());
  });

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
      build: () {
        when(mockGetCurrentWeather(testCityName))
            .thenAnswer((_) async => const Right(testWeather));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [WeatherLoading(), WeatherLoaded(testWeather)]);

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful',
      build: () {
        when(mockGetCurrentWeather(testCityName)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            WeatherLoading(),
            WeatherLoadFailue('Server failure'),
          ]);
}
