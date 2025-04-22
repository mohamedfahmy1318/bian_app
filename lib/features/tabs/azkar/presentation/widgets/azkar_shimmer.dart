import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AzkarShimmer extends StatelessWidget {
  const AzkarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: 10,
        separatorBuilder: (_, __) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xFF1E1E1E),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Arabic Text
                Container(
                  height: 20,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF333333),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Repeat & Audio
                Container(
                  height: 16,
                  width: 100,
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFF333333),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .shimmer(
                delay: (index * 100).ms,
                duration: 1000.ms,
                color: Color(0xFFBB86FC).withOpacity(0.1),
              );
        },
      ),
    );
  }
}
