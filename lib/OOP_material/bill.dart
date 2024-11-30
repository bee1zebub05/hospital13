import 'medicine.dart';

class Bill {
  List<MapEntry<Medicine, int>> medicinePairs; // Dùng List chứa các cặp Medicine và số lượng
  String? description;
  String doctorID;
  String patientID;

  Bill({
    required this.medicinePairs, // Thay List<Medicine> bằng List<MapEntry<Medicine, int>>
    required this.doctorID,
    required this.patientID,
  });

  double getTotalPrice() {
    double total = 0.0;
    // Duyệt qua danh sách các cặp medicine và số lượng
    for (var pair in medicinePairs) {
      total += pair.key.price * pair.value; // Nhân giá với số lượng
    }
    return total;
  }
}