import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';

class ParentGateScreen extends StatefulWidget {
  const ParentGateScreen({super.key});

  @override
  State<ParentGateScreen> createState() => _ParentGateScreenState();
}

class _ParentGateScreenState extends State<ParentGateScreen> {
  late int num1;
  late int num2;
  late int answer;
  String input = '';
  int failedAttempts = 0;
  bool isLocked = false;
  int lockTimer = 0;
  Timer? _timer;
  
  int countdown = 10;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _generateProblem();
  }

  void _generateProblem() {
    final random = Random();
    num1 = random.nextInt(9) + 2; // 2-10
    num2 = random.nextInt(9) + 2;
    answer = num1 * num2;
    input = '';
    countdown = 10;
    
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        _handleFailure();
      }
    });
  }

  void _handleFailure() {
    _countdownTimer?.cancel();
    setState(() {
      failedAttempts++;
      if (failedAttempts >= 3) {
        _lockOut();
      } else {
        _generateProblem();
      }
    });
  }

  void _lockOut() {
    isLocked = true;
    lockTimer = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (lockTimer > 0) {
        setState(() {
          lockTimer--;
        });
      } else {
        setState(() {
          isLocked = false;
          failedAttempts = 0;
          _generateProblem();
        });
        timer.cancel();
      }
    });
  }

  void _onKeyPress(String key) {
    if (isLocked) return;
    setState(() {
      if (input.length < 3) {
        input += key;
      }
    });
    
    if (input.length == answer.toString().length) {
      if (int.tryParse(input) == answer) {
        _countdownTimer?.cancel();
        context.go('/parent-dashboard'); // Navigate to dashboard
      } else {
        _handleFailure();
      }
    }
  }

  void _onClear() {
    setState(() {
      input = '';
    });
  }

  String _toArabicNumerals(String text) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (int i = 0; i < english.length; i++) {
      text = text.replaceAll(english[i], arabic[i]);
    }
    return text;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('بوابة الآباء'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: isLocked
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.lock, size: 64, color: Colors.red),
                        const SizedBox(height: 24),
                        const Text(
                          'تم قفل الشاشة مؤقتاً',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'يرجى المحاولة بعد ${_toArabicNumerals(lockTimer.toString())} ثانية',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'هذا القسم مخصص للآباء',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'يرجى حل المسألة التالية للمتابعة:',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_toArabicNumerals(num1.toString())} × ${_toArabicNumerals(num2.toString())} = ',
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 80,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primary, width: 2),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Text(
                                _toArabicNumerals(input),
                                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'الوقت المتبقي: ${_toArabicNumerals(countdown.toString())}',
                          style: TextStyle(
                            fontSize: 18,
                            color: countdown <= 3 ? Colors.red : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 32),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            if (index == 9) {
                              return const SizedBox.shrink(); // Empty space
                            }
                            if (index == 11) {
                              return ElevatedButton(
                                onPressed: _onClear,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade100,
                                  foregroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Icon(Icons.backspace),
                              );
                            }
                            final number = index == 10 ? 0 : index + 1;
                            return ElevatedButton(
                              onPressed: () => _onKeyPress(number.toString()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              child: Text(
                                _toArabicNumerals(number.toString()),
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
