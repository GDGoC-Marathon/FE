import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 실행 함수
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("남은 도시락 수량 버튼"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyRemainingCountButton(onRefresh: _refreshPage), // 새로고침 함수 전달
            ],
          ),
        ),
      ),
    );
  }
}

// 남은 도시락 수량 버튼
class MyRemainingCountButton extends StatefulWidget {
  final VoidCallback onRefresh; // 페이지 새로고침 함수

  const MyRemainingCountButton({super.key, required this.onRefresh});

  @override
  _MyRemainingCountButtonState createState() => _MyRemainingCountButtonState();
}

class _MyRemainingCountButtonState extends State<MyRemainingCountButton> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), // 애니메이션 지속 시간
    );

    // 축소 및 복원 애니메이션 설정
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animationController.forward().then((value) {
          // 애니메이션 후 새로고침 함수 호출
          widget.onRefresh();
          _animationController.reverse();
        });
      },
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
            // 새로고침 버튼
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: SvgPicture.asset(
                'assets/reload.svg',
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
