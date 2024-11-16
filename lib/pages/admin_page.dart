import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:gdgoc/widgets/admin_widget.dart'; // 추가

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAdminPage(),
    );
  }
}

class MyAdminPage extends StatefulWidget {
  const MyAdminPage({super.key});

  @override
  State<MyAdminPage> createState() => _MyAdminPageState();
}

class _MyAdminPageState extends State<MyAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3AA34B),
      body: FutureBuilder(
        future: initializeDateFormatting('ko', null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack( // Stack을 사용하여 레이아웃 구성
              children: [
                // 상단 로고
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/점심의 재발견_white.svg',
                    height: 36,
                  ),
                ),
                // 둥근 모서리 흰색 배경
                Positioned(
                  top: 130,  // 로고 아래 위치
                  left: 0,
                  right: 0,
                  bottom: 0,  // bottom을 0으로 설정하여 화면 크기에 맞게 확장
                  child: Container(
                    height: 720,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20), // MyAdminWidget 위쪽 여백 추가
                      child: MyAdminWidget(),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
