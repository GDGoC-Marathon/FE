import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: const Text("시작하기 버튼"),
        ),
        body: const Center(
            child: StartButton(),
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 284,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF3AA34B),
          borderRadius: BorderRadius.circular(50.0),
        ),
        alignment: Alignment.center,
        child: const Text(
          "시작하기",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
