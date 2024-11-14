import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdgoc/buttons/start_button.dart';
import 'package:gdgoc/pages/main_home_page.dart'; // student_cafeteria 페이지 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStartPage(),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60),
            SvgPicture.asset(
              'assets/점심의 재발견_green.svg',
              height: 36,
            ),
            const SizedBox(height: 50),
            Image.asset(
              'assets/Logo2.png',
              height: 180,
            ),
            const SizedBox(height: 150),
            // StartButton 위젯을 GestureDetector로 감싸서 onPressed 콜백 추가
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyMainHomePage()),
                );
              },
              child: const StartButton(),
            ),
            const SizedBox(height: 20),
            const Text(
              '관리자로 시작하기',
              style: TextStyle(
                color: Color(0xFF595959),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: 112,
              height: 0.5,
              color: const Color(0xFFCECECE),
            ),
          ],
        ),
      ),
    );
  }
}
