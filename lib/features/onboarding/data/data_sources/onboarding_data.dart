import 'package:film/core/utils/app_images.dart';
import 'package:film/features/onboarding/domain/models/onboarding_model.dart';

List<OnboardingModel> onboardingData = [
  OnboardingModel(
    mainImage: AppImages.onBoardingImage1,
    headerImage: AppImages.headerImage,
    title: "مرحباً بكم في تطبيق بيان",
    description:
        "تعرف على القرآن، الأحاديث والإذاعة الإسلامية ومواقيت الصلاة في وقت واحد",
  ),
  OnboardingModel(
    headerImage: AppImages.headerImage,
    title: "القرآن الكريم",
    description: "اقرأ واستمع إلى القرآن الكريم بتلاوات متعددة",
    mainImage: AppImages.onBoardingImage3,
  ),
  OnboardingModel(
    title: "الأحاديث النبوية",
    description: "تصفح أحاديث النبي ﷺ من مصادر موثوقة",
    headerImage: AppImages.headerImage,
    mainImage: AppImages.onBoardingImage2,
  ),
  OnboardingModel(
    title: "سبحة إلكترونية سهلة وسريعة",
    description: "عدّ تسبيحاتك، تابع أذكارك، وقرّب من ربنا بخطوة بسيطة",
    headerImage: AppImages.headerImage,
    mainImage: AppImages.onBoardingImage4,
  ),
  OnboardingModel(
    title: "الإذاعة الإسلامية",
    description: "استمع إلى إذاعات القرآن والدروس الدينية",
    headerImage: AppImages.headerImage,
    mainImage: AppImages.onBoardingImage5,
  ),
];
