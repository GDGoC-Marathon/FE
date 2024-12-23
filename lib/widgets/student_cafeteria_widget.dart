import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '학생식단',
      theme: ThemeData(
      ),
      home: const MyStudentCafeteriaWidget(),
    );
  }
}

class MyStudentCafeteriaWidget extends StatefulWidget {
  const MyStudentCafeteriaWidget({super.key});

  @override
  _MyStudentCafeteriaWidgetState createState() => _MyStudentCafeteriaWidgetState();
}

class _MyStudentCafeteriaWidgetState extends State<MyStudentCafeteriaWidget> {
  Map<String, List<Map<String, String>>> menuData = {};
  bool isLoading = true;

  // HTML 파싱 함수
  Future<void> fetchMenuData() async {
    try {
      final response = await http.get(Uri.parse
        ('https://43.200.167.66:8080/student-lunch-menu'));

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        // 날짜별 데이터를 저장할 맵
        Map<String, List<Map<String, String>>> parsedMenu = {};

        // 날짜와 테이블 데이터를 추출
        var dayTitles = document.querySelectorAll('h2'); // 날짜 정보
        var tables = document.querySelectorAll('h2 + h3 + table'); // 각 날짜의 메뉴 테이블

        // 날짜와 메뉴를 매칭하여 파싱
        int tableIndex = 0;
        for (int i = 0; i < dayTitles.length; i++) {
          String date = dayTitles[i].text.trim();

          // "주간 메뉴" 등의 텍스트를 건너뛰기
          if (date.contains('주간 메뉴')) {
            continue; // 해당 텍스트를 무시하고 다음으로 넘어감
          }

          List<Map<String, String>> dailyMenu = [];

          if (tableIndex < tables.length) {
            var rows = tables[tableIndex].querySelectorAll('tbody tr');

            for (var row in rows) {
              var cells = row.querySelectorAll('td');
              if (cells.length == 3) {
                String category = cells[0].text.trim();
                String menu = cells[1].text.trim().replaceAll(RegExp(r'<br\s*/?>'), ' * ');
                String price = cells[2].text.trim().isEmpty ? '-' : cells[2].text.trim();

                dailyMenu.add({
                  'category': category,
                  'menu': menu,
                  'price': price,
                });
              }
            }
            tableIndex++; // 테이블 인덱스 증가
          }

          // 날짜별로 메뉴 추가 (테이블이 없는 경우 빈 데이터 추가)
          parsedMenu[date] = dailyMenu;
        }

        setState(() {
          menuData = parsedMenu;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load menu');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMenuData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: menuData.length,
        itemBuilder: (context, index) {
          // 날짜와 해당 날짜의 메뉴 가져오기
          String date = menuData.keys.elementAt(index);
          List<Map<String, String>> menus = menuData[date]!;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFFDADADA), width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                ...menus.map((menuItem) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text.rich(
                      TextSpan(
                        text: '${menuItem['category']} (${menuItem['price']}원)', // 카테고리와 가격 bold 처리
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: '\n${menuItem['menu']}', // 메뉴는 기본 스타일
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
