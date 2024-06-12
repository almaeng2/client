import 'package:almang/alarm/local_push_notification.dart';
import 'package:almang/alarm/message_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:almang/alarm/add_alarm.dart';
import 'package:almang/alarm/alarm_info.dart';
import 'package:almang/colors.dart';
import 'package:almang/home.dart';

class AlarmScreen extends StatefulWidget {
  final NotificationInfo alarms;

  AlarmScreen({required this.alarms});

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool switchEnabled = true;
  final List<NotificationInfo> _notifications = [];

  @override
  void initState() {
    super.initState();
    listenNotificaions();
    _setScheduleNotifications(); // Call the function to set scheduled notifications
  }

  void listenNotificaions(){
    LocalPushNotifications.notificationStream.stream.listen((String? payload) {
      if(payload != null){
        print('Recived payload: $payload');
        //Navigator.pushNamed(context, '/message', arguments: payload);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => messagePage()),
        );
      }
    });
  }

  Future<void> _setScheduleNotifications() async {
    // Check if the alarm is active
    // Parse the Hour and Minute strings to int
    int hour = int.parse(widget.alarms.Hour);
    int minute = int.parse(widget.alarms.Minute);

    // Convert the Days from string list to int list
    List<int> days = widget.alarms.Days.map((day) {
      switch (day) {
        case 'Monday': return DateTime.monday;
        case 'Tuesday': return DateTime.tuesday;
        case 'Wednesday': return DateTime.wednesday;
        case 'Thursday': return DateTime.thursday;
        case 'Friday': return DateTime.friday;
        case 'Saturday': return DateTime.saturday;
        case 'Sunday': return DateTime.sunday;
        default: return 0; // Default case, should not be hit if inputs are valid
      }
    }).toList();

    await LocalPushNotifications.showSimpleNotification(
      title: '알맹이',
      body: '${widget.alarms.alarmType}약 드실 시간입니다!\n 처방약: [ ${widget.alarms.prescription} ]',
      payload: '약 먹깅',

    );
    // // Set the schedule notification based on the received data
    // await LocalPushNotifications.showScheduleNotification(
    //   title: '알맹이',
    //   body: '스케쥴 푸시 알림 바디',
    //   payload: '스케쥴 푸시 알림',
    //   days: days,
    //   time: TimeOfDay(hour: hour, minute: minute),
    // );

  }


  void _addNotification(NotificationInfo notification) {
    setState(() {
      _notifications.add(notification);
    });
    print('Notification added: alarmType=${notification.alarmType}, Hour=${notification.Hour}, Minute=${notification.Minute}');
  }

  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          '복약 알림',
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
          SizedBox(height: 20),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAlarmScreen(onAddNotification: _addNotification),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: screenWidth/2-20,
                    height: 60,
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
                        '알림 추가',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25, // Font size
                          color: AppColors.secondaryColor, // Font color
                        ),
                      ),
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: screenWidth/2-20,
                    height: 60,
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
                        '알림 삭제',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25, // Font size
                          color: AppColors.secondaryColor, // Font color
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),

          SizedBox(height: 20),

          // Column to display notifications
          Expanded(
            child: ListView.builder(
              itemCount: widget.alarms.alarmType.isEmpty ? 0 : 1,
              itemBuilder: (context, index) {
                // final alarmInfo = alarms;
                return Container(
                  width: 450,
                  height: widget.alarms.alarmRepeat != '반복없음' ? 240 : 200,
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
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${widget.alarms.alarmType}  ${widget.alarms.Hour} : ${widget.alarms.Minute}',
                                style: TextStyle(
                                  fontSize: screenWidth/12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )
                            ),
                            Transform.scale(
                              scale: 1.6, // Increase the scale as needed
                              child: Switch(

                                value: widget.alarms.isActive,
                                onChanged: (value) {
                                  setState(() {
                                    widget.alarms.isActive = value;
                                  });
                                },
                                activeColor: AppColors.thirdColor, // Set the active color to green
                                activeTrackColor: AppColors.secondaryColor,
                              ),
                            )

                          ],
                        ),
                        SizedBox(height: 5),
                        Column(
                          children: [
                            if (widget.alarms.alarmRepeat != '반복없음')
                              Row(
                                children: [
                                  Text(
                                    widget.alarms.alarmPeriod != null && widget.alarms.alarmPeriod.isNotEmpty
                                        ? '반복요일: ${widget.alarms.alarmPeriod}'
                                        : '반복요일: ${widget.alarms.Days.join(', ')}',
                                    style: TextStyle(
                                      fontSize: screenWidth/12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                                widget.alarms.prescription == null
                                    ? '알림 처방전: 없음'
                                    : '알림 처방전: ${widget.alarms.prescription}',
                                style: TextStyle(
                                  fontSize: screenWidth/12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )
                            ),
                          ],
                        )
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
