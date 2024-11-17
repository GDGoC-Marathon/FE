import 'package:flutter/material.dart';

import 'package:gdgoc/widgets/student_cafeteria_widget.dart';
import 'package:gdgoc/widgets/staff_cafeteria_widget.dart';
import 'package:gdgoc/widgets/today_luncheon_widget.dart';

// 실행 함수
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("학식/교식/도시락 바")),
        body: const Center(
          child: MainScreen(),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _selectedPage = 'student'; // 초기 상태는 'student'

  // 버튼 클릭 시 위젯 변경
  void _onButtonClicked(String page) {
    setState(() {
      _selectedPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          MyButtonBar(
            selectedButton: _selectedPage,
            onButtonClicked: _onButtonClicked,
          ),
          Expanded(
            child: _getSelectedPage(),
          ),
        ],
      ),
    );
  }

  // 선택된 버튼에 맞게 위젯 반환(학식, 교식, 도시락)
  Widget _getSelectedPage() {
    switch (_selectedPage) {
      case 'student':
        return const MyStudentCafeteriaWidget();
      case 'staff':
        return const MyStaffCafeteriaWidget();
      case 'luncheon':
        return const MyTodayLunchWidget();
      default:
        return const MyStudentCafeteriaWidget(); // 디폴트 값은 학생식당
    }
  }
}

class MyButtonBar extends StatelessWidget {
  final String selectedButton; // 선택된 버튼의 ID 문자열
  final Function(String) onButtonClicked; // 버튼 클릭 콜백 함수()

  const MyButtonBar({
    super.key,
    required this.selectedButton,
    required this.onButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 학생식당 버튼
        StudentCafeteriaButton(
          isSelected: selectedButton == 'student',
          onTap: () => onButtonClicked('student'),
        ),
        const SizedBox(width: 16),
        // 교직원식당 버튼
        StaffCafeteriaButton(
          isSelected: selectedButton == 'staff',
          onTap: () => onButtonClicked('staff'),
        ),
        const SizedBox(width: 16),
        // 도시락 버튼
        LuncheonButton(
          isSelected: selectedButton == 'luncheon',
          onTap: () => onButtonClicked('luncheon'),
        ),
      ],
    );
  }
}

// 학생식당 버튼 상태변화
class StudentCafeteriaButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const StudentCafeteriaButton({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          // 버튼 클릭시 흰색 -> 초록색 상태 변화
          color: isSelected ? const Color(0xFF3AA34B) : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(50.0),
          border: isSelected
              ? null
              : Border.all(
            color: const Color(0xFFE6E6E6),
            width: 2.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          "학생식당",
          style: TextStyle(
            // 버튼 클릭시 글씨 두께 normal 상태 변화
            color: isSelected ? Colors.white : const Color(0xFF848484),
            fontSize: 16.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// 교직원식당 버튼 상태변화
class StaffCafeteriaButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const StaffCafeteriaButton({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3AA34B) : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(50.0),
          border: isSelected
              ? null
              : Border.all(
            color: const Color(0xFFE6E6E6),
            width: 2.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          "교직원식당",
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF848484),
            fontSize: 16.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// 도시락 버튼 상태변화
class LuncheonButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const LuncheonButton({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3AA34B) : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(50.0),
          border: isSelected
              ? null
              : Border.all(
            color: const Color(0xFFE6E6E6),
            width: 2.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          "도시락",
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF848484),
            fontSize: 16.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
