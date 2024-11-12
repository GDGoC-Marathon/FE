import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG 이미지 사용을 위한 import
import 'package:gdgoc/buttons/start_button.dart'; // StartButton 위젯 경로

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyStartPage(),
    );
  }
}

class MyStartPage extends StatefulWidget {
  const MyStartPage({super.key});

  @override
  State<MyStartPage> createState() => _MyStartPageState();
}

class _MyStartPageState extends State<MyStartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
          children: <Widget>[
            const SizedBox(height: 60),

            SvgPicture.asset(
              'assets/점심의 재발견_green.svg',
              height: 36,
            ),
            const SizedBox(height: 50), // 첫 번째와 두 번째 이미지 사이 간격
            // 두 번째 PNG 이미지
            Image.asset(
              'assets/Logo2.png', // PNG 파일 경로
              height: 180,
            ),
            const SizedBox(height: 150),
            // StartButton 위젯
            StartButton(),
            const SizedBox(height: 20), // StartButton과 텍스트 사이 간격
            // "관리자로 시작하기" 텍스트
            Text(
              '관리자로 시작하기',
              style: TextStyle(
                color: Color(0xFF595959), // 텍스트 색상
                fontSize: 14, // 글자 크기
              ),
            ),
            const SizedBox(height: 2), // 텍스트와 직사각형 사이 간격
            // 길이 95, 높이 0.5인 직사각형 선
            Container(
              width: 112,
              height: 0.5,
              color: Color(0xFFCECECE), // 선 색상
            ),
          ],
        ),
      ),
    );
  }
}
