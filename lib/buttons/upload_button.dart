import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // File을 사용하기 위해 필요

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("사진 업로드 및 확대/축소"),
        ),
        body: const Center(
          child: UploadButton(),
        ),
      ),
    );
  }
}

class UploadButton extends StatefulWidget {
  const UploadButton({super.key});

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  // 선택된 이미지 파일을 저장할 변수
  File? _image;

  // 이미지 선택 메소드
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 회색 배경이 있는 컨테이너
        Positioned(
          top: 0, // 화면 상단에 배치
          child: Align(
            alignment: Alignment.topCenter, // 세로 중앙 정렬
            child: Container(
              height: 240, // 고정된 높이
              width: 320, // 고정된 너비
              decoration: BoxDecoration(
                color: Colors.grey[200], // 회색 배경색
                borderRadius: BorderRadius.circular(20), // 둥근 모서리
              ),
              // 이미지가 선택되면 확대/축소 기능 제공
              child: _image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(20), // 이미지의 모서리를 둥글게
                child: InteractiveViewer(
                  maxScale: 5.0, // 최대 확대 비율
                  minScale: 1.0, // 최소 축소 비율
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover, // 이미지가 컨테이너를 채우도록
                  ),
                ),
              )
                  : const Center(
                child: Text(
                  "사진을 업로드해주세요",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        // 업로드 버튼
        Positioned(
          top: 240 + 30, // 컨테이너 아래로 30만큼 떨어진 위치
          left: 40,
          right: 40,
          child: GestureDetector(
            onTap: _pickImage, // 버튼을 누르면 이미지 선택
            child: Container(
              width: 284, // 버튼의 너비
              height: 56, // 버튼의 높이
              decoration: BoxDecoration(
                color: const Color(0xFF3AA34B), // 버튼 색상
                borderRadius: BorderRadius.circular(50.0), // 둥근 모서리
              ),
              alignment: Alignment.center, // 텍스트를 중앙 정렬
              child: const Text(
                "사진 업로드",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
