import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app_tdd/core/constants/api_urls.dart';
import 'package:flutter_weather_app_tdd/data/data_sources/remote_data_source.dart';
import 'package:flutter_weather_app_tdd/data/models/weather_model.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../helpers/json_reader.dart';

class MockHTTPClient extends Mock implements Client {}

void main() {
  late WeatherRemoteDataSourceImpl remoteDataSource;
  late MockHTTPClient mockHTTPClient;

  setUp(() {
    mockHTTPClient = MockHTTPClient();
    remoteDataSource = WeatherRemoteDataSourceImpl(client: mockHTTPClient);
  });

  const String testCity = "Dhaka";

  test('Should return a weather model if response is 200', () async {
    //arrange
    when(
      () => mockHTTPClient.get(
        Uri.parse(ApiUrls.currentWeatherByName(testCity)),
      ),
    ).thenAnswer((invocation) async {
      return Response(
          readJson('helpers/dummy_data/dummy_weather_response.json'), 200);
    });

    //Act
    final result = await remoteDataSource.getCurrentWeather(testCity);

    //Assert
    expect(result, isA<WeatherModel>());
  });
}
