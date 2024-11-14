import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("버튼 테스트"),
        ),
        body: const Center(
            child: StartButton(),
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 284, // 버튼의 너비
        height: 56, // 버튼의 높이
        decoration: BoxDecoration(
          color: const Color(0xFF3AA34B), // 버튼 색상
          borderRadius: BorderRadius.circular(50.0), // 둥근 모서리
        ),
        alignment: Alignment.center, // 텍스트를 중앙 정렬
        child: const Text(
          "시작하기",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
