import 'package:almang/alarm/local_push_notification.dart';
import 'package:almang/alarm/message_page.dart';
import 'package:flutter/material.dart';
import 'package:almang/home.dart';
import 'package:almang/login/login.dart';
import 'package:almang/splash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  // Initialize the plugin before running the app
  WidgetsFlutterBinding.ensureInitialized();
  //로컬 푸시 알림 초기화
  await LocalPushNotifications.init();

  //앱이 종료된 상태에서 푸시 알림을 탭할 때
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed('/message',
          arguments: notificationAppLaunchDetails?.notificationResponse?.payload);
    });
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // Pass storage to SplashScreen
        '/login': (context) => LoginScreen(), // Pass storage to LoginScreen
        '/home': (context) => homeScreen(), // HomeScreen doesn't require storage
        '/message': (context) => messagePage(),
      },
    );
  }
}

