import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStaffCafeteriaWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyStaffCafeteriaWidget extends StatefulWidget {
  const MyStaffCafeteriaWidget({super.key});

  @override
  State<MyStaffCafeteriaWidget> createState() => _MyStaffCafeteriaWidgetState();
}

class _MyStaffCafeteriaWidgetState extends State<MyStaffCafeteriaWidget> {
  List<Map<String, String>> weeklyMenu = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMenuData();
  }

  Future<void> fetchMenuData() async {
    try {
      final response = await http.get(Uri.parse
        ("http://ec2-13-124-189-187.ap-northeast-2.compute.amazonaws.com:8080/professor-lunch-menu"));

      if (response.statusCode == 200) {
        final document = htmlParser.parse(response.body);
        final daySections = document.querySelectorAll('h2');
        final List<Map<String, String>> parsedMenu = [];

        for (var section in daySections) {
          final dayTitle = section.text.trim();
          if (['월요일', '화요일', '수요일', '목요일', '금요일'].any((day) => dayTitle.contains(day))) {
            var nextElement = section.nextElementSibling;
            String? lunch = '';
            String? lunchPrice = '';
            String? special = '';
            String? specialPrice = '';

            while (nextElement != null) {
              final tagName = nextElement.localName;
              if (tagName == 'h3' && nextElement.text.contains("중식 백반")) {
                lunch = nextElement.nextElementSibling?.text.trim();
                lunchPrice = nextElement.nextElementSibling?.nextElementSibling?.text.trim().replaceAll("가격: ", "");
              } else if (tagName == 'h3' && nextElement.text.contains("중식 특식")) {
                special = nextElement.nextElementSibling?.text.trim();
                specialPrice = nextElement.nextElementSibling?.nextElementSibling?.text.trim().replaceAll("가격: ", "");
              }
              if (tagName == 'h2') break;
              nextElement = nextElement.nextElementSibling;
            }

            parsedMenu.add({
              'day': dayTitle,
              'lunch': lunch ?? '정보 없음',
              'lunchPrice': lunchPrice ?? '정보 없음',
              'special': special ?? '정보 없음',
              'specialPrice': specialPrice ?? '정보 없음',
            });
          }
        }

        setState(() {
          weeklyMenu = parsedMenu;
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load menu");
      }
    } catch (e) {
      print("Error fetching menu: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : weeklyMenu.isEmpty
          ? const Center(child: Text('메뉴 정보를 불러올 수 없습니다.'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: weeklyMenu.length,
              itemBuilder: (context, index) {
                final menu = weeklyMenu[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25), // 좌우 여백
                  child: MenuCard(menu: menu),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final Map<String, String> menu;

  const MenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
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
            menu['day']!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "중식 백반(${menu['lunchPrice']}원)",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            menu['lunch']!.replaceAll(" ", "\n"), // 공백을 줄바꿈으로 변경
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            "중식 특식(${menu['specialPrice']}원)",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            menu['special']!.replaceAll(" ", "\n"), // 공백을 줄바꿈으로 변경
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
