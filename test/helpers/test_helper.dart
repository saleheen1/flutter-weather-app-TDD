import 'package:flutter_weather_app_tdd/data/data_sources/weather_remote_data_source.dart';
import 'package:flutter_weather_app_tdd/domain/repositories/weather_repository.dart';
import 'package:flutter_weather_app_tdd/domain/usecases/get_current_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [WeatherRepository, WeatherRemoteDataSource, GetCurrentWeather],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
