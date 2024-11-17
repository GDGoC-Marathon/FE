import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 실행 함수
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("도시락 수량 카운트 버튼"),
        ),
        body: const Center(
          child: MyLuncheonCountButton(),
        ),
      ),
    );
  }
}

// 도시락 수량을 나타내는 버튼
class MyLuncheonCountButton extends StatefulWidget {
  const MyLuncheonCountButton({super.key});

  @override
  _MyLuncheonCountButtonState createState() => _MyLuncheonCountButtonState();
}

class _MyLuncheonCountButtonState extends State<MyLuncheonCountButton> {
  int n = 0; // 도시락 수량 변수
  bool isEditing = false; // 현재 입력 모드를 나타내는 상태 변수
  final TextEditingController _controller = TextEditingController();

  // 애니메이션 관련 변수
  double _scaleMinus = 1.0; // 마이너스 버튼 크기 상태
  double _scalePlus = 1.0; // 플러스 버튼 크기 상태

  // 마이너스 버튼 애니메이션
  void _animateMinusButton() {
    setState(() {
      _scaleMinus = 0.8; // 버튼 축소
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _scaleMinus = 1.0; // 원래 크기로 복원
      });
    });
  }

  // 플러스 버튼 애니메이션
  void _animatePlusButton() {
    setState(() {
      _scalePlus = 0.8; // 버튼 축소
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _scalePlus = 1.0; // 원래 크기로 복원
      });
    });
  }

  // 수량 감소 함수
  void _decrement() {
    if (n > 0) {
      _animateMinusButton(); // 마이너스 버튼 애니메이션 실행
      setState(() {
        n--;
      });
    }
  }

  // 수량 증가 함수
  void _increment() {
    _animatePlusButton(); // 플러스 버튼 애니메이션 실행
    setState(() {
      n++;
    });
  }

  // 입력 모드 전환
  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      _controller.text = n.toString();
    });
  }

  // 입력값 반영
  void _updateValue(String value) {
    setState(() {
      n = int.tryParse(value) ?? n;
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 284,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF3AA34B),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "도시락 수량",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 마이너스 버튼
          GestureDetector(
            onTap: _decrement,
            child: AnimatedScale(
              scale: _scaleMinus,
              duration: const Duration(milliseconds: 100),
              child: SvgPicture.asset(
                "assets/minus_button.svg",
                width: 24,
                height: 24,
              ),
            ),
          ),

          // 도시락 수량 n을 나타내는 필드
          GestureDetector(
            onTap: _toggleEditing,
            child: isEditing
                ? SizedBox(
              width: 40,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                onSubmitted: _updateValue,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            )
                : Text(
              '$n',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 플러스 버튼
          GestureDetector(
            onTap: _increment,
            child: AnimatedScale(
              scale: _scalePlus,
              duration: const Duration(milliseconds: 100),
              child: SvgPicture.asset(
                "assets/plus_button.svg",
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
