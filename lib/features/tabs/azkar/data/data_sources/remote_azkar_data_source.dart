// remote_azkar_data_source.dart
import 'package:dio/dio.dart';
import 'package:film/core/api/dio_client.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/azkar/data/models/azkar_dm.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

// remote_azkar_data_source.dart

abstract class RemoteAzkarDataSource {
  Future<List<AzkarDm>> getAzkar(String categoryId);
}

@Injectable(as: RemoteAzkarDataSource)
class RemoteAzkarDataSourceImpl implements RemoteAzkarDataSource {
  final ApiManager _apiManager;
  final Logger _logger;

  RemoteAzkarDataSourceImpl(this._apiManager)
      : _logger = Logger(
          printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5),
        );

  @override
  Future<List<AzkarDm>> getAzkar(String categoryId) async {
    try {
      final response = await _apiManager.getData(
        'https://www.hisnmuslim.com/api/ar/$categoryId.json',
      );
      _logger.i('Azkar API Response received for category: $categoryId');
      return _parseAzkarResponse(response.data);
    } on DioException catch (e) {
      _logger.e('DioError in getAzkar', error: e);
      throw ServerFailure(message: 'Failed to load azkar: ${e.message}');
    } catch (e) {
      _logger.e('Unexpected error in getAzkar', error: e);
      throw UnknownFailure(message: 'Unexpected error: ${e.toString()}');
    }
  }

  List<AzkarDm> _parseAzkarResponse(dynamic data) {
    try {
      if (data == null || data is! Map<String, dynamic>) {
        throw const FormatException('Invalid response data');
      }

      final azkarKey = data.keys.first;
      if (data[azkarKey] == null || data[azkarKey] is! List) {
        throw const FormatException('Missing or invalid azkar data');
      }

      return (data[azkarKey] as List).map((item) {
        return AzkarDm.fromJson(item as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      _logger.e('Error parsing azkar response', error: e);
      throw FormatException('Failed to parse azkar data: ${e.toString()}');
    }
  }
}
