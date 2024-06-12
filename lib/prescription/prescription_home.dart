import 'package:almang/pill/pill_image_search.dart';
import 'package:almang/prescription/regist_prescription.dart';
import 'package:almang/prescription/view_prescription.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:almang/home.dart';
import 'package:flutter_svg/flutter_svg.dart';



class prescriptionScreen extends StatelessWidget{
  const prescriptionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          title: Text('처방전 등록/검색',
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
        body: Column(
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => registScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: screenWidth*0.85,
                  height: screenheight*0.2,
                  decoration: BoxDecoration(
                    color: AppColors.thirdColor, // Round shape edges
                    borderRadius: BorderRadius.circular(20), // Round shape edges
                    border: Border.all( // Border
                      color: AppColors.secondaryColor, // Border color
                      width: 5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add SVG image
                      SvgPicture.asset(
                        'assets/camera_icon.svg', // Replace 'image.svg' with your SVG file path
                        width: screenWidth*0.19,
                        height: screenWidth*0.19,
                      ),
                      SizedBox(height: screenheight/100), // Spacer between image and text
                      Text(
                        '처방전 등록',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30, // Font size
                          color: AppColors.secondaryColor, // Font color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewPrescriptionScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: screenWidth*0.85,
                  height: screenheight*0.2,
                  decoration: BoxDecoration(
                    color: AppColors.thirdColor, // Round shape edges
                    borderRadius: BorderRadius.circular(20), // Round shape edges
                    border: Border.all( // Border
                      color: AppColors.secondaryColor, // Border color
                      width: 5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add SVG image
                      SvgPicture.asset(
                        'assets/prescription_icon.svg', // Replace 'image.svg' with your SVG file path
                        width: screenWidth*0.19,
                        height: screenWidth*0.19,
                      ),
                      SizedBox(height: screenheight/100), // Spacer between image and text
                      Text(
                        '처방전 열람',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30, // Font size
                          color: AppColors.secondaryColor, // Font color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PillImageSearchScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: screenWidth*0.85,
                  height: screenheight*0.2,
                  decoration: BoxDecoration(
                    color: AppColors.thirdColor, // Round shape edges
                    borderRadius: BorderRadius.circular(20), // Round shape edges
                    border: Border.all( // Border
                      color: AppColors.secondaryColor, // Border color
                      width: 5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add SVG image
                      SvgPicture.asset(
                        'assets/pill_icon.svg', // Replace 'image.svg' with your SVG file path
                        width: screenWidth*0.18,
                        height: screenWidth*0.18,
                      ),
                      SizedBox(height: screenheight/100), // Spacer between image and text
                      Text(
                        '처방약 이미지 검색',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30, // Font size
                          color: AppColors.secondaryColor, // Font color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //SizedBox(height: 20), // Spacer between image and text
          ],
        ),
      ),
    );
  }
}