import 'package:flutter/material.dart';

class MedicineInfoWidget extends StatelessWidget {
  final String medicineName;
  final String appearance;
  final String efficacy;
  final String dosageInstruction;
  final String precautions;
  final String imageUrl;

  const MedicineInfoWidget({
    Key? key, // 이 부분에서 key 매개변수를 선택적으로 변경
    required this.medicineName,
    required this.appearance,
    required this.efficacy,
    required this.dosageInstruction,
    required this.precautions,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '알약 이름: $medicineName',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '생김새: $appearance',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '효능/효과: $efficacy',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '복약 안내: $dosageInstruction',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '주의사항: $precautions',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          if (imageUrl != null) // 이미지가 제공되면 표시
            Image.network(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:your_project_name/medicine_info_widget.dart';
//
// class MyPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Medicine Information'),
//       ),
//       body: Center(
//         child: MedicineInfoWidget(
//           medicineName: '타이레놀',
//           appearance: '원형, 노란색',
//           efficacy: '진통 및 해열',
//           dosageInstruction: '1일 최대 3회, 식후 복용',
//           precautions: '식품 알레르기 유발 가능성',
//           imageUrl: 'https://example.com/medicine_image.jpg',
//         ),
//       ),
//     );
//   }
// }
