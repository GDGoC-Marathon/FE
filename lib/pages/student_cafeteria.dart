import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:gdgoc/buttons/button_bar.dart';  // 버튼 바를 임포트

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStudentCafeteriaPage(),
    );
  }
}

class MyStudentCafeteriaPage extends StatefulWidget {
  const MyStudentCafeteriaPage({super.key});

  @override
  State<MyStudentCafeteriaPage> createState() => _MyStudentCafeteriaPageState();
}

class _MyStudentCafeteriaPageState extends State<MyStudentCafeteriaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 배경색을 3AA34B로 설정
      backgroundColor: const Color(0xFF3AA34B),
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/점심의 재발견_white.svg',
              height: 36,
            ),
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Container(
              height: 720, // 하얀 직사각형의 높이
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), // 상단 좌측 모서리 둥글게
                  topRight: Radius.circular(40), // 상단 우측 모서리 둥글게
                ),
              ),
            ),
          ),
          const Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: ButtonBarWidget(), // 버튼 바 위젯
          ),
          Positioned(
            top: 300,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 360, // 하얀 직사각형의 높이
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30), // 모든 모서리를 둥글게
                border: Border.all(
                  color: const Color(0xFFDADADA), // 테두리 색상
                  width: 3, // 테두리 두께
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(4, 4), // 그림자의 위치 (아래로 4, 오른쪽으로 4)
                    blurRadius: 4, // 그림자 블러 효과
                  ),
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 여기에 내용 추가 (예: 텍스트나 버튼 등)
                  Text(
                    '내용',
                    style: TextStyle  (
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 버튼 바 추가 (위에서 500 위치에 배치)
        ],
      ),
    );
  }
}
