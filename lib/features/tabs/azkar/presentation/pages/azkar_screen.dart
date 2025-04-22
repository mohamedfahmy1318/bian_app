import 'package:film/features/tabs/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:film/features/tabs/azkar/presentation/pages/azkar%20details.dart';
import 'package:film/features/tabs/azkar/presentation/widgets/azkar_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: const Text('أذكار وأدعية')
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(begin: 0.5),
        titleTextStyle: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E1E1E),
                Color(0xFF121212),
              ],
            ),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<AzkarCubit, AzkarState>(
        listener: (context, state) {
          if (state is AzkarError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.message),
                backgroundColor: Color(0xFFB00020),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AzkarLoading) {
            return const AzkarShimmer();
          } else if (state is AzkarCategoriesLoaded) {
            return _buildCategoriesList(state.categories, context);
          } else if (state is AzkarError) {
            return _buildErrorState(state, context);
          }
          return _buildInitialState(context);
        },
      ),
    );
  }

  Widget _buildCategoriesList(
      List<AzkarCategory> categories, BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Color(0xFF1E1E1E),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: 500.ms,
                  pageBuilder: (_, __, ___) =>
                      AzkarCategoryScreen(category: category),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFF333333)),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      category.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      color: Color(0xFFBB86FC), size: 20),
                ],
              ),
            ),
          ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1),
        );
      },
    );
  }

  Widget _buildErrorState(AzkarError state, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 50, color: Color(0xFFCF6679))
              .animate()
              .shake(duration: 600.ms),
          SizedBox(height: 16),
          Text(
            'حدث خطأ',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            state.failure.message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[400]),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<AzkarCubit>().loadAllCategories(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFBB86FC),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => context.read<AzkarCubit>().loadAllCategories(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFBB86FC),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        child: Text('تحميل الأذكار'),
      ),
    );
  }
}
