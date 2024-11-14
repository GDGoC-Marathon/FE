import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 새로고침할 때마다 Key를 변경하여 전체 위젯을 다시 빌드
  Key _appKey = UniqueKey();

  // 전체 페이지를 새로고침하는 함수
  void _refreshPage() {
    setState(() {
      _appKey = UniqueKey(); // 새 Key를 생성하여 전체 페이지를 리빌드
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: _appKey, // 전체 앱에 Key 적용
      home: Scaffold(
        appBar: AppBar(
          title: const Text("버튼 테스트"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20), // 버튼 간격
              RemainingCountButton(onRefresh: _refreshPage), // 새로고침 함수 전달
            ],
          ),
        ),
      ),
    );
  }
}

// 남은수량 버튼
class RemainingCountButton extends StatelessWidget {
  final VoidCallback onRefresh; // 페이지 새로고침 함수

  const RemainingCountButton({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRefresh,
      child: Container(
        width: 284,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF3AA34B),
          borderRadius: BorderRadius.circular(50.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: Text(
                " 남은수량  5개", // 임의의 수량 표시
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InkWell(
              onTap: onRefresh, // 새로고침 기능
              child: SvgPicture.asset(
                'assets/reload.svg', // 새로고침 아이콘 경로
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
