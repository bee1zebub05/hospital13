import 'appoinment.dart';

//Mỗi 1 bệnh nhân có 1 sồ sơ bệnh án
class MedicalRecord {
  String doctorID;
  String patientID;
  //Mỗi 1 hồ sơ bệnh án có 1 lịch sử cuộc hẹn
  List<Appoinment>? historyRecord;
  MedicalRecord({
    required this.doctorID,
    required this.patientID,
  });
}
