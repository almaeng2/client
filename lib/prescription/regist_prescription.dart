import 'package:almang/prescription/view_prescription.dart';
import 'package:almang/service.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:almang/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class registScreen extends StatefulWidget {
  const registScreen({super.key});

  @override
  State<registScreen> createState() => _registScreenState();
}

class _registScreenState extends State<registScreen> {
  late File _image;
  bool _isLoading = false;

  Future<void> _uploadImageAndNavigate(BuildContext context, File imageFile,
      String name) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Send the image file and name in the POST request
      String? result = await server.postPrescription(imageFile, name);

      // Print the server response
      print('Server response: $result');

      if (result == '처방전 등록이 완료되었습니다!') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('완료'),
              content: Text(
                  '${result}\n등록된 처방전을 확인하시겠습니까?',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              actions: [
                Row(
                  children: [
                    TextButton(
                      child: Text('확인'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              ViewPrescriptionScreen()), // Replace AnotherPage() with the page you want to navigate to
                        );
                      },
                    ),
                    SizedBox(width: 10), // Add some space between buttons
                    TextButton(
                      child: Text('취소'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      } else {
        // Handle error here
        print('처방전 등록 실패');

        // Show error message and image again
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('오류'),
              content: Text(
                '처방전 등록에 실패했습니다.\n 사진을 다시 촬영해주세요.',
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

  Future<String?> _showNameInputDialog(BuildContext context) async {
    final TextEditingController nameController = TextEditingController();

    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('처방전 이름 입력'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "처방전 이름을 입력하세요"),
          ),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return TextButton(
                  child: Text('등록'),
                  onPressed: () {
                    String name = nameController.text.trim();
                    if (name.isNotEmpty) {
                      Navigator.of(context).pop(name); // Return the name entered by the user
                    } else {
                      // Show error message if name is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('이름을 입력해주세요.')),
                      );
                    }
                  },
                );
              },
            ),
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without returning a name
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          title: Text('처방전 등록',
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
            child: Column(
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
                  child: Text('아래 버튼을 누르시면\n 사진 촬영이 시작됩니다.',
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
                  child: Text('휴대폰과 처방전을 두 뼘\n간격으로 두고 찍어주세요.',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    final pickedImage = await imagePicker.pickImage(
                        source: ImageSource.camera); // 카메라에서 사진을 촬영합니다.
                    if (pickedImage != null) {
                      setState(() {
                        _image = File(pickedImage.path);
                        print(pickedImage.path);
                      });

                      // Show the name input dialog
                      String? name = await _showNameInputDialog(context);
                      if (name != null && name.isNotEmpty) {
                        _uploadImageAndNavigate(context, _image, name);
                      } else {
                        // Show error message if name is empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('이름을 입력해주세요.')),
                        );
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        color: AppColors.thirdColor,
                        // Round shape edges
                        borderRadius: BorderRadius.circular(30),
                        // Round shape edges
                        border: Border.all( // Border
                          color: AppColors.secondaryColor, // Border color
                          width: 4,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Add SVG image
                          SvgPicture.asset(
                            'assets/camera_icon.svg',
                            // Replace 'image.svg' with your SVG file path
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                          ),
                          SizedBox(height: 30), // Spacer between image and text
                          Text(
                            '사진 촬영',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 55, // Font size
                              color: AppColors.secondaryColor, // Font color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ),if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }


}
