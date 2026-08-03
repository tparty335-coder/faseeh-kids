import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import '../logic/parent_provider.dart';
import '../widgets/progress_chart.dart';

class ProgressReportScreen extends ConsumerWidget {
  const ProgressReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyStats = ref.watch(weeklyStatsProvider);
    final letterMastery = ref.watch(letterMasteryGridProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('تقرير التقدم التفصيلي'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'النشاط الأسبوعي (دقائق)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ProgressChart(weeklyMinutes: weeklyStats),
              
              const SizedBox(height: 32),
              const Text(
                'إتقان الحروف',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: letterMastery.length,
                    itemBuilder: (context, index) {
                      final letter = letterMastery.keys.elementAt(index);
                      final mastery = letterMastery[letter] ?? 0.0;
                      
                      Color bgColor;
                      if (mastery >= 1.0) {
                        bgColor = Colors.green;
                      } else if (mastery > 0) {
                        bgColor = Colors.orange;
                      } else {
                        bgColor = Colors.grey.shade300;
                      }

                      return Container(
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          letter,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: mastery > 0 ? Colors.white : Colors.black54,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              const Text(
                'نقاط القوة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const ListTile(
                leading: Icon(Icons.thumb_up, color: Colors.green),
                title: Text('التعرف السريع على الحروف'),
                subtitle: Text('أظهر تحسناً كبيراً في التعرف على الحروف (أ، ب، ت)'),
              ),
              const ListTile(
                leading: Icon(Icons.thumb_up, color: Colors.green),
                title: Text('الاستمرارية'),
                subtitle: Text('تدرب لمدة ٣ أيام متتالية هذا الأسبوع'),
              ),
              
              const SizedBox(height: 16),
              const Text(
                'مجالات للتحسين',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const ListTile(
                leading: Icon(Icons.trending_up, color: Colors.orange),
                title: Text('نطق الحروف اللثوية'),
                subtitle: Text('يحتاج مزيداً من التدريب على حروف (ث، ذ، ظ)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
