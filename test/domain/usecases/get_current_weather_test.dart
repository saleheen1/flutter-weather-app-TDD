import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app_tdd/domain/entities/weather.dart';
import 'package:flutter_weather_app_tdd/domain/usecases/get_current_weather.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeather getCurrentWeather;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeather =
        GetCurrentWeather(weatherRepository: mockWeatherRepository);
  });

  const testWeatherDetail = Weather(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test('should get current weather detail from the repository', () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));

    // act
    final result = await getCurrentWeather(testCityName);

    // assert
    expect(result, const Right(testWeatherDetail));
  });
}
