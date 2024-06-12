class NotificationInfo {
  final String alarmType; //아침/저녁/점심
  final String alarmRepeat; // 반복없음/요일반복
  final String alarmPeriod; //매일/평일/주말
  final String Hour; // 알람 시간
  final String Minute;
  final List<String> Days;
  final String? prescription; // 알림 처방전 이름 --> api로 받아오기
  bool isActive;


  NotificationInfo({
    required this.alarmRepeat,
    this.alarmType ='',
    required this.alarmPeriod,
    required this.Hour,
    required this.Minute,
    required this.Days,
    required this.prescription,
    this.isActive = true,
  });
}