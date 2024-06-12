import 'package:almang/safety/detail_safety.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:almang/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:almang/service.dart'; // Import the server class for API calls

class SafetyScreen extends StatefulWidget {
  const SafetyScreen({super.key});

  @override
  State<SafetyScreen> createState() => _SafetyScreenState();
}

class _SafetyScreenState extends State<SafetyScreen> {
  late File _image;

  String filePath = '/Users/songjiwon/Documents/almang/assets/bu.jpeg'; // Replace with the actual file path
  late File _test = File(filePath);

  bool _isLoading = false;

  Future<void> _uploadImageAndNavigate(BuildContext context, File imageFile) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Send the image file in the POST request
      Map<String, dynamic>? result = await server.postHousehold(imageFile);

      // Print the server response
      print('Server response: $result');

      if (result != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MedicineDetailsScreen(details: result),
        ));
      } else {
        // Handle error here
        print('안전상비의약품 정보 찾기 실패');

        // Show error message and image again
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('오류'),
              content: Text(
                  '안전상비의약품 정보를 불러오는 것에 실패했습니다.\n 사진을 다시 촬영해주세요.',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              actions: [
                TextButton(
                  child: Text('닫기'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          title: const Text(
            '안정상비의약품 정보 검색',
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Semantics(
                        label: '뒤로가기',
                        child: Container(
                          width: screenWidth/2,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.thirdColor,
                            border: Border.all(
                              color: AppColors.secondaryColor,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/back_icon.svg',
                                width: 35,
                                height: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => homeScreen()),
                        );
                      },
                      child: Semantics(
                        label: '홈으로 가기',
                        child: Container(
                          width: screenWidth/2,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.thirdColor,
                            border: Border.all(
                              color: AppColors.secondaryColor,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/home_icon.svg',
                                width: 35,
                                height: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '아래 버튼을 누르시면\n 사진 촬영이 시작됩니다.',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '휴대폰과 상비약을 한 뼘\n간격으로 두고 찍어주세요.',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight/50),
                GestureDetector(
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      setState(() {
                        _image = File(pickedImage.path);
                        print(pickedImage.path);
                      });
                      _uploadImageAndNavigate(context, _image);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: screenWidth*0.8,
                      height: screenWidth*0.8,
                      decoration: BoxDecoration(
                        color: AppColors.thirdColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppColors.secondaryColor,
                          width: 4,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/camera_icon.svg',
                            width: screenWidth*0.3,
                            height: screenWidth*0.3,
                          ),
                          SizedBox(height: 30),
                          Text(
                            '사진 촬영',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 55,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
