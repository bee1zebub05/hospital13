import 'medicine.dart';

class Bill {
  DateTime dateTime;
  List<Medicine> medicines;
  String? description;
  String doctorID;
  String patientID;
  Bill({
    required this.medicines,
    required this.dateTime,
    required this.doctorID,
    required this.patientID,
  });

  double getTotalPrice() {
    double total = 0.0;
    for (var med in medicines) {
      total += med.price * med.quantity;
    }
    return total;
  }
}