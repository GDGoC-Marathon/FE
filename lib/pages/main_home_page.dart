import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gdgoc/buttons/button_bar.dart';
import 'package:gdgoc/widgets/student_cafeteria_widget.dart'; // 추가
import 'package:gdgoc/widgets/staff_cafeteria_widget.dart'; // 추가
import 'package:gdgoc/widgets/today_luncheon_widget.dart'; // 추가

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
      home: MyMainHomePage(),
    );
  }
}

class MyMainHomePage extends StatefulWidget {
  const MyMainHomePage({super.key});

  @override
  State<MyMainHomePage> createState() => _MyMainHomePageState();
}

class _MyMainHomePageState extends State<MyMainHomePage> {
  String _selectedPage = 'student'; // 현재 선택된 페이지를 관리합니다.

  // 버튼 클릭 시 상태 변경
  void _onButtonClicked(String page) {
    setState(() {
      _selectedPage = page; // 페이지 변경
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3AA34B),
      body: FutureBuilder(
        future: initializeDateFormatting('ko', null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack( // Stack을 다시 사용하여 레이아웃 구성
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
                  top: 130,  // Adjusted to ensure it appears below the logo
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 720,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                // 버튼 영역
                Positioned(
                  top: 170, // Adjusted to position below the logo
                  left: 0,
                  right: 0,
                  child: ButtonBarWidget(
                    selectedButton: _selectedPage,
                    onButtonClicked: _onButtonClicked,
                  ),
                ),
                // 선택된 페이지 콘텐츠 표시
                Positioned(
                  top: 230, // Adjusted to position below the ButtonBarWidget
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _getSelectedPage(),
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

  // 현재 선택된 페이지에 맞는 위젯을 반환합니다.
  Widget _getSelectedPage() {
    switch (_selectedPage) {
      case 'student':
        return const MyStudentCafeteriaWidget();
      case 'staff':
        return const MyStaffCafeteriaWidget();
      case 'luncheon':
        return const MyTodayLunchWidget();
      default:
        return const MyStudentCafeteriaWidget();
    }
  }
}
