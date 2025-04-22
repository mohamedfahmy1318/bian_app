import 'package:dartz/dartz.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/prayer/domain/entities/pray_time_entity.dart';
import 'package:film/features/tabs/prayer/domain/repositories/prayer_times_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class PrayerTimeUseCase {
  PrayerTimesRepo _prayerTimesRepo;
  PrayerTimeUseCase(this._prayerTimesRepo);
  Future<Either<Failure, PrayTimeEntity>> call() async {
    return await _prayerTimesRepo.getPrayerTimes();
  }
}
