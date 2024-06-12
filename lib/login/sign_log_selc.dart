import 'package:almang/login/login.dart';
import 'package:almang/login/signup.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstScreen extends StatelessWidget{
  FirstScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
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
                  fontSize: 30, // Adjust font size based on screen width
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 1.0),
              const Text(
                '맹인을 위한 알약 정보 어플',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25, // Adjust font size based on screen width
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 60.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenWidth * 0.8 * 0.625,
                  decoration: BoxDecoration(
                    color: AppColors.thirdColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.secondaryColor,
                      width: 6,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/signup.svg',
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                      ),
                      SizedBox(height: 25),
                      Text(
                        '회원가입',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.07,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenWidth * 0.8 * 0.625,
                  decoration: BoxDecoration(
                    color: AppColors.thirdColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.secondaryColor,
                      width: 6,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/login.svg',
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                      ),
                      SizedBox(height: 25),
                      Text(
                        '로그인',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.07,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






