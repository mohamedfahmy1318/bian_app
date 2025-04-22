import 'package:dartz/dartz.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/prayer/domain/entities/pray_time_entity.dart';

abstract class PrayerTimesRepo {
  Future<Either<Failure, PrayTimeEntity>> getPrayerTimes();
}
