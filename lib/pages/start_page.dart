import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdgoc/buttons/start_button.dart';
import 'package:gdgoc/pages/main_home_page.dart';
import 'package:gdgoc/pages/admin_page.dart';

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

            // 앱 로고
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

            // "StartButton" 버튼 누르면 시작 페이지로 전환
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

            // "관리자로 시작하기" 버튼 누르면 관리자 페이지로 전환
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyAdminPage()),
                );
              },
              child: const Text(
                '관리자로 시작하기',
                style: TextStyle(
                  color: Color(0xFF595959),
                  fontSize: 14,
                ),
              ),
            ),

            // '관리로 시작하기' 밑줄 추가
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
