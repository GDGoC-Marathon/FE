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
          child: StudentCafeteriaButton(),
        ),
      ),
    );
  }
}

class StudentCafeteriaButton extends StatefulWidget {
  @override
  _StudentCafeteriaButtonState createState() => _StudentCafeteriaButtonState();
}

class _StudentCafeteriaButtonState extends State<StudentCafeteriaButton> {
  bool isOn = false; // 버튼의 상태 (on/off)

  void toggleButton() {
    setState(() {
      isOn = !isOn; // 상태를 토글 (on <-> off)
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleButton, // 버튼을 클릭했을 때 상태 변경
      child: Container(
        width: 100, // 버튼의 너비
        height: 50, // 버튼의 높이
        decoration: BoxDecoration(
          color: isOn ? Color(0xFF3AA34B) : Color(0xFFFFFFFF), // 버튼 색상 (on일 때는 초록색, off일 때는 흰색)
          borderRadius: BorderRadius.circular(50.0), // 둥근 모서리
          border: isOn ? null : Border.all( // off 상태일 때 테두리 추가
            color: Color(0xFFE6E6E6),
            width: 2.0,
          ),
        ),
        alignment: Alignment.center, // 텍스트를 중앙 정렬
        child: Text(
          "학생식당",
          style: TextStyle(
            color: isOn ? Colors.white : Color(0xFF848484), // on일 때는 흰색 텍스트, off일 때는 회색 텍스트
            fontSize: 16.0,
            fontWeight: isOn ? FontWeight.bold : FontWeight.normal, // on일 때는 굵은 글씨, off일 때는 일반 글씨
          ),
        ),
      ),
    );
  }
}
