import 'package:beginapp01/OOP_material/bill.dart';
import 'package:beginapp01/OOP_material/doctor.dart';
import 'package:beginapp01/OOP_material/patient.dart';
import 'package:beginapp01/OOP_material/person.dart';
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

class Appoinment {
  String _appoinmentID;
  String _doctorID;
  String _patientID;
  DateTime dateTime;
  bool hasPass;
  Bill? payedBill;
  // Constructor
  Appoinment({
    required String appoinmentID,
    required String doctorID,
    required String patientID,
    required this.dateTime,
    required this.hasPass,
  }) : _appoinmentID = appoinmentID, _doctorID = doctorID, _patientID = patientID{
    if(dateTime.isBefore(DateTime.now()) && !hasPass){
      throw EmptyFieldException('Không thể đặt cuộc hẹn ở quá khứ');
    }
  }

  // Getter for appoinmentID
  String get appoinmentID => _appoinmentID;
  String get doctorID => _doctorID;
  String get patientID => _patientID;
  set dateTimeSetter(DateTime value){
    if( value.isBefore(DateTime.now()) ){
      throw EmptyFieldException('Không thể đặt cuộc hẹn ở quá khứ');
    }
    dateTime = value;
  }
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

int appoinmentLastestID = 4;

// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0



/// Example appointments map.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kAppointments = LinkedHashMap<DateTime, List<Appoinment>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll({
  DateTime(2024,11,26) : [
    Appoinment(
      appoinmentID: 'CH000001',
      doctorID: 'DT000001',
      patientID: 'BN000001',
      dateTime: DateTime(2024,11,26),
      hasPass: true,
    ),
  ],
  DateTime(2024,11,27) : [
    Appoinment(
      appoinmentID: 'CH000002',
      doctorID: 'DT000002',
      patientID: 'BN000002',
      dateTime: DateTime(2024,11,27),
      hasPass: true,
    ),
  ],
  DateTime(2024,11,28) : [
    Appoinment(
      appoinmentID: 'CH000003',
      doctorID: 'DT000003',
      patientID: 'BN000003',
      dateTime: DateTime(2024,11,28),
      hasPass: true,
    ),
  ],
  DateTime(2024,11,29) : [
    Appoinment(
      appoinmentID: 'CH000004',
      doctorID: 'DT000004',
      patientID: 'BN000004',
      dateTime: DateTime(2024,11,29),
      hasPass: true,
    ),
  ],
});


/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);