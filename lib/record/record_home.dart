import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:almang/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:record/record.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final record = AudioRecorder();
  final OnAudioQuery _onAudioQuery = OnAudioQuery();
  final TextEditingController _controller = TextEditingController();

  Timer? _timer;
  int _time = 0;
  bool _isRecording = true;
  String? _audioPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  requestPermission() async {
    if(!kIsWeb) {
      bool permissionStatus = await _onAudioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _onAudioQuery.permissionsRequest();
      }
      setState(() {

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          title: Text('처방 내용 녹음',
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
            SizedBox(height: 15),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: screenWidth-30,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.thirdColor, // Round shape edges
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all( // Border
                      color: AppColors.secondaryColor, // Border color
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '편집',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25, // Font size
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    
                  ),
                ),
              ),
            ),
            SizedBox(height: 70),
            Column(
              children: [
                Center(
                  child: Text(
                    '약사와 의사의 처방 내용을\n녹음으로 기록할 수 있습니다.',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Text(
                    '[처방 내용 녹음]에서\n 녹음 내용을 확인 할 수 있습니다.',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Text(
                    '현재는 녹음된 기록이 없습니다.',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 110),
                Container(
                  width: screenWidth,
                  height: 180,
                  color: AppColors.record,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.circle, // Select the circle icon you want.
                          size: 80, // Adjust the size of the icon.
                          color: Colors.red, // Select the color for the icon.
                        ),
                        Container(
                          width: 90, // Adjust the size of the outer circle to add a border.
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // Set the border color to white.
                              width: 7, // Adjust the width of the border.
                            ),
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