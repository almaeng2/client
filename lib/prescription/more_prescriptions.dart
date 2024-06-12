import 'package:almang/home.dart';
import 'package:flutter/material.dart';
import 'package:almang/globals.dart';
import 'package:flutter_svg/svg.dart';

import '../colors.dart';

class PrescriptionDetailScreen extends StatefulWidget {
  PrescriptionDetailScreen();

  @override
  _PrescriptionDetailScreenState createState() => _PrescriptionDetailScreenState();
}

class _PrescriptionDetailScreenState extends State<PrescriptionDetailScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final int totalPages = prescription.length;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          '처방약 상세정보',
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
          Text(
            '현재 페이지 ${_currentPage + 1} / $totalPages',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.secondaryColor,
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalPages,
              itemBuilder: (context, index) {
                var medInfo = prescription[index];
                String cleanedShape = medInfo['shape'].replaceAll('"', '');
                String cleanedEffect = medInfo['effect'].replaceAll('"', '');
                String cleanedClassification = medInfo['caution'].replaceAll('"', '');
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: AppColors.thirdColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.secondaryColor,
                        width: 3,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                            child: Image.network(medInfo['imageUrl']),
                          ),
                          SizedBox(height: 15),
                          Center(
                            child: Text(
                              medInfo['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Center(
                            child: Text(
                              '분류 ${medInfo['classification'] ?? 'null'}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Divider(color: AppColors.secondaryColor,),
                          SizedBox(height: 15.0),
                          Center(
                            child: Text(
                              '생김새',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Center(
                            child: Text(
                              cleanedShape,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Divider(color: AppColors.secondaryColor,),
                          SizedBox(height: 15.0),
                          Center(
                            child: Text(
                              '효능효과',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Center(
                            child: Text(
                              cleanedEffect,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Divider(color: AppColors.secondaryColor,),
                          SizedBox(height: 15.0),
                          Center(
                            child: Text(
                              '복약안내',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Center(
                            child: Text(
                              cleanedClassification,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                        ],
                      ),
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
