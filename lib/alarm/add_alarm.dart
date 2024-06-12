import 'package:almang/alarm/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:almang/home.dart';
import 'package:almang/alarm/alarm_home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../service.dart';

class AddAlarmScreen extends StatefulWidget {
  final Function(NotificationInfo) onAddNotification;

  AddAlarmScreen({required this.onAddNotification});
  //const AddAlarmScreen({Key? key}) : super(key: key);
  @override
  _AddAlarmScreenState createState() => _AddAlarmScreenState();
}


class _AddAlarmScreenState extends State<AddAlarmScreen> {
  String? _selectedPrescription;
  late Future<List<dynamic>> _medicineListFuture;

  @override
  void initState() {
    super.initState();
    _medicineListFuture = server.getPre();

  }


  String Hour = '00'; // 아침 시간 (시)
  String Minute= '00'; // 아침 시간 (분)

  String _selectedOptionAlarmType = '';
  String _selectedOptionAlarmRepeat= '';
  String _selectedOptionAlarmTerm = '';

  List<String> _selectedDays = []; // 선택된 요일을 저장하는 리스트


// 선택된 요일 업데이트하는 함수
  void updateSelectedDays(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day); // 이미 선택된 요일인 경우 제거

        // 토요일이나 일요일이 선택되어 있고, 토요일이나 일요일이 삭제되면 주말 비활성화
        if (_selectedOptionAlarmTerm == '주말' &&
            !(_selectedDays.contains('토') &&
            _selectedDays.contains('일'))) {
            _selectedOptionAlarmTerm = '';
        }

        // 매일이 선택되어 있고, 하나라도 빠지면 매일 비활성화
        if (_selectedOptionAlarmTerm == '매일' &&
            (!(_selectedDays.contains('월') &&
                _selectedDays.contains('화') &&
                _selectedDays.contains('수') &&
                _selectedDays.contains('목') &&
                _selectedDays.contains('금') &&
                _selectedDays.contains('토') &&
                _selectedDays.contains('일')))) {
          _selectedOptionAlarmTerm = '';
        }

        // 평일이 선택되어 있고, 하나라도 빠지면 평일 비활성화
        if (_selectedOptionAlarmTerm == '평일' && !( _selectedDays.contains('평일') &&
            _selectedDays.contains('화') && _selectedDays.contains('수') &&
            _selectedDays.contains('목') && _selectedDays.contains('금'))) {
          _selectedOptionAlarmTerm = '';
        }
      } else {
        // 선택되지 않은 요일인 경우 추가
        _selectedDays.add(day);

        // '매일'이 선택된 경우
        if (_selectedDays.contains('월') &&
            _selectedDays.contains('화') &&
            _selectedDays.contains('수') &&
            _selectedDays.contains('목') &&
            _selectedDays.contains('금') &&
            _selectedDays.contains('토') &&
            _selectedDays.contains('일')) {
          _selectedOptionAlarmTerm = '매일';
        }
        // '주말'이 선택된 경우
        else if (_selectedDays.contains('토') && _selectedDays.contains('일')) {
          _selectedOptionAlarmTerm = '주말';
        }
        // '평일'이 선택된 경우
        else if (_selectedDays.contains('월') &&
            _selectedDays.contains('화') &&
            _selectedDays.contains('수') &&
            _selectedDays.contains('목') &&
            _selectedDays.contains('금')) {
          _selectedOptionAlarmTerm = '평일';
        } else {
          // 선택된 요일이 없는 경우 '안함'으로 초기화
          _selectedOptionAlarmTerm = '';
        }
      }
    });
  }

  // 선택된 요일에 따라 버튼 스타일을 반환하는 함수
  BoxDecoration getButtonDecorationDays(String day) {
    return BoxDecoration(
      color: AppColors.box,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: _selectedDays.contains(day) ? AppColors.yellow : AppColors.box,
        width: 5,
      ),
    );
  }



  // 선택된 알람 종류에 따라 버튼 스타일을 반환하는 함수
  BoxDecoration getButtonDecorationType(String type) {
    return BoxDecoration(
        color: AppColors.box,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
        color: _selectedOptionAlarmType == type ? AppColors.yellow : AppColors.box,
         width: 5,
        ),
    );
  }

// 매일/평일/주말에 대한 업데이트 함수
  void updateSelectedAlarmTerm(String index) {
    setState(() {
      // 이미 선택된 경우 해당 상태 초기화
      if (_selectedOptionAlarmTerm == index) {
        _selectedOptionAlarmTerm = '';
        // 해당 상태가 해제되었으므로 요일 선택 초기화
        _selectedDays.clear();
      } else {
        // 선택되지 않은 경우 새로운 값으로 설정
        _selectedOptionAlarmTerm = index;

        // 매일 선택한 경우
        if (index == '매일') {
          _selectedDays = ['월', '화', '수', '목', '금', '토', '일'];
        }
        // 평일 선택한 경우
        else if (index == '평일') {
          _selectedDays = ['월', '화', '수', '목', '금'];
        }
        // 주말 선택한 경우
        else if (index == '주말') {
          _selectedDays = ['토', '일'];
        }
      }
    });
  }

// 알람 종류 아침/점심/저녁에 대한 선택 업데이트 함수
  void updateSelectedAlarmType(String index) {
    setState(() {
      // 이미 선택된 경우 해당 상태 초기화
      if (_selectedOptionAlarmType == index) {
        _selectedOptionAlarmType = '';
      } else {
        // 선택되지 않은 경우 새로운 값으로 추가
        _selectedOptionAlarmType = index;
      }
      // 알람 종류에 따라 시간 초기값 설정
        switch (index) {
          case '아침':
            Hour = '07';
            Minute = '00';
            break;
          case '점심':
            Hour = '12';
            Minute = '00';
            break;
          case '저녁':
            Hour = '18';
            Minute = '00';
            break;
        }
    });
  }



// 반복 설정을 업데이트하는 함수
  void updateSelectedAlarmRepeat(String index) {
    setState(() {
      // 이미 선택된 경우 상태 초기화
      if (_selectedOptionAlarmRepeat == index) {
        _selectedOptionAlarmRepeat = '';
      } else {
        // 새로운 값으로 설정
        _selectedOptionAlarmRepeat = index;
        // 요일 목록과 알람 기간 초기화
        if (_selectedOptionAlarmRepeat == '반복없음') {
          _selectedDays.clear();
          _selectedOptionAlarmTerm = '';
        }
      }
    });
  }



  // 선택된 버튼에 테두리를 주는 BoxDecoration
  BoxDecoration getButtonDecoration(String index, String? selectedOption) {
    return BoxDecoration(
      color: AppColors.box,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: selectedOption == index ? AppColors.yellow : AppColors.box,
        width: 5,
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          title: Text('알림 추가',
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
        body:
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

                Expanded(child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(height:20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: screenWidth,
                          height:  145, // 상태에 따라 높이 조정
                          decoration: BoxDecoration(
                            color: AppColors.thirdColor, // Round shape edges
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all( // Border
                              color: AppColors.secondaryColor, // Border color
                              width: 3,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '  알람 종류',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25, // 폰트 크기
                                        color: AppColors.secondaryColor, // 폰트 색상
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 각 요소를 최대한으로 분산 배치합니다.
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedAlarmType('아침'), // 선택된 옵션 업데이트
                                      child: Semantics(
                                        label: '아침약은 알림 시간이 7시로 자동 설정됩니다.알림 시간에서 수정할 수 있습니다.',
                                        child: Container(
                                          width: (screenWidth - 130) / 3,
                                          height: 60,
                                          decoration: getButtonDecoration('아침',_selectedOptionAlarmType),
                                          child: Center(
                                            child: Text(
                                              '아침',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25, // Font size
                                                color: _selectedOptionAlarmType == '아침' ? AppColors.yellow : Colors.white, // 선택 여부에 따라 글자색 설정
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedAlarmType('점심'), // 선택된 옵션 업데이트
                                      child: Semantics(
                                        label: '점심약은 알림 시간이 12시로 자동 설정됩니다.알림 시간에서 수정할 수 있습니다.',
                                        child: Container(
                                          width: (screenWidth - 130) / 3,
                                          height: 60,
                                          decoration: getButtonDecoration('점심',_selectedOptionAlarmType),
                                          child: Center(
                                            child: Text(
                                              '점심',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25, // Font size
                                                color: _selectedOptionAlarmType == '점심' ? AppColors.yellow : Colors.white, // 선택 여부에 따라 글자색 설정
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedAlarmType('저녁'), // 선택된 옵션 업데이트
                                      child: Semantics(
                                        label: '저녁약은 알림 시간이 12시로 자동 설정됩니다.알림 시간에서 수정할 수 있습니다.',
                                        child: Container(
                                          width: (screenWidth - 130) / 3,
                                          height: 60,
                                          decoration: getButtonDecoration('저녁',_selectedOptionAlarmType),
                                          child: Center(
                                            child: Text(
                                              '저녁',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25, // Font size
                                                color: _selectedOptionAlarmType == '저녁' ? AppColors.yellow : Colors.white, // 선택 여부에 따라 글자색 설정
                                              ),
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

                      SizedBox(height:10),

                      Padding(
                          padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 480,
                          height: 160, // 상태에 따라 높이 조정
                          decoration: BoxDecoration(
                            color: AppColors.thirdColor, // Round shape edges
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all( // Border
                              color: AppColors.secondaryColor, // Border color
                              width: 3,
                            ),
                          ),

                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      '  알림 시간',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25, // Font size
                                        color: AppColors.secondaryColor, // Font color
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 각 요소를 최대한으로 분산 배치합니다.
                                children: [
                                  SizedBox(width: 10),
                                  Container(
                                    width: 130,
                                    height: 80,
                                    child: DropdownButtonFormField<String>(
                                      isDense: false,
                                      itemHeight: 80,
                                      iconSize: 40.0,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                            width: 5,
                                            color: AppColors.yellow, // Adjusted to your secondary color
                                          ),
                                        ),
                                        fillColor: AppColors.box, // Adjusted to your primary color
                                        filled: true,
                                      ),
                                      value: Hour,
                                      items: List.generate(24, (index) {
                                        String hour = index.toString().padLeft(2, '0');
                                        return DropdownMenuItem(
                                          value: hour,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                              child: Text(
                                                hour,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 32.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                        );
                                      }),
                                      onChanged: (value) {
                                        setState(() {
                                          Hour = value ?? '00';
                                        });
                                      },
                                      dropdownColor: AppColors.box, // Adjusted to your primary color
                                    ),
                                  ),

                                  Text(
                                    ':',
                                    style: TextStyle(
                                    fontSize: 50.0, // Increase the font size to make it larger
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Adjust the color as needed
                                    ),
                                  ),

                                  Container(
                                    width: 130,
                                    height: 80,
                                    child: DropdownButtonFormField<String>(
                                      isDense: false,
                                      itemHeight: 80,
                                      iconSize: 40.0,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                            width: 5,
                                            color: AppColors.yellow, // Adjusted to your secondary color
                                          ),
                                        ),
                                        fillColor: AppColors.box, // Adjusted to your primary color
                                        filled: true,
                                      ),
                                      value: Minute,
                                      items: List.generate(60, (index) {
                                        int minute = index;
                                        return DropdownMenuItem(
                                          value: minute.toString().padLeft(2, '0'),

                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                              child: Text(
                                                minute.toString().padLeft(2, '0'),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 32.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                        );
                                      }),
                                      onChanged: (value) {
                                        setState(() {
                                          Minute = value ?? '00';
                                        });
                                      },
                                      dropdownColor: AppColors.box, // Adjusted to your primary color
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                          ],
                        ),
                        ),
                      ),

                      SizedBox(height:10),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: screenWidth,
                          height: _selectedOptionAlarmRepeat == '요일반복' ? screenWidth*0.75 : screenWidth*0.38, // 상태에 따라 높이 조정
                          decoration: BoxDecoration(
                            color: AppColors.thirdColor, // Round shape edges
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all( // Border
                              color: AppColors.secondaryColor, // Border color
                              width: 3,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      '  반복 설정',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25, // Font size
                                        color: AppColors.secondaryColor, // Font color
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 각 요소를 최대한으로 분산 배치합니다.
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(50, 0, 20, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedAlarmRepeat('반복없음'), // 선택된 옵션 업데이트
                                      child: Container(
                                        width: screenWidth * 0.29,
                                        height: 60,
                                        decoration: getButtonDecoration('반복없음', _selectedOptionAlarmRepeat),
                                        child: Center(
                                          child: Text(
                                            '반복 없음',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25, // Font size
                                              color: _selectedOptionAlarmRepeat == '반복없음' ? AppColors.yellow : Colors.white, // 선택 여부에 따라 글자색 설정
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 50, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedAlarmRepeat('요일반복'), // 선택된 옵션 업데이트
                                      child: Container(
                                        width: screenWidth * 0.29,
                                        height: 60,
                                        decoration: getButtonDecoration('요일반복', _selectedOptionAlarmRepeat),
                                        child: Center(
                                          child: Text(
                                            '요일 선택',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25, // Font size
                                              color: _selectedOptionAlarmRepeat == '요일반복' ? AppColors.yellow : Colors.white, // 선택 여부에 따라 글자색 설정
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              //if (_selectedOptionAlarmRepeat == '요일반복') // 선택된 옵션이 '요일 선택'일 때만 표시
                                Visibility(
                                  visible: _selectedOptionAlarmRepeat == '요일반복',
                                    child: Row(
                                      children: [
                                        // 요일 선택 버튼 추가
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
                                          child: GestureDetector(
                                            onTap: () => updateSelectedAlarmTerm('매일'), // 선택된 옵션 업데이트
                                            child: Container(
                                              width: (screenWidth - 100) / 3,
                                              height: 60,
                                              decoration: getButtonDecoration('매일', _selectedOptionAlarmTerm),
                                              child: Center(
                                                child: Text(
                                                  '매일',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25, // Font size
                                                    color: _selectedOptionAlarmTerm == '매일' ? AppColors.yellow : Colors.white, // 선택 여부에 따라 글자색 설정
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 0, 10, 10),
                                          child: GestureDetector(
                                            onTap: () => updateSelectedAlarmTerm('평일'), // 선택된 옵션 업데이트
                                            child: Container(
                                              width: (screenWidth - 100) / 3,
                                              height: 60,
                                              decoration: getButtonDecoration('평일', _selectedOptionAlarmTerm),
                                              child: Center(
                                                child: Text(
                                                  '평일',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25, // Font size
                                                    color: _selectedOptionAlarmTerm == '평일' ? AppColors.yellow : Colors.white, // 선택 여부에 따라 글자색 설정
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 0, 20, 10),
                                          child: GestureDetector(
                                            onTap: () => updateSelectedAlarmTerm('주말'), // 선택된 옵션 업데이트
                                            child: Container(
                                              width: (screenWidth - 100) / 3,
                                              height: 60,
                                              decoration: getButtonDecoration('주말', _selectedOptionAlarmTerm),
                                              child: Center(
                                                child: Text(
                                                  '주말',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25, // Font size
                                                    color: _selectedOptionAlarmTerm == '주말' ? AppColors.yellow : Colors.white, // 선택 여부에 따라 글자색 설정
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                ),
                              SizedBox(height: 5),
                              Visibility(
                                visible: _selectedOptionAlarmRepeat == '요일반복',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 각 요소를 최대한으로 분산 배치합니다.
                                  children: [
                                  // 요일 선택 버튼 추가
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedDays('월'),
                                      child: Container(
                                        width: (screenWidth - 110) / 7,
                                        height: 60,
                                        decoration: getButtonDecorationDays('월'),
                                        child: Center(
                                          child: Text(
                                            '월',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25, // Font size
                                              color: _selectedDays.contains('월') ? AppColors.yellow : Colors.white , // 선택 여부에 따라 글자색 설정
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedDays('화'),
                                      child: Container(
                                        width: (screenWidth - 110) / 7,
                                        height: 60,
                                        decoration: getButtonDecorationDays('화'),
                                        child: Center(
                                          child: Text(
                                            '화',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25, // Font size
                                              color: _selectedDays.contains('화') ? AppColors.yellow : Colors.white , // 선택 여부에 따라 글자색 설정
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedDays('수'),
                                      child: Container(
                                        width: (screenWidth - 110) / 7,
                                        height: 60,
                                        decoration: getButtonDecorationDays('수'),
                                        child: Center(
                                          child: Text(
                                            '수',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25, // Font size
                                              color: _selectedDays.contains('수') ? AppColors.yellow : Colors.white , // 선택 여부에 따라 글자색 설정
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedDays('목'),
                                      child: Container(
                                        width: (screenWidth - 110) / 7,
                                        height: 60,
                                        decoration: getButtonDecorationDays('목'),
                                        child: Center(
                                          child: Text(
                                            '목',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25, // Font size
                                              color: _selectedDays.contains('목') ? AppColors.yellow : Colors.white , // 선택 여부에 따라 글자색 설정
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedDays('금'),
                                      child: Container(
                                        width: (screenWidth - 110) / 7,
                                        height: 60,
                                        decoration: getButtonDecorationDays('금'),
                                        child: Center(
                                          child: Text(
                                            '금',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25, // Font size
                                              color: _selectedDays.contains('금') ? AppColors.yellow : Colors.white , // 선택 여부에 따라 글자색 설정
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedDays('토'),
                                      child: Container(
                                        width: (screenWidth - 110) / 7,
                                        height: 60,
                                        decoration: getButtonDecorationDays('토'),
                                        child: Center(
                                          child: Text(
                                            '토',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25, // Font size
                                              color: _selectedDays.contains('토') ? AppColors.yellow : Colors.white , // 선택 여부에 따라 글자색 설정
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 10, 10),
                                    child: GestureDetector(
                                      onTap: () => updateSelectedDays('일'),
                                      child: Container(
                                        width: (screenWidth - 110) / 7,
                                        height: 60,
                                        decoration: getButtonDecorationDays('일'),
                                        child: Center(
                                          child: Text(
                                            '일',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25, // Font size
                                              color: _selectedDays.contains('일') ? AppColors.yellow : Colors.white , // 선택 여부에 따라 글자색 설정
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),),
                            ],
                          ),
                        ),
                      ),


                      SizedBox(height:10),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 480,
                          height: 200,
                          decoration: BoxDecoration(
                            color: AppColors.thirdColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.secondaryColor,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      '  알림 처방전 설정',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: AppColors.secondaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              FutureBuilder<List<dynamic>>(
                                future: _medicineListFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Text('No medicines available');
                                  } else {
                                    List<dynamic> medicineList = snapshot.data!;

                                    // // Ensure _selectedPrescription matches one of the values
                                    // if (_selectedPrescription != null &&
                                    //     !medicineList.any((item) => item['name'] == _selectedPrescription)) {
                                    //   _selectedPrescription = null;
                                    // }

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Container(
                                        height: 80,
                                        child: DropdownButton<String>(
                                          isDense: false,
                                          itemHeight: 80,
                                          hint: Center(
                                            child: Text(
                                              "처방전을 선택하세요",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                fontSize: 30
                                              ),
                                            ),
                                          ),
                                          value: _selectedPrescription,
                                          dropdownColor: AppColors.primaryColor,
                                          //icon: Icon(Icons.arrow_downward, color: Colors.white),
                                          //iconSize: 24,
                                          //elevation: 16,
                                          style: TextStyle(color: AppColors.yellow),
                                          underline: Container(
                                            height: 2,
                                            color: AppColors.yellow,
                                          ),
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectedPrescription = newValue;
                                            });
                                          },
                                          items: medicineList.map<DropdownMenuItem<String>>((dynamic value) {
                                            return DropdownMenuItem<String>(
                                              value: value['name'],
                                              child: Center(
                                                child: Text(
                                                    value['name'],
                                                  style: TextStyle(
                                                    fontSize: 30.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height:10),
                    ],
                  ),
                ),),

                GestureDetector(
                  onTap: ()   {
                    bool valid = false;
                    if (_selectedOptionAlarmType.isNotEmpty &&
                    _selectedOptionAlarmRepeat.isNotEmpty &&
                    _selectedPrescription != null) {
                      valid = true; // Variable for validation
                    }
                    // If the alarm repeat option is '요일반복', check if there are day and period options
                    if (_selectedOptionAlarmRepeat == '요일반복') {
                    if (_selectedDays.isEmpty || _selectedOptionAlarmTerm.isEmpty) {
                    valid = false;}};

                    if(valid) {
                      _checkAndNavigateToAlarmScreen(); // Navigate to the alarm screen
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
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.yellow, // Round shape edges
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all( // Border
                          color: AppColors.yellow, // Border color
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '저장',
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

              ],
            ),
      ),
    );
  }

  void _checkAndNavigateToAlarmScreen() {
    print('알람 타입: $_selectedOptionAlarmType');
    print('알람 반복: $_selectedOptionAlarmRepeat');
    print('아침 시간: $Hour:$Minute');
    print('선택된 요일: $_selectedDays');
    print('알람 기간: $_selectedOptionAlarmTerm');
    print('선택된 처방전: $_selectedPrescription'); // 선택된 처방전 이름 출력

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AlarmScreen(
              alarms: NotificationInfo(
                alarmType: _selectedOptionAlarmType,
                alarmRepeat: _selectedOptionAlarmRepeat,
                Hour: Hour,
                Minute: Minute,
                Days: _selectedDays,
                alarmPeriod: _selectedOptionAlarmTerm,
                prescription: _selectedPrescription,
                // 선택된 처방전 이름 추가
                isActive: true,
              ),
            ),
      ),
    );
  }}