import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          child: LuncheonCountButton(),
        ),
      ),
    );
  }
}

class LuncheonCountButton extends StatefulWidget {
  const LuncheonCountButton({super.key});

  @override
  _LuncheonCountButtonState createState() => _LuncheonCountButtonState();
}

class _LuncheonCountButtonState extends State<LuncheonCountButton> {
  int n = 0;
  bool isEditing = false; // 입력 모드 상태 변수
  final TextEditingController _controller = TextEditingController();

  void _increment() {
    setState(() {
      n++;
    });
  }

  void _decrement() {
    setState(() {
      if (n > 0) n--;
    });
  }

  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      _controller.text = n.toString(); // TextField에 현재 값을 설정
    });
  }

  void _updateValue(String value) {
    setState(() {
      n = int.tryParse(value) ?? n;
      isEditing = false; // 입력 종료
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
            padding: EdgeInsets.only(left: 10), // '도시락 수량' 텍스트 오른쪽 간격 추가
            child: Text(
              "도시락 수량",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: _decrement,
            child: SvgPicture.asset(
              "assets/minus_button.svg",
              width: 24,
              height: 24,
            ),
          ),
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
          GestureDetector(
            onTap: _increment,
            child: SvgPicture.asset(
              "assets/plus_button.svg",
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}