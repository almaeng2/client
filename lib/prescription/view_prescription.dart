import 'package:almang/home.dart';
import 'package:almang/prescription/more_prescriptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:almang/colors.dart';
import 'package:almang/service.dart'; // server 인스턴스를 사용하기 위해 임포트
import 'package:almang/globals.dart'; // globals.dart를 임포트

class ViewPrescriptionScreen extends StatefulWidget {
  const ViewPrescriptionScreen({Key? key}) : super(key: key);

  @override
  _ViewPrescriptionScreenState createState() => _ViewPrescriptionScreenState();
}

class _ViewPrescriptionScreenState extends State<ViewPrescriptionScreen> {
  late List<dynamic> _medicineData = [];
  bool _isEditMode = false;
  List<bool> _selectedPrescriptions = [];

  @override
  void initState() {
    super.initState();
    _fetchMedicineData();
  }

  Future<void> _fetchMedicineData() async {
    List<dynamic> data = await server.getPre();
    setState(() {
      _medicineData = data;
      _selectedPrescriptions = List<bool>.filled(data.length, false);
    });
  }
  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
      if (!_isEditMode) {
        _selectedPrescriptions = List<bool>.filled(_medicineData.length, false);
      }
    });
  }

  Future<void> _deleteSelectedPrescription(int index) async {
    int prescriptionId = _medicineData[index]['listId'];
    await server.deletePrescription(prescriptionId);

    // 삭제 후에 데이터를 다시 가져와서 화면을 갱신
    await _fetchMedicineData();
    // // Remove the deleted prescription from the list
    // setState(() {
    //   _medicineData.removeAt(index);
    // });

    // Show success dialog
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text('처방전 삭제 성공'),
    //     content: Text('${_medicineData[index]['prescribedTime']} ${_medicineData[index]['name']} 처방전이 삭제되었습니다!'),
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Navigator.of(context).pop();
    //         },
    //         child: Text('닫기', style: TextStyle(fontSize: 20)),
    //       ),
    //     ],
    //   ),
    // );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          '처방전 열람',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Add this line to remove the back icon
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: _medicineData.isEmpty
          ? Column(
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
                onTap: _toggleEditMode,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: screenWidth - 30,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.thirdColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.secondaryColor,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _isEditMode ? '편집 모드 종료' : '편집',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
              '등록된 처방전이 없습니다.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: AppColors.secondaryColor,
              ),
                      ),
                    ),
            ],
          )
      : Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: screenWidth / 2,
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homeScreen()),
                  );
                },
                child: Container(
                  width: screenWidth / 2,
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
              )
            ],
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: _toggleEditMode,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: screenWidth - 30,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.thirdColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.secondaryColor,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    _isEditMode ? '편집 모드 종료' : '편집',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _medicineData.length,
              itemBuilder: (context, index) {
                var medicine = _medicineData[index];
                return Container(
                  width: screenWidth,
                  height: screenHeight / 6,
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.thirdColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: AppColors.secondaryColor,
                      width: 3,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              medicine['prescribedTime'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              child: Text(
                                medicine['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (!_isEditMode)
                          GestureDetector(
                            onTap: () async {
                              // 더보기를 클릭하면 해당 prescriptionId로 getPrescriptionById를 호출하여 정보 가져오기
                              try {
                                //
                                int prescriptionId = _medicineData[index]['listId'];
                                prescription = await server.getPrescriptionById(prescriptionId);
                                print(prescription);

                                // 새로운 페이지로 이동하고 데이터를 전달합니다.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PrescriptionDetailScreen(),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('처방전을 조회할 수 없습니다. 새로운 처방전을 등록해주세요.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              '      더보기 >',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (_isEditMode)
                          Row(
                            children: [
                              SizedBox(width: 80),
                              Transform.scale(
                                scale: 3.5, // Adjust the scale factor as needed
                                child: Checkbox(
                                  value: _selectedPrescriptions[index],
                                  onChanged: (value) async {
                                    setState(() {
                                      _selectedPrescriptions[index] = value!;
                                    });

                                    // Call _deleteSelectedPrescription if the checkbox is checked
                                    if (value == true) {
                                      bool deleteConfirmed = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('처방전 삭제'),
                                          content: Text(' ${_medicineData[index]['prescribedTime']} ${_medicineData[index]['name']} 처방전을 삭제하시겠습니까?',
                                          style: TextStyle(fontSize: 20)),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(false); // Return false when cancel button is pressed
                                              },
                                              child: Text('취소',style: TextStyle(fontSize: 20)),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true); // Return true when confirm button is pressed
                                              },
                                              child: Text('삭제',style: TextStyle(fontSize: 20)),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (deleteConfirmed == true) {
                                        await _deleteSelectedPrescription(index);
                                      } else {
                                        setState(() {
                                          _selectedPrescriptions[index] = false; // Uncheck the checkbox if delete is canceled
                                        });
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
