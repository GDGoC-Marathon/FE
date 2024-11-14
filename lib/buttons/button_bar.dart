import 'package:flutter/material.dart';

// 페이지들을 import 합니다.
import 'package:gdgoc/widgets/student_cafeteria_widget.dart';
import 'package:gdgoc/widgets/staff_cafeteria_widget.dart';
import 'package:gdgoc/widgets/today_luncheon_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _selectedPage = 'student';

  // 버튼 클릭 시 상태 변경
  void _onButtonClicked(String page) {
    setState(() {
      _selectedPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경색을 흰색으로 변경
      body: Column(
        children: [
          ButtonBarWidget(
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

class ButtonBarWidget extends StatelessWidget {
  final String selectedButton;
  final Function(String) onButtonClicked;

  const ButtonBarWidget({
    super.key,
    required this.selectedButton,
    required this.onButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StudentCafeteriaButton(
          isSelected: selectedButton == 'student',
          onTap: () => onButtonClicked('student'),
        ),
        const SizedBox(width: 16),
        StaffCafeteriaButton(
          isSelected: selectedButton == 'staff',
          onTap: () => onButtonClicked('staff'),
        ),
        const SizedBox(width: 16),
        LuncheonButton(
          isSelected: selectedButton == 'luncheon',
          onTap: () => onButtonClicked('luncheon'),
        ),
      ],
    );
  }
}

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
            color: isSelected ? Colors.white : const Color(0xFF848484),
            fontSize: 16.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

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
