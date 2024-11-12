import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("버튼 테스트"),
        ),
        body: Center(
            child: StartButton(),
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 284, // 버튼의 너비
        height: 56, // 버튼의 높이
        decoration: BoxDecoration(
          color: Color(0xFF3AA34B), // 버튼 색상
          borderRadius: BorderRadius.circular(50.0), // 둥근 모서리
        ),
        alignment: Alignment.center, // 텍스트를 중앙 정렬
        child: Text(
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
