import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:film/core/api/dio_client.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/prayer/data/models/prayer_time_dm.dart';
import 'package:film/features/tabs/prayer/domain/entities/pray_time_entity.dart';
import 'package:injectable/injectable.dart';

abstract class RemotePrayerTimesDataSource {
  Future<Either<Failure, PrayTimeEntity>> getPrayerTimes();
}

@Injectable(as: RemotePrayerTimesDataSource)
class RemotePrayerTimesDataSourceImp implements RemotePrayerTimesDataSource {
  ApiManager apiManager;
  RemotePrayerTimesDataSourceImp(this.apiManager);
  @override
  Future<Either<Failure, PrayTimeEntity>> getPrayerTimes() async {
    try {
      final response = await apiManager.getData(
        'https://api.aladhan.com/v1/timingsByCity',
        queryParameters: {
          'city': 'Cairo',
          'country': 'Egypt',
          'method': 5,
        },
      );

      if (response.statusCode != 200) {
        return Left(ServerFailure(
          message: 'Server error: ${response.statusCode}',
        ));
      }

      try {
        final prayerTimes = PrayTimeDm.fromJson(response.data);
        if (prayerTimes.status?.toLowerCase() != 'ok') {
          return Left(ServerFailure(
            message: prayerTimes.status ?? 'Unknown server error',
          ));
        }
        return Right(prayerTimes);
      } catch (e) {
        return Left(ParsingFailure(
          message: 'Failed to parse prayer times: ${e.toString()}',
        ));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: 'Network error: ${e.message ?? 'Unknown error'}',
      ));
    } catch (e) {
      return Left(UnknownFailure(
        message: 'Unexpected error: ${e.toString()}',
      ));
    }
  }
}
