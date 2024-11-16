import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:gdgoc/buttons/luncheon_count_button.dart';
import 'package:gdgoc/buttons/upload_button.dart';

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
      home: MyAdminWidget(),
    );
  }
}

class MyAdminWidget extends StatefulWidget {
  const MyAdminWidget({super.key});

  @override
  State<MyAdminWidget> createState() => _MyAdminWidgetState();
}
class _MyAdminWidgetState extends State<MyAdminWidget> {
  final String formattedDate = DateFormat('MM월 dd일 EEEE', 'ko').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: initializeDateFormatting('ko', null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
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
                  top: 30,
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
                // UploadButton과 LuncheonCountButton에 크기 정의
                const Positioned(
                  left: 0,
                  right: 0,
                  top: 100,
                  child: SizedBox(
                    height: 400, // UploadButton의 높이
                    child: UploadButton(),
                  ),
                ),
                const Positioned(
                  top: 450,
                  left: 40,
                  right: 40,
                  child: SizedBox(
                    height: 56, // LuncheonCountButton의 높이
                    child: LuncheonCountButton(),
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
