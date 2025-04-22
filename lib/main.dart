import 'package:film/config/routes/generate_route.dart';
import 'package:film/config/theme/app_theme.dart';
import 'package:film/core/di/di.dart';
import 'package:film/core/utils/bloc_observer.dart';
import 'package:film/features/main/pages/main_sccreen.dart';
import 'package:film/features/main/pages/noconnection.dart';
import 'package:film/features/tabs/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:film/features/tabs/prayer/presentation/manager/cubit/prayer_times_cubit.dart';
import 'package:film/features/tabs/sebha/data/data_sources/local_sebha_data_source.dart';
import 'package:film/features/tabs/sebha/data/models/sebha_hive_model.dart';
import 'package:film/features/tabs/sebha/presentation/manager/sebha_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Bloc observer for debugging
  Bloc.observer = MyBlocObserver();

  // Setup dependency injection
  await configureDependencies();

  // Check internet connection
  final hasConnection = await InternetConnectionChecker().hasConnection;

  // Initialize Hive for local storage
  await Hive.initFlutter();
  Hive.registerAdapter(SebhaHiveModelAdapter());

  // Open the Hive box
  await Hive.openBox<SebhaHiveModel>('sebha_box');

  // Initialize default sebha data
  final localDataSource = LocalSebhaDataSource();
  await localDataSource.initializeDefaultSebha();

  runApp(
    MyApp(
      hasInitialConnection: hasConnection,
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool hasInitialConnection;

  const MyApp({
    super.key,
    required this.hasInitialConnection,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late bool _hasConnection;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _hasConnection = widget.hasInitialConnection;

    // Initialize animation controller for splash effects
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    // Listen for connectivity changes
    InternetConnectionChecker().onStatusChange.listen((status) {
      setState(() {
        _hasConnection = status == InternetConnectionStatus.connected;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _retryConnection() async {
    final newConnectionStatus = await InternetConnectionChecker().hasConnection;
    setState(() {
      _hasConnection = newConnectionStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<PrayerTimesCubit>()..getAllTimes(),
        ),
        BlocProvider(
          create: (context) => getIt<AzkarCubit>()..loadAllCategories(),
        ),
        BlocProvider(
          create: (context) => getIt<SebhaCubit>()..loadSebha(),
        ),
      ],
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'تطبيق الذكر والتسبيح',
          theme: AppTheme.darkTheme.copyWith(
            // Add some additional theme customizations
            cardTheme: CardTheme(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(8),
            ),
            buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          onGenerateRoute: GenerateRoute.generateRoute,
          home: _hasConnection
              ? AnimatedMainScreen() // Our enhanced main screen
              : NoConnectionScreen(
                  onRetry: _retryConnection,
                ),
        ),
      ),
    );
  }
}

class AnimatedMainScreen extends StatelessWidget {
  const AnimatedMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainScreen(), // Your existing main screen with new animations
    );
  }
}
