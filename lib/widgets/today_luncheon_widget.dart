import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:gdgoc/buttons/remaining_count_button.dart';

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
      home: MyTodayLunchWidget(),
    );
  }
}

class MyTodayLunchWidget extends StatefulWidget {
  const MyTodayLunchWidget({super.key});

  @override
  State<MyTodayLunchWidget> createState() => _MyTodayLunchWidgetState();
}
class _MyTodayLunchWidgetState extends State<MyTodayLunchWidget> {
  final String formattedDate = DateFormat('MM월 dd일 EEEE', 'ko').format(DateTime.now());

  // 페이지를 새로고침하는 함수
  void _refreshPage() {
    setState(() {
      // 페이지 상태를 업데이트 후 새로고침
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: FutureBuilder(
        future: initializeDateFormatting('ko', null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Positioned(
                  top: 0+10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 30+10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "오늘의 점심 도시락",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ),
                ),
                // 회색 모서리가 둥근 직사각형 추가
                Align(
                  alignment: Alignment.topCenter, // 상단 중앙 정렬
                  child: Container(
                    margin: const EdgeInsets.only(top: 90), // 상단에서 90만큼 떨어지게 설정
                    height: 240,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // 회색 배경색
                      borderRadius: BorderRadius.circular(20), // 둥근 모서리
                    ),
                  ),
                ),
                Positioned(
                  top: 360,
                  left: 40,
                  right: 40,
                  child: MyRemainingCountButton(onRefresh: _refreshPage),
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
