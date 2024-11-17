import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// 실행 함수
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko'); // 한국어 로케일 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("날짜 선택 바")),
        body: const Center(
          child: MyDateBar(),
        ),
      ),
    );
  }
}

class MyDateBar extends StatefulWidget {
  const MyDateBar({super.key});

  @override
  State<MyDateBar> createState() => _MyDateBarState();
}

class _MyDateBarState extends State<MyDateBar> {
  DateTime _selectedDate = DateTime.now();

  // 날짜를 다음 날이나 이전 날로 변경하는 함수
  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    // 날짜 형식을 'xx월 xx일 x요일' 형태로 지정
    String formattedDate = DateFormat('MM월 dd일 EEEE', 'ko').format(_selectedDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: SvgPicture.asset('assets/Expand_left.svg'),
          onPressed: () => _changeDate(-1), // 이전 날짜로 이동
        ),
        const SizedBox(width: 30), // 간격을 더 넓게 설정
        Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Color(0xFF595959), // 글씨 색상 설정
          ),
        ),
        const SizedBox(width: 30), // 간격을 더 넓게 설정
        IconButton(
          icon: SvgPicture.asset('assets/Expand_right.svg'),
          onPressed: () => _changeDate(1), // 다음 날짜로 이동
        ),
      ],
    );
  }
}
