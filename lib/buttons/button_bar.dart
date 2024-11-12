import 'package:flutter/material.dart';

import 'package:gdgoc/buttons/student_cafeteria_button.dart';
import 'package:gdgoc/buttons/staff_cafeteria_button.dart';
import 'package:gdgoc/buttons/luncheon_button.dart';

class ButtonBarWidget extends StatelessWidget {
  const ButtonBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // 버튼 바를 가로 중앙 정렬
      children: [
        StudentCafeteriaButton(),  // 학생식당 버튼
        SizedBox(width: 16),       // 버튼 간의 간격을 16으로 설정
        StaffCafeteriaButton(),    // 교직원식당 버튼
        SizedBox(width: 16),       // 버튼 간의 간격을 16으로 설정
        LuncheonButton(),          // 점심시간 버튼
      ],
    );
  }
}

// 메인 페이지
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyStudentCafeteriaPage(),
    );
  }
}

class MyStudentCafeteriaPage extends StatelessWidget {
  const MyStudentCafeteriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("식당 버튼 바"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 버튼 바를 화면에 추가
            const ButtonBarWidget(),
          ],
        ),
      ),
    );
  }
}
