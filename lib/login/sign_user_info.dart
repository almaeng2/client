import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:almang/home.dart'; // HomeScreen 파일 import
import 'package:almang/service.dart';

class UserInfoScreen extends StatefulWidget {
  final String id;
  final String pw;

  UserInfoScreen({required this.id, required this.pw});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  TextEditingController _nameController = TextEditingController();
  String? _selectedYear;
  String? _selectedMonth;
  String? _selectedDay;
  String? _selectedOptionBlind;

// 각 버튼 클릭 시 해당 옵션 값 업데이트
  void updateSelectedBlind(String index) {
    setState(() {
      // 현재 선택된 상태와 동일한 버튼을 다시 누르면 선택을 취소하도록 설정
      if (_selectedOptionBlind == index) {
        _selectedOptionBlind = null; // 선택 취소
      } else {
        _selectedOptionBlind = index; // 새로운 옵션 선택
      }
    });
  }

// 선택된 버튼에 테두리를 주는 BoxDecoration
  BoxDecoration getButtonDecoration(String index) {
    return BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: _selectedOptionBlind == index
            ? AppColors.secondaryColor
            : AppColors.primaryColor,
        width: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 60),
            SvgPicture.asset(
              'assets/almang_logo.svg', // Replace 'image.svg' with your SVG file path
              width: 80,
              height: 80,
            ),
            SizedBox(height: 20),
            Text(
              '사용자 정보를 입력하세요.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        '  이름을 입력해주세요.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25.0,
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
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor),
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: '  이름',
                              labelStyle: TextStyle(
                                color: AppColors.secondaryColor, // 라벨의 텍스트 색상
                                fontSize: 30.0, // 라벨의 텍스트 크기
                                fontWeight: FontWeight.bold, // 라벨의 텍스트 굵기
                              ),
                              enabledBorder: OutlineInputBorder(
                                // 활성화되지 않은 상태의 외곽선 스타일
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 5,
                                    color: AppColors.secondaryColor // 외곽선 색상 설정
                                    ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                // 포커스를 받았을 때의 외곽선 스타일
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    BorderSide(color: Colors.blue), // 외곽선 색상 설정
                              ),
                              fillColor: AppColors.thirdColor, // 텍스트 필드 배경 색상
                              filled: true, // 배경 색상 채우기 여부
                              //prefixIcon: Icon(Icons.email), // 왼쪽에 아이콘 추가
                              suffixIcon: IconButton(
                                // 오른쪽에 아이콘 버튼 추가
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _nameController.clear(); // 텍스트 필드를 지웁니다.
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        '  시각장애 정도를 선택해주세요.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: screenWidth,
                          height: 110,
                          decoration: BoxDecoration(
                            color: AppColors.thirdColor, // Round shape edges
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              // Border
                              color: AppColors.secondaryColor, // Border color
                              width: 5,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 20, 5, 20),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedBlind(
                                          '0'), // 선택된 옵션 업데이트
                                      child: Container(
                                        width: (screenWidth - 100) / 3,
                                        height: 60,
                                        decoration: getButtonDecoration('0'),
                                        child: Center(
                                          child: Text(
                                            '비장애',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: _selectedOptionBlind == '0'
                                                  ? AppColors.secondaryColor
                                                  : Colors
                                                      .white, // 선택 여부에 따라 글자색 설정
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 20, 5, 20),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedBlind(
                                          '1'), // 선택된 옵션 업데이트
                                      child: Container(
                                        width: (screenWidth - 100) / 3,
                                        height: 60,
                                        decoration: getButtonDecoration('1'),
                                        child: Center(
                                          child: Text(
                                            '저시력',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25, // Font size
                                              color: Colors.white, // Font color
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5, 20, 15, 20),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedBlind(
                                          '2'), // 선택된 옵션 업데이트
                                      child: Container(
                                        width: (screenWidth - 100) / 3,
                                        height: 60,
                                        decoration: getButtonDecoration('2'),
                                        child: Center(
                                          child: Text(
                                            '전맹',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25, // Font size
                                              color: Colors.white, // Font color
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        '  생년월일을 입력해주세요.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: screenWidth ,
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.thirdColor, // Round shape edges
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              // Border
                              color: AppColors.secondaryColor, // Border color
                              width: 5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 각 요소를 최대한으로 분산 배치합니다.
                            children: [
                              SizedBox(width: 10),
                              Container(
                                width: (screenWidth - 30) / 3,
                                height: 80,
                                child: DropdownButtonFormField<String>(
                                  isDense: false,
                                  itemHeight: 80, //what you need for height
                                  decoration: InputDecoration(
                                    labelText: '년',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 5,
                                          color: AppColors.secondaryColor),
                                    ),
                                    fillColor: AppColors.primaryColor,
                                    filled: true,
                                  ),
                                  value: _selectedYear,
                                  items: List.generate(100, (index) {
                                    int year = DateTime.now().year - index;
                                    return DropdownMenuItem(
                                      value: year.toString(),
                                      child: Center(
                                        child: Text(
                                          year.toString(),
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedYear = value;
                                    });
                                  },
                                  dropdownColor: AppColors.primaryColor,
                                ),
                              ),
                              Container(
                                width: (screenWidth - 110) / 3, // DropdownButtonFormField의 폭 조절
                                height: 80,
                                child: DropdownButtonFormField<String>(
                                  isDense: false,
                                  itemHeight: 80, //what you need for height
                                  decoration: InputDecoration(
                                    labelText: '월',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 5,
                                          color: AppColors.secondaryColor),
                                    ),
                                    fillColor: AppColors.primaryColor,
                                    filled: true,
                                  ),
                                  value: _selectedMonth,
                                  items: List.generate(12, (index) {
                                    int month = index + 1;
                                    return DropdownMenuItem(
                                      value: month.toString(), // 아이템의 높이 조절
                                      child: Center(
                                        child: Text(
                                          month.toString(),
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedMonth = value;
                                    });
                                  },
                                  dropdownColor: AppColors.primaryColor,
                                ),
                              ),
                              Container(
                                width: (screenWidth - 110) / 3,
                                height: 80,
                                child: DropdownButtonFormField<String>(
                                  isDense: false,
                                  itemHeight: 80, //what you need for height
                                  decoration: InputDecoration(
                                    labelText: '일',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 5,
                                          color: AppColors.secondaryColor),
                                    ),
                                    fillColor: AppColors.primaryColor,
                                    filled: true,
                                  ),
                                  value: _selectedDay,
                                  items: List.generate(31, (index) {
                                    int day = index + 1;
                                    return DropdownMenuItem(
                                      value: day.toString(),
                                      child: Center(
                                        child: Text(
                                          day.toString(),
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedDay = value;
                                    });
                                  },
                                  dropdownColor: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                String id = widget.id;
                String pw = widget.pw;
                String username = _nameController.text;
                String? level = _selectedOptionBlind;
                String? birth = "$_selectedYear.$_selectedMonth.$_selectedDay";


                if (username.isNotEmpty &&
                    level != null &&
                    birth != null ) {
                  print("id: $id");
                  print("pw: $pw");
                  print("사용자 이름: $username");
                  print("시각장애 정도: $level");
                  print("생년월일: $birth");

                  bool success = await server.signUp(
                    userId: 'mynew285',
                    pw: 'mynew004',
                    username: '권영미',
                    level: '2',
                    birth: '2002.03.04',
                  );

                  if (success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => homeScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('회원가입에 실패했습니다. 다시 시도해주세요.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('모든 정보를 입력해주세요.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 480,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor, // Round shape edges
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      // Border
                      color: AppColors.secondaryColor, // Border color
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '회원가입 완료',
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
          ],
        ),
      ),
    );
  }
}
