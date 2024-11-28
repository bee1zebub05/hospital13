import 'package:beginapp01/OOP_material/bill.dart';
import 'package:beginapp01/OOP_material/doctor.dart';
import 'package:beginapp01/OOP_material/patient.dart';

class Appoinment {
  String _appoinmentID;
  String _doctorID;
  String _patientID;
  DateTime dateTime;
  Bill? payedBill;
  // Constructor
  Appoinment({
    required String appoinmentID,
    required String doctorID,
    required String patientID,
    required this.dateTime,
  }) : _appoinmentID = appoinmentID, _doctorID = doctorID, _patientID = patientID;

  // Getter for appoinmentID
  String get appoinmentID => _appoinmentID;
  String get doctorID => _doctorID;
  String get patientID => _patientID;
  // Setter for appoinmentID
  set appoinmentID(String value) {
    _appoinmentID = value;
  }
  @override 
  String toString() {
    if (allPatient.containsKey(_patientID) && allDoctors.containsKey(_doctorID) ) {
      return 'Bệnh nhân: ${allPatient[_patientID]!.lastName} ${allPatient[_patientID]!.firstName}, '
              'Bác sĩ phụ trách: ${allDoctors[_doctorID]!.lastName} ${allDoctors[_doctorID]!.firstName} ' ;
    } else {
      return 'Bệnh nhân không tồn tại';
    }
  }
}

