import 'package:almang/service.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:almang/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class messagePage extends StatefulWidget{
  const messagePage({super.key});

  @override
  State<messagePage> createState() => _messageScreenState();
}

class _messageScreenState extends State<messagePage>{
  late File _image;
  bool _isLoading = false;


  Future<void> _uploadImageAndNavigate(BuildContext context, File imageFile) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Send the image file in the POST request
      String? result = await server.postTOD(imageFile);

      // Print the server response
      print('Server response: $result');

      if (result != null) {
        //String message = result['msg'] ?? 'No message provided';

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('복용 시간 인식 결과'),
              content: Text('해당 복용약은 [ $result약 ] 입니다.',
              style: TextStyle(fontSize: 20)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('오류'),
              content: Text('복용 시간 인식에 실패하였습니다.\n 다시 사진을 다시 촬영해주세요',style: TextStyle(fontSize: 18)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('닫기'),
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
    final data = ModalRoute.of(context)!.settings.arguments;
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          title: Text('복용 시간 인식',
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
                  padding: const EdgeInsets.all(10.0),
                  child: Text('휴대폰과 복용약을 한 뼘\n간격으로 두고 찍어주세요.',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenWidth*0.1),
                GestureDetector(
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera); // 카메라에서 사진을 촬영합니다.
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
                        color: AppColors.thirdColor, // Round shape edges
                        borderRadius: BorderRadius.circular(30), // Round shape edges
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
                            'assets/camera_icon.svg', // Replace 'image.svg' with your SVG file path
                            width: screenWidth*0.3,
                            height: screenWidth*0.3,
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