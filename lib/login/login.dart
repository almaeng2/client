import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:almang/colors.dart';
import 'package:almang/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service.dart';


class LoginScreen extends StatefulWidget {

  LoginScreen({Key? key}) : super(key: key); // Update constructor

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Server server = Server();

  late SharedPreferences  _prefs;
  String _accessToken = '';
  String _refreshToken = '';

  @override
  void initState(){
    super.initState();
    _getTokens();
  }

  Future<void> _saveTokens() async {
    if (_prefs == '') {
      _getTokens();
    }
    _prefs.setString("accessToken", _accessToken);
    _prefs.setString("refreshToken", _refreshToken);
  }


  void _getTokens() async{
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = _prefs.getString("accessToken") ?? "";
      _refreshToken = _prefs.getString("refreshToken") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80),
          Center(
            child: SvgPicture.asset(
              'assets/almang_logo.svg',
              width: 80,
              height: 80,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 100.0),
                  Text(
                    '  아이디를 입력해주세요.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: SizedBox(
                      width: screenWidth-30,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryColor,
                          ),
                          controller: _idController,
                          decoration: InputDecoration(
                            labelText: '  아이디',
                            labelStyle: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 5,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            fillColor: AppColors.thirdColor,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _idController.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    '  비밀번호를 입력해주세요.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: SizedBox(
                      width: screenWidth-30,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryColor,
                          ),
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: '  비밀번호',
                            labelStyle: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 5,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            fillColor: AppColors.thirdColor,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _passwordController.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {

              print("id: ${_idController.text}");
              print("password: ${_passwordController.text}");
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => homeScreen()), // HomeScreen을 실제 화면으로 변경하세요.
              // );
              try {
                bool loginSuccess = await server.signIn(
                  id: _idController.text,
                  pw: _passwordController.text,
                );

                if (loginSuccess) {
                  // Navigate to the home screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => homeScreen()), // HomeScreen을 실제 화면으로 변경하세요.
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('로그인에 실패했습니다. 다시 시도해주세요.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('로그인 중 오류가 발생했습니다. 다시 시도해주세요.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Container(
                  width: screenWidth-50,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.secondaryColor,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
