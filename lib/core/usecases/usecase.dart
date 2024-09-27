import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app_tdd/core/error/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
