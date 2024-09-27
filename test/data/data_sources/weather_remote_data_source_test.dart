import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app_tdd/core/constants/api_urls.dart';
import 'package:flutter_weather_app_tdd/core/error/exception.dart';
import 'package:flutter_weather_app_tdd/data/data_sources/weather_remote_data_source.dart';
import 'package:flutter_weather_app_tdd/data/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WeatherRemoteDataSourceImpl remoteDataSource;
  late MockHttpClient mockHTTPClient;

  setUp(() {
    mockHTTPClient = MockHttpClient();
    remoteDataSource = WeatherRemoteDataSourceImpl(client: mockHTTPClient);
  });

  const String testCity = "Dhaka";

  group('Test the get weather remote repository', () {
    test('Should return a weather model if response is 200', () async {
      //arrange
      when(mockHTTPClient
              .get(Uri.parse(ApiUrls.currentWeatherByName(testCity))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'), 200));

      //Act
      final result = await remoteDataSource.getCurrentWeather(testCity);

      //Assert
      expect(result, isA<WeatherModel>());
    });

    test('Should return server exception if response is other than 200',
        () async {
      //arrange
      when(
        mockHTTPClient.get(Uri.parse(ApiUrls.currentWeatherByName(testCity))),
      ).thenAnswer((_) async => http.Response('Not found', 404));

      //Act
      final result = remoteDataSource.getCurrentWeather(testCity);

      //Assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
