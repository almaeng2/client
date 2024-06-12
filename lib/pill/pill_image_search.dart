import 'package:almang/pill/detail_pill.dart';
import 'package:almang/service.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:almang/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PillImageSearchScreen extends StatefulWidget {
  const PillImageSearchScreen({super.key});

  @override
  State<PillImageSearchScreen> createState() => _PillImageSearchScreenState();
}

class _PillImageSearchScreenState extends State<PillImageSearchScreen> {
  File? _firstImage;
  File? _secondImage;
  bool _isLoading = false;

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
          title: Text(
            '처방약 이미지 검색',
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


                SizedBox(height: 30),
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
                    '휴대폰과 처방약을 한 뼘\n간격으로 두고 찍어주세요.',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    await _pickImage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenWidth * 0.8,
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
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
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

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    if (_firstImage == null) {
      final pickedImage = await imagePicker.pickImage(
          source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          _firstImage = File(pickedImage.path);
        });
        _showImagePopup(
            context, _firstImage!, '첫 번째 사진이 촬영되었습니다. 두 번째 사진을 촬영하세요.');
      }
    } else if (_secondImage == null) {
      final pickedImage = await imagePicker.pickImage(
          source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          _secondImage = File(pickedImage.path);
        });
        _showImagePopup(
            context, _secondImage!, '두 번째 사진이 촬영되었습니다. 이제 이미지를 업로드합니다.');
        _uploadImages();
      }
    }
  }

  void _showImagePopup(BuildContext context, File image, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('처방약 사진 촬영')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Center(child: Text('닫기')),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadImages() async {
    if (_firstImage != null && _secondImage != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Send the image file in the POST request
        Map<String, dynamic>? result = await server.postPill(
            _firstImage, _secondImage);

        // Print the server response
        print('Server response: $result');

        if (result != null) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PillDetailsScreen(details: result),
          ));
        } else {
          // Handle error here
          print('처방약 정보 찾기 실패');

          // Show error message and image again
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('오류'),
                content: Text('처방약 정보를 불러오는 것에 실패했습니다.\n 사진을 다시 촬영해주세요.',
                    style: TextStyle(fontSize: 20)),
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

    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(message),
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
  }
}