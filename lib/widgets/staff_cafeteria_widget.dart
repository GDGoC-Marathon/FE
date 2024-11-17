import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:gdgoc/buttons/date_bar.dart';

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
      home: MyStaffCafeteriaWidget(),
    );
  }
}

class MyStaffCafeteriaWidget extends StatefulWidget {
  const MyStaffCafeteriaWidget({super.key});

  @override
  State<MyStaffCafeteriaWidget> createState() => _MyStaffCafeteriaWidgetState();
}

class _MyStaffCafeteriaWidgetState extends State<MyStaffCafeteriaWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: FutureBuilder(
        future: initializeDateFormatting('ko', null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: MyDateBar(),
                ),
                Positioned(
                  top: 70,
                  left: 20,
                  right: 20,
                  child: MenuCard(
                    categories: [
                      {'name': '뚝배기', 'price': '5000원', 'menu': 'ㄹㄹㄹㄹ'},
                      {'name': '명가', 'price': '6700원', 'menu': 'ㄴㄴㄴㄴㄴ'},
                      {'name': 'Noodle', 'price': '5000원', 'menu': 'ㄷㄷㄷㄷㄷ'},
                      {'name': 'Self Bar', 'price': '8000원', 'menu': '샐러드 바'},
                    ],
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

// 각 메뉴 정보를 표시하는 카드
class MenuCard extends StatelessWidget {
  final List<Map<String, String>> categories;

  const MenuCard({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      height: 360,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFDADADA),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(4, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${category['name']} (${category['price']})',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category['menu'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
