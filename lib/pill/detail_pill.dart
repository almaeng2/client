import 'package:almang/home.dart';
import 'package:flutter/material.dart';
import 'package:almang/colors.dart';
import 'package:flutter_svg/svg.dart';

class PillDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> details;

  PillDetailsScreen({required this.details});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    String cleanedEffect = details['effect'].replaceAll('"', '');
    String cleanedCaution = details['caution'].replaceAll('"', '');
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text(
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

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //details['caution'] = details['caution'].replaceAll('"', ''),
                  SizedBox(height: 15),
                  if (details['imageUrl'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                      child: Container(
                        width: 320,
                          child: Image.network(details['imageUrl'])
                      ),
                    ),
                  SizedBox(height: 15),
                          Text(
                            details['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: AppColors.secondaryColor,
                            ),
                        ),
                  SizedBox(height: 15),
                  Container(
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
                          SizedBox(height: 15.0),
                          Center(
                            child: Text(
                              '분류',
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
                              '${details['classification']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Divider(color: AppColors.secondaryColor),
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
                              '${details['shape']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Divider(color: AppColors.secondaryColor),
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
                          Divider(color: AppColors.secondaryColor),
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
                              cleanedCaution,
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
                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}