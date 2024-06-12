import 'package:almang/login/sign_user_info.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Center(
                        child: SvgPicture.asset(
                          'assets/almang_logo.svg', // Replace 'image.svg' with your SVG file path
                          width: 80,
                          height: 80,
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text('로그인에 사용할 아이디와\n비밀번호를 입력해주세요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('  아이디를 입력해주세요.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize:25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        width: 450,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
                            controller: _idController,
                            decoration: InputDecoration(
                              labelText: '  아이디',
                              labelStyle: TextStyle(
                                color: AppColors.secondaryColor, // 라벨의 텍스트 색상
                                fontSize: 30.0, // 라벨의 텍스트 크기
                                fontWeight: FontWeight.bold, // 라벨의 텍스트 굵기
                              ),
                              enabledBorder: OutlineInputBorder( // 활성화되지 않은 상태의 외곽선 스타일
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 5,
                                    color: AppColors.secondaryColor // 외곽선 색상 설정
                                ),

                              ),
                              focusedBorder: OutlineInputBorder( // 포커스를 받았을 때의 외곽선 스타일
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.blue), // 외곽선 색상 설정
                              ),
                              fillColor: AppColors.thirdColor, // 텍스트 필드 배경 색상
                              filled: true, // 배경 색상 채우기 여부
                              //prefixIcon: Icon(Icons.id), // 왼쪽에 아이콘 추가
                              suffixIcon: IconButton( // 오른쪽에 아이콘 버튼 추가
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _idController.clear(); // 텍스트 필드를 지웁니다.
                                },
                              ),
                            ),
                          ),
                        ),
                      ),



                      SizedBox(height: 30.0),
                      Text('  비밀번호를 입력해주세요.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize:25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        width: 450,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
                            controller: _passwordController,                    decoration: InputDecoration(
                            labelText: '  비밀번호',
                            labelStyle: TextStyle(
                              color: AppColors.secondaryColor, // 라벨의 텍스트 색상
                              fontSize: 30.0, // 라벨의 텍스트 크기
                              fontWeight: FontWeight.bold, // 라벨의 텍스트 굵기
                            ),
                            enabledBorder: OutlineInputBorder( // 활성화되지 않은 상태의 외곽선 스타일
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 5,
                                  color: AppColors.secondaryColor // 외곽선 색상 설정
                              ),

                            ),
                            focusedBorder: OutlineInputBorder( // 포커스를 받았을 때의 외곽선 스타일
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.blue), // 외곽선 색상 설정
                            ),
                            fillColor: AppColors.thirdColor, // 텍스트 필드 배경 색상
                            filled: true, // 배경 색상 채우기 여부
                            //prefixIcon: Icon(Icons.id), // 왼쪽에 아이콘 추가
                            suffixIcon: IconButton( // 오른쪽에 아이콘 버튼 추가
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _passwordController.clear(); // 텍스트 필드를 지웁니다.
                              },
                            ),
                          ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.0),
                      Text('  비밀번호를 한 번 더 입력해주세요.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize:24.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        width: 450,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
                            controller: _repasswordController,
                            decoration: InputDecoration(
                            labelText: '  비밀번호 확인',
                            labelStyle: TextStyle(
                              color: AppColors.secondaryColor, // 라벨의 텍스트 색상
                              fontSize: 30.0, // 라벨의 텍스트 크기
                              fontWeight: FontWeight.bold, // 라벨의 텍스트 굵기
                            ),
                            enabledBorder: OutlineInputBorder( // 활성화되지 않은 상태의 외곽선 스타일
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 5,
                                  color: AppColors.secondaryColor // 외곽선 색상 설정
                              ),

                            ),
                            focusedBorder: OutlineInputBorder( // 포커스를 받았을 때의 외곽선 스타일
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.blue), // 외곽선 색상 설정
                            ),
                            fillColor: AppColors.thirdColor, // 텍스트 필드 배경 색상
                            filled: true, // 배경 색상 채우기 여부
                            //prefixIcon: Icon(Icons.id), // 왼쪽에 아이콘 추가
                            suffixIcon: IconButton( // 오른쪽에 아이콘 버튼 추가
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _repasswordController.clear(); // 텍스트 필드를 지웁니다.
                              },
                            ),
                          ),
                          ),
                        ),
                      ),
                    ]),
              ),),

            SizedBox(height: 10),
            GestureDetector(
              onTap: ()  {
                String? id = _idController.text;
                String? pw = _passwordController.text;
                String? repw = _repasswordController.text;
                print("id: $id");
                if  (pw == repw)
                  print("pw: $pw");
                else
                  print("비밀번호를 다시 입력해주세요.");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserInfoScreen(id: id, pw: pw)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 480,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor, // Round shape edges
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all( // Border
                      color: AppColors.secondaryColor, // Border color
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '다음',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25, // Font size
                        color: Colors.black, // Font color
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],),
      ),
    );
  }
}

