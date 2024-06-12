import 'package:almang/login/sign_log_selc.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 스플래시 화면을 표시한 후 2초 동안 대기한 다음 메인 화면으로 이동
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  FirstScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            // SVG image
            SvgPicture.asset(
              'assets/almang_logo.svg', // Replace 'image.svg' with your SVG file path
              width: 100,
              height: 100,
            ),
            SizedBox(height: 10.0),
            Text('알맹이',
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 60.0,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 10.0),
            Text('맹인을 위한 알약 정보 어플',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),),
          ],
        ),
      ) ,
    );
  }
}
