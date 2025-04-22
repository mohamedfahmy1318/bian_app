// get_azkar_by_category_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:film/core/errors/failures.dart';
import 'package:film/features/tabs/azkar/domain/entities/azkar_entity.dart';
import 'package:film/features/tabs/azkar/domain/repositories/azkar_repository.dart';
import 'package:film/features/tabs/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAzkarByCategoryUseCase {
  final AzkarRepository _repository;

  GetAzkarByCategoryUseCase(this._repository);

  Future<Either<Failure, List<AzkarEntity>>> call(String categoryId) {
    return _repository.getAzkarByCategory(categoryId);
  }
}

// get_all_azkar_categories_use_case.dart
@injectable
class GetAllAzkarCategoriesUseCase {
  final AzkarRepository _repository;

  GetAllAzkarCategoriesUseCase(this._repository);

  Future<Either<Failure, List<AzkarCategory>>> call() async {
    final categories = [
      {'id': '27', 'title': 'أذكار الصباح والمساء'},
      {'id': '25', 'title': 'اذكار بعد السلام من الصلاة'},
      {'id': '129', 'title': 'الاستغفار و التوبة'},
      {'id': '130', 'title': 'فضل التسبيح و التحميد، و التهليل، و التكبير'},
      {'id': '131', 'title': 'كيف كان النبي يسبح؟'},
      {'id': '15', 'title': 'أذكار الأذان'},
      {'id': '34', 'title': 'دعاء الهم والحزن'},
      {'id': '35', 'title': 'دعاء الكرب'},
      {'id': '43', 'title': "دعاء من استصعب عليه أمر"},
      {'id': '44', 'title': 'ما يقول ويفعل من أذنب ذنبا'},
      {'id': '55', 'title': 'الدعاء للميت في الصلاة عليه'},
      {'id': '59', 'title': 'الدعاء بعد دفن الميت'},
      {'id': '60', 'title': 'دعاء زيارة القبور'},
      {'id': '64', 'title': 'الدعاء إذا نزل المطر'},
      {'id': '68', 'title': 'الدعاء عند إفطار الصائم'},
      {'id': '75', 'title': 'ما يقول الصائم إذا سابه أحد'},
      {'id': '77', 'title': "دعاء العطاس"},
      {'id': '83', 'title': 'دعاء من رأى مبتلى'},
      {'id': '96', 'title': 'دعاء السفر'},
      {'id': '107', 'title': 'فضل الصلاة على النبي صلى الله عليه و سلم'},
      {'id': '119', 'title': 'الدعاء يوم عرفة'},
      {'id': '127', 'title': 'ما يقول عند الذبح أو النحر'},
      {'id': '28', 'title': 'أذكار النوم'},
      {'id': '1', 'title': 'أذكار الإستيقاظ من النوم '},
    ];

    final results = <AzkarCategory>[];

    for (var category in categories) {
      final result = await _repository.getAzkarByCategory(category['id']!);
      result.fold(
        (failure) => Left(failure),
        (azkar) => results.add(AzkarCategory(
          id: category['id']!,
          title: category['title']!,
          azkar: azkar,
        )),
      );
    }

    return Right(results);
  }
}
