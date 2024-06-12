import 'package:almang/alarm/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:almang/safety/safetyprecaution_home.dart';
import 'package:almang/record/record_home.dart';
import 'package:almang/prescription/prescription_home.dart';
import 'package:almang/alarm/alarm_home.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: homeScreen(),
    );
  }
}

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/almang_logo.svg',
              width: screenWidth * 0.15, // Adjust logo width based on screen width
              height: screenWidth * 0.15,
            ),
            const SizedBox(height: 10.0),
            const Text(
              '알맹이',
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 40, // Adjust font size based on screen width
                letterSpacing: 1.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 1.0),
            const Text('맹인을 위한 알약 정보 어플',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 60.0),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SafetyScreen()),
                    );
                  },
                  child: Container(
                    width: (screenWidth - 70) / 2,
                    height: screenWidth*0.6,
                    decoration: BoxDecoration(
                      color: AppColors.thirdColor,
                      borderRadius: BorderRadius.circular(20), // Round shape edges
                      border: Border.all( // Border
                        color: AppColors.secondaryColor, // Border color
                        width: 5, // Border width
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Add SVG image
                        SvgPicture.asset(
                          'assets/sangbi_icon.svg', // Replace 'image.svg' with your SVG file path
                          width: screenWidth*0.26,
                          height: screenWidth*0.26,
                        ),
                        SizedBox(height: 30), // Spacer between image and text
                        Text(
                          '안전상비약\n정보 검색',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth/20, // Font size
                            color: AppColors.secondaryColor, // Font color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 20),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AlarmScreen(
                            alarms: NotificationInfo(
                              alarmType: '',
                              alarmRepeat: '',
                              Hour: '',
                              Minute: '',
                              Days: [],
                              alarmPeriod: '',
                              prescription: '', // 선택된 처방전 이름 추가
                              isActive: true, // Fixed typo, ture -> true
                            ),
                          )),
                        );
                      },
                      child: Container(
                        width: (screenWidth - 70) / 2,
                        height: screenWidth*0.6,
                        decoration: BoxDecoration(
                          color: AppColors.thirdColor,
                          borderRadius: BorderRadius.circular(20), // Round shape edges
                          border: Border.all( // Border
                            color: AppColors.secondaryColor, // Border color
                            width: 5, // Border width
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Add SVG image
                            SvgPicture.asset(
                              'assets/alarm_icon.svg', // Replace 'image.svg' with your SVG file path
                              width: screenWidth*0.22,
                              height: screenWidth*0.22,
                            ),
                            SizedBox(height: 30), // Spacer between image and text
                            Text(
                              '복약 알림',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth/20, // Font size
                                color: AppColors.secondaryColor, // Font color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => prescriptionScreen()),
                    );
                  },
                  child: Container(
                    width: (screenWidth - 70) / 2,
                    height: screenWidth*0.6,
                    decoration: BoxDecoration(
                      color: AppColors.thirdColor,
                      borderRadius: BorderRadius.circular(20), // Round shape edges
                      border: Border.all( // Border
                        color: AppColors.secondaryColor, // Border color
                        width: 5, // Border width
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Add SVG image
                        SvgPicture.asset(
                          'assets/prescription_search_icon.svg', // Replace 'image.svg' with your SVG file path
                          width: screenWidth*0.26,
                          height: screenWidth*0.26,
                        ),
                        SizedBox(height: 20), // Spacer between image and text
                        Text(
                          '처방전 약\n등록 / 검색',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth/20, // Font size
                            color: AppColors.secondaryColor, // Font color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecordScreen()),
                    );
                  },
                  child: Container(
                    width: (screenWidth - 70) / 2,
                    height: screenWidth*0.6,
                    decoration: BoxDecoration(
                      color: AppColors.thirdColor,
                      borderRadius: BorderRadius.circular(20), // Round shape edges
                      border: Border.all( // Border
                        color: AppColors.secondaryColor, // Border color
                        width: 5, // Border width
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Add SVG image
                        SvgPicture.asset(
                          'assets/record_icon.svg', // Replace 'image.svg' with your SVG file path
                          width: screenWidth*0.26,
                          height: screenWidth*0.26,
                        ),
                        SizedBox(height: 30), // Spacer between image and text
                        Text(
                          '처방 내용 녹음',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth/20, // Font size
                            color: AppColors.secondaryColor, // Font color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}