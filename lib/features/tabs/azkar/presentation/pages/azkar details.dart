import 'package:film/features/tabs/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AzkarCategoryScreen extends StatelessWidget {
  final AzkarCategory category;

  const AzkarCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text(category.title)
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(begin: 0.5),
        centerTitle: true,
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
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: category.azkar.length,
        itemBuilder: (context, index) {
          final item = category.azkar[index];
          return Card(
            elevation: 0,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Color(0xFF1E1E1E),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFF333333)),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item.arabicText,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3700B3).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'التكرار: ${item.repeat} مرات',
                          style: TextStyle(
                            color: Color(0xFFBB86FC),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.repeat, color: Color(0xFFBB86FC), size: 18),
                      ],
                    ),
                  ),
                  if (item.reference.isNotEmpty) ...[
                    SizedBox(height: 12),
                    Text(
                      'المرجع: ${item.reference}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1);
        },
      ),
    );
  }
}
