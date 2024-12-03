import 'package:beginapp01/OOP_material/bill.dart';
import 'package:beginapp01/OOP_material/doctor.dart';
import 'package:beginapp01/OOP_material/patient.dart';
import 'package:beginapp01/OOP_material/person.dart';
import 'package:beginapp01/OOP_material/hospital_inventory.dart';
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

class Appoinment {
  String _appoinmentID;
  final String _doctorID;
  final String _patientID;
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

int getTotalAppoinment(){
  int sum = 0;
  for( var list in kAppointments.values ) {
    sum+=list.length;
  }
  return sum;
}

int appoinmentLastestID = getTotalAppoinment();

// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0



/// Example appointments map.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kAppointments = LinkedHashMap<DateTime, List<Appoinment>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll({
     DateTime.now().add(const Duration(days: -16)): [
    Appoinment(
      appoinmentID: 'CH000001',
      doctorID: 'DT000001',
      patientID: 'BN000001',
      dateTime: DateTime.now().add(const Duration(days: -16)),
      hasPass: DateTime.now().add(const Duration(days: -16)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000001',
        patientID: 'DT000001',
      ),
    Appoinment(
      appoinmentID: 'CH000002',
      doctorID: 'DT000002',
      patientID: 'BN000002',
      dateTime: DateTime.now().add(const Duration(days: -16)),
      hasPass: DateTime.now().add(const Duration(days: -16)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000005']!, 5),
          MapEntry(allMedicines['ME000003']!, 13),
          MapEntry(allMedicines['ME000020']!, 9),
        ],
        doctorID: 'DT000002',
        patientID: 'DT000002',
      ),
  ],
  DateTime.now().add(const Duration(days: -15)): [
    Appoinment(
      appoinmentID: 'CH000003',
      doctorID: 'DT000003',
      patientID: 'BN000003',
      dateTime: DateTime.now().add(const Duration(days: -15)),
      hasPass: DateTime.now().add(const Duration(days: -15)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000015']!, 12),
        ],
        doctorID: 'DT000003',
        patientID: 'DT000003',
      ),
    Appoinment(
      appoinmentID: 'CH000004',
      doctorID: 'DT000004',
      patientID: 'BN000004',
      dateTime: DateTime.now().add(const Duration(days: -15)),
      hasPass: DateTime.now().add(const Duration(days: -15)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000014']!, 4),
        ],
        doctorID: 'DT000004',
        patientID: 'DT000004',
      ),
    Appoinment(
      appoinmentID: 'CH000005',
      doctorID: 'DT000005',
      patientID: 'BN000005',
      dateTime: DateTime.now().add(const Duration(days: -15)),
      hasPass: DateTime.now().add(const Duration(days: -15)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000005',
        patientID: 'DT000005',
      ),
    Appoinment(
      appoinmentID: 'CH000006',
      doctorID: 'DT000006',
      patientID: 'BN000006',
      dateTime: DateTime.now().add(const Duration(days: -15)),
      hasPass: DateTime.now().add(const Duration(days: -15)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000006',
        patientID: 'DT000006',
      ),
  ],
  DateTime.now().add(const Duration(days: -14)): [
    Appoinment(
      appoinmentID: 'CH000007',
      doctorID: 'DT000007',
      patientID: 'BN000007',
      dateTime: DateTime.now().add(const Duration(days: -14)),
      hasPass: DateTime.now().add(const Duration(days: -14)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000007',
        patientID: 'DT000007',
      ),
    Appoinment(
      appoinmentID: 'CH000008',
      doctorID: 'DT000008',
      patientID: 'BN000008',
      dateTime: DateTime.now().add(const Duration(days: -14)),
      hasPass: DateTime.now().add(const Duration(days: -14)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000016']!, 13),
        ],
        doctorID: 'DT000008',
        patientID: 'DT000008',
      ),
    Appoinment(
      appoinmentID: 'CH000009',
      doctorID: 'DT000009',
      patientID: 'BN000009',
      dateTime: DateTime.now().add(const Duration(days: -14)),
      hasPass: DateTime.now().add(const Duration(days: -14)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000015']!, 4),
          MapEntry(allMedicines['ME000009']!, 12),
          MapEntry(allMedicines['ME000003']!, 1),
          MapEntry(allMedicines['ME000017']!, 3),
          MapEntry(allMedicines['ME000004']!, 5),
          MapEntry(allMedicines['ME000011']!, 4),
        ],
        doctorID: 'DT000009',
        patientID: 'DT000009',
      ),
    Appoinment(
      appoinmentID: 'CH000010',
      doctorID: 'DT000010',
      patientID: 'BN000010',
      dateTime: DateTime.now().add(const Duration(days: -14)),
      hasPass: DateTime.now().add(const Duration(days: -14)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000020']!, 12),
          MapEntry(allMedicines['ME000016']!, 14),
          MapEntry(allMedicines['ME000004']!, 8),
          MapEntry(allMedicines['ME000014']!, 9),
          MapEntry(allMedicines['ME000007']!, 8),
          MapEntry(allMedicines['ME000011']!, 9),
        ],
        doctorID: 'DT000010',
        patientID: 'DT000010',
      ),
  ],
  DateTime.now().add(const Duration(days: -12)): [
    Appoinment(
      appoinmentID: 'CH000011',
      doctorID: 'DT000011',
      patientID: 'BN000011',
      dateTime: DateTime.now().add(const Duration(days: -12)),
      hasPass: DateTime.now().add(const Duration(days: -12)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000005']!, 1),
        ],
        doctorID: 'DT000011',
        patientID: 'DT000011',
      ),
    Appoinment(
      appoinmentID: 'CH000012',
      doctorID: 'DT000012',
      patientID: 'BN000012',
      dateTime: DateTime.now().add(const Duration(days: -12)),
      hasPass: DateTime.now().add(const Duration(days: -12)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000004']!, 13),
          MapEntry(allMedicines['ME000015']!, 12),
          MapEntry(allMedicines['ME000008']!, 1),
          MapEntry(allMedicines['ME000004']!, 14),
          MapEntry(allMedicines['ME000006']!, 4),
          MapEntry(allMedicines['ME000010']!, 14),
        ],
        doctorID: 'DT000012',
        patientID: 'DT000012',
      ),
  ],
  DateTime.now().add(const Duration(days: -11)): [
    Appoinment(
      appoinmentID: 'CH000013',
      doctorID: 'DT000013',
      patientID: 'BN000013',
      dateTime: DateTime.now().add(const Duration(days: -11)),
      hasPass: DateTime.now().add(const Duration(days: -11)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000013',
        patientID: 'DT000013',
      ),
  ],
  DateTime.now().add(const Duration(days: -10)): [
    Appoinment(
      appoinmentID: 'CH000014',
      doctorID: 'DT000014',
      patientID: 'BN000014',
      dateTime: DateTime.now().add(const Duration(days: -10)),
      hasPass: DateTime.now().add(const Duration(days: -10)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000014',
        patientID: 'DT000014',
      ),
    Appoinment(
      appoinmentID: 'CH000015',
      doctorID: 'DT000015',
      patientID: 'BN000015',
      dateTime: DateTime.now().add(const Duration(days: -10)),
      hasPass: DateTime.now().add(const Duration(days: -10)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000018']!, 3),
          MapEntry(allMedicines['ME000017']!, 12),
          MapEntry(allMedicines['ME000007']!, 5),
        ],
        doctorID: 'DT000015',
        patientID: 'DT000015',
      ),
  ],
  DateTime.now().add(const Duration(days: -8)): [
    Appoinment(
      appoinmentID: 'CH000016',
      doctorID: 'DT000016',
      patientID: 'BN000016',
      dateTime: DateTime.now().add(const Duration(days: -8)),
      hasPass: DateTime.now().add(const Duration(days: -8)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000003']!, 6),
          MapEntry(allMedicines['ME000001']!, 2),
          MapEntry(allMedicines['ME000018']!, 12),
        ],
        doctorID: 'DT000016',
        patientID: 'DT000016',
      ),
    Appoinment(
      appoinmentID: 'CH000017',
      doctorID: 'DT000017',
      patientID: 'BN000017',
      dateTime: DateTime.now().add(const Duration(days: -8)),
      hasPass: DateTime.now().add(const Duration(days: -8)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000016']!, 2),
        ],
        doctorID: 'DT000017',
        patientID: 'DT000017',
      ),
  ],
  DateTime.now().add(const Duration(days: -7)): [
    Appoinment(
      appoinmentID: 'CH000018',
      doctorID: 'DT000018',
      patientID: 'BN000018',
      dateTime: DateTime.now().add(const Duration(days: -7)),
      hasPass: DateTime.now().add(const Duration(days: -7)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000009']!, 8),
        ],
        doctorID: 'DT000018',
        patientID: 'DT000018',
      ),
    Appoinment(
      appoinmentID: 'CH000019',
      doctorID: 'DT000019',
      patientID: 'BN000019',
      dateTime: DateTime.now().add(const Duration(days: -7)),
      hasPass: DateTime.now().add(const Duration(days: -7)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000008']!, 4),
        ],
        doctorID: 'DT000019',
        patientID: 'DT000019',
      ),
    Appoinment(
      appoinmentID: 'CH000020',
      doctorID: 'DT000020',
      patientID: 'BN000020',
      dateTime: DateTime.now().add(const Duration(days: -7)),
      hasPass: DateTime.now().add(const Duration(days: -7)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000003']!, 4),
          MapEntry(allMedicines['ME000002']!, 13),
          MapEntry(allMedicines['ME000003']!, 12),
        ],
        doctorID: 'DT000020',
        patientID: 'DT000020',
      ),
  ],
  DateTime.now().add(const Duration(days: -5)): [
    Appoinment(
      appoinmentID: 'CH000021',
      doctorID: 'DT000021',
      patientID: 'BN000021',
      dateTime: DateTime.now().add(const Duration(days: -5)),
      hasPass: DateTime.now().add(const Duration(days: -5)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000021',
        patientID: 'DT000021',
      ),
    Appoinment(
      appoinmentID: 'CH000022',
      doctorID: 'DT000022',
      patientID: 'BN000022',
      dateTime: DateTime.now().add(const Duration(days: -5)),
      hasPass: DateTime.now().add(const Duration(days: -5)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000013']!, 4),
        ],
        doctorID: 'DT000022',
        patientID: 'DT000022',
      ),
    Appoinment(
      appoinmentID: 'CH000023',
      doctorID: 'DT000023',
      patientID: 'BN000023',
      dateTime: DateTime.now().add(const Duration(days: -5)),
      hasPass: DateTime.now().add(const Duration(days: -5)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000020']!, 11),
          MapEntry(allMedicines['ME000017']!, 12),
          MapEntry(allMedicines['ME000020']!, 9),
          MapEntry(allMedicines['ME000003']!, 6),
          MapEntry(allMedicines['ME000002']!, 10),
          MapEntry(allMedicines['ME000020']!, 13),
        ],
        doctorID: 'DT000023',
        patientID: 'DT000023',
      ),
  ],
  DateTime.now().add(const Duration(days: -2)): [
    Appoinment(
      appoinmentID: 'CH000024',
      doctorID: 'DT000024',
      patientID: 'BN000024',
      dateTime: DateTime.now().add(const Duration(days: -2)),
      hasPass: DateTime.now().add(const Duration(days: -2)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000014']!, 11),
          MapEntry(allMedicines['ME000007']!, 4),
          MapEntry(allMedicines['ME000010']!, 5),
        ],
        doctorID: 'DT000024',
        patientID: 'DT000024',
      ),
    Appoinment(
      appoinmentID: 'CH000025',
      doctorID: 'DT000025',
      patientID: 'BN000025',
      dateTime: DateTime.now().add(const Duration(days: -2)),
      hasPass: DateTime.now().add(const Duration(days: -2)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000018']!, 13),
          MapEntry(allMedicines['ME000002']!, 11),
          MapEntry(allMedicines['ME000018']!, 10),
        ],
        doctorID: 'DT000025',
        patientID: 'DT000025',
      ),
    Appoinment(
      appoinmentID: 'CH000026',
      doctorID: 'DT000026',
      patientID: 'BN000026',
      dateTime: DateTime.now().add(const Duration(days: -2)),
      hasPass: DateTime.now().add(const Duration(days: -2)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000026',
        patientID: 'DT000026',
      ),
  ],
  DateTime.now().add(const Duration(days: -1)): [
    Appoinment(
      appoinmentID: 'CH000027',
      doctorID: 'DT000027',
      patientID: 'BN000027',
      dateTime: DateTime.now().add(const Duration(days: -1)),
      hasPass: DateTime.now().add(const Duration(days: -1)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000017']!, 1),
          MapEntry(allMedicines['ME000010']!, 8),
          MapEntry(allMedicines['ME000015']!, 11),
        ],
        doctorID: 'DT000027',
        patientID: 'DT000027',
      ),
    Appoinment(
      appoinmentID: 'CH000028',
      doctorID: 'DT000028',
      patientID: 'BN000028',
      dateTime: DateTime.now().add(const Duration(days: -1)),
      hasPass: DateTime.now().add(const Duration(days: -1)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000020']!, 10),
        ],
        doctorID: 'DT000028',
        patientID: 'DT000028',
      ),
    Appoinment(
      appoinmentID: 'CH000029',
      doctorID: 'DT000029',
      patientID: 'BN000029',
      dateTime: DateTime.now().add(const Duration(days: -1)),
      hasPass: DateTime.now().add(const Duration(days: -1)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000003']!, 9),
        ],
        doctorID: 'DT000029',
        patientID: 'DT000029',
      ),
  ],
  DateTime.now().add(const Duration(days: 1)): [
    Appoinment(
      appoinmentID: 'CH000030',
      doctorID: 'DT000030',
      patientID: 'BN000030',
      dateTime: DateTime.now().add(const Duration(days: 1)),
      hasPass: DateTime.now().add(const Duration(days: 1)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000008']!, 5),
          MapEntry(allMedicines['ME000017']!, 14),
          MapEntry(allMedicines['ME000001']!, 1),
          MapEntry(allMedicines['ME000005']!, 3),
          MapEntry(allMedicines['ME000020']!, 9),
          MapEntry(allMedicines['ME000011']!, 7),
          MapEntry(allMedicines['ME000017']!, 3),
          MapEntry(allMedicines['ME000014']!, 14),
          MapEntry(allMedicines['ME000014']!, 6),
          MapEntry(allMedicines['ME000010']!, 13),
        ],
        doctorID: 'DT000030',
        patientID: 'DT000030',
      ),
  ],
  DateTime.now().add(const Duration(days: 3)): [
    Appoinment(
      appoinmentID: 'CH000031',
      doctorID: 'DT000031',
      patientID: 'BN000031',
      dateTime: DateTime.now().add(const Duration(days: 3)),
      hasPass: DateTime.now().add(const Duration(days: 3)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000031',
        patientID: 'DT000031',
      ),
    Appoinment(
      appoinmentID: 'CH000032',
      doctorID: 'DT000032',
      patientID: 'BN000032',
      dateTime: DateTime.now().add(const Duration(days: 3)),
      hasPass: DateTime.now().add(const Duration(days: 3)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000032',
        patientID: 'DT000032',
      ),
    Appoinment(
      appoinmentID: 'CH000033',
      doctorID: 'DT000033',
      patientID: 'BN000033',
      dateTime: DateTime.now().add(const Duration(days: 3)),
      hasPass: DateTime.now().add(const Duration(days: 3)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000016']!, 12),
          MapEntry(allMedicines['ME000009']!, 7),
          MapEntry(allMedicines['ME000020']!, 1),
          MapEntry(allMedicines['ME000015']!, 11),
          MapEntry(allMedicines['ME000015']!, 11),
          MapEntry(allMedicines['ME000009']!, 11),
        ],
        doctorID: 'DT000033',
        patientID: 'DT000033',
      ),
  ],
  DateTime.now().add(const Duration(days: 5)): [
    Appoinment(
      appoinmentID: 'CH000034',
      doctorID: 'DT000034',
      patientID: 'BN000034',
      dateTime: DateTime.now().add(const Duration(days: 5)),
      hasPass: DateTime.now().add(const Duration(days: 5)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000007']!, 5),
          MapEntry(allMedicines['ME000006']!, 8),
          MapEntry(allMedicines['ME000004']!, 9),
        ],
        doctorID: 'DT000034',
        patientID: 'DT000034',
      ),
    Appoinment(
      appoinmentID: 'CH000035',
      doctorID: 'DT000035',
      patientID: 'BN000035',
      dateTime: DateTime.now().add(const Duration(days: 5)),
      hasPass: DateTime.now().add(const Duration(days: 5)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000003']!, 6),
        ],
        doctorID: 'DT000035',
        patientID: 'DT000035',
      ),
    Appoinment(
      appoinmentID: 'CH000036',
      doctorID: 'DT000036',
      patientID: 'BN000036',
      dateTime: DateTime.now().add(const Duration(days: 5)),
      hasPass: DateTime.now().add(const Duration(days: 5)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000015']!, 3),
        ],
        doctorID: 'DT000036',
        patientID: 'DT000036',
      ),
    Appoinment(
      appoinmentID: 'CH000037',
      doctorID: 'DT000037',
      patientID: 'BN000037',
      dateTime: DateTime.now().add(const Duration(days: 5)),
      hasPass: DateTime.now().add(const Duration(days: 5)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000037',
        patientID: 'DT000037',
      ),
  ],
  DateTime.now().add(const Duration(days: 6)): [
    Appoinment(
      appoinmentID: 'CH000038',
      doctorID: 'DT000038',
      patientID: 'BN000038',
      dateTime: DateTime.now().add(const Duration(days: 6)),
      hasPass: DateTime.now().add(const Duration(days: 6)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000010']!, 11),
          MapEntry(allMedicines['ME000015']!, 7),
          MapEntry(allMedicines['ME000020']!, 3),
        ],
        doctorID: 'DT000038',
        patientID: 'DT000038',
      ),
  ],
  DateTime.now().add(const Duration(days: 8)): [
    Appoinment(
      appoinmentID: 'CH000039',
      doctorID: 'DT000039',
      patientID: 'BN000039',
      dateTime: DateTime.now().add(const Duration(days: 8)),
      hasPass: DateTime.now().add(const Duration(days: 8)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000039',
        patientID: 'DT000039',
      ),
    Appoinment(
      appoinmentID: 'CH000040',
      doctorID: 'DT000040',
      patientID: 'BN000040',
      dateTime: DateTime.now().add(const Duration(days: 8)),
      hasPass: DateTime.now().add(const Duration(days: 8)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000012']!, 4),
          MapEntry(allMedicines['ME000019']!, 7),
          MapEntry(allMedicines['ME000019']!, 10),
          MapEntry(allMedicines['ME000016']!, 12),
          MapEntry(allMedicines['ME000004']!, 8),
          MapEntry(allMedicines['ME000011']!, 7),
        ],
        doctorID: 'DT000040',
        patientID: 'DT000040',
      ),
  ],
  DateTime.now().add(const Duration(days: 9)): [
    Appoinment(
      appoinmentID: 'CH000041',
      doctorID: 'DT000041',
      patientID: 'BN000041',
      dateTime: DateTime.now().add(const Duration(days: 9)),
      hasPass: DateTime.now().add(const Duration(days: 9)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000005']!, 3),
          MapEntry(allMedicines['ME000010']!, 6),
          MapEntry(allMedicines['ME000008']!, 12),
          MapEntry(allMedicines['ME000002']!, 2),
          MapEntry(allMedicines['ME000016']!, 6),
          MapEntry(allMedicines['ME000010']!, 14),
          MapEntry(allMedicines['ME000007']!, 11),
          MapEntry(allMedicines['ME000003']!, 2),
          MapEntry(allMedicines['ME000012']!, 13),
          MapEntry(allMedicines['ME000002']!, 11),
        ],
        doctorID: 'DT000041',
        patientID: 'DT000041',
      ),
    Appoinment(
      appoinmentID: 'CH000042',
      doctorID: 'DT000042',
      patientID: 'BN000042',
      dateTime: DateTime.now().add(const Duration(days: 9)),
      hasPass: DateTime.now().add(const Duration(days: 9)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000008']!, 4),
          MapEntry(allMedicines['ME000010']!, 13),
          MapEntry(allMedicines['ME000011']!, 9),
        ],
        doctorID: 'DT000042',
        patientID: 'DT000042',
      ),
    Appoinment(
      appoinmentID: 'CH000043',
      doctorID: 'DT000043',
      patientID: 'BN000043',
      dateTime: DateTime.now().add(const Duration(days: 9)),
      hasPass: DateTime.now().add(const Duration(days: 9)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000013']!, 6),
        ],
        doctorID: 'DT000043',
        patientID: 'DT000043',
      ),
  ],
  DateTime.now().add(const Duration(days: 11)): [
    Appoinment(
      appoinmentID: 'CH000044',
      doctorID: 'DT000044',
      patientID: 'BN000044',
      dateTime: DateTime.now().add(const Duration(days: 11)),
      hasPass: DateTime.now().add(const Duration(days: 11)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000019']!, 4),
        ],
        doctorID: 'DT000044',
        patientID: 'DT000044',
      ),
    Appoinment(
      appoinmentID: 'CH000045',
      doctorID: 'DT000045',
      patientID: 'BN000045',
      dateTime: DateTime.now().add(const Duration(days: 11)),
      hasPass: DateTime.now().add(const Duration(days: 11)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000015']!, 4),
          MapEntry(allMedicines['ME000004']!, 14),
          MapEntry(allMedicines['ME000018']!, 12),
        ],
        doctorID: 'DT000045',
        patientID: 'DT000045',
      ),
    Appoinment(
      appoinmentID: 'CH000046',
      doctorID: 'DT000046',
      patientID: 'BN000046',
      dateTime: DateTime.now().add(const Duration(days: 11)),
      hasPass: DateTime.now().add(const Duration(days: 11)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000007']!, 8),
          MapEntry(allMedicines['ME000017']!, 9),
          MapEntry(allMedicines['ME000017']!, 11),
          MapEntry(allMedicines['ME000017']!, 2),
          MapEntry(allMedicines['ME000019']!, 13),
          MapEntry(allMedicines['ME000018']!, 1),
        ],
        doctorID: 'DT000046',
        patientID: 'DT000046',
      ),
    Appoinment(
      appoinmentID: 'CH000047',
      doctorID: 'DT000047',
      patientID: 'BN000047',
      dateTime: DateTime.now().add(const Duration(days: 11)),
      hasPass: DateTime.now().add(const Duration(days: 11)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000020']!, 6),
          MapEntry(allMedicines['ME000012']!, 11),
          MapEntry(allMedicines['ME000017']!, 5),
        ],
        doctorID: 'DT000047',
        patientID: 'DT000047',
      ),
  ],
  DateTime.now().add(const Duration(days: 12)): [
    Appoinment(
      appoinmentID: 'CH000048',
      doctorID: 'DT000048',
      patientID: 'BN000048',
      dateTime: DateTime.now().add(const Duration(days: 12)),
      hasPass: DateTime.now().add(const Duration(days: 12)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000048',
        patientID: 'DT000048',
      ),
    Appoinment(
      appoinmentID: 'CH000049',
      doctorID: 'DT000049',
      patientID: 'BN000049',
      dateTime: DateTime.now().add(const Duration(days: 12)),
      hasPass: DateTime.now().add(const Duration(days: 12)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000049',
        patientID: 'DT000049',
      ),
    Appoinment(
      appoinmentID: 'CH000050',
      doctorID: 'DT000050',
      patientID: 'BN000050',
      dateTime: DateTime.now().add(const Duration(days: 12)),
      hasPass: DateTime.now().add(const Duration(days: 12)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000012']!, 14),
          MapEntry(allMedicines['ME000016']!, 5),
          MapEntry(allMedicines['ME000009']!, 2),
          MapEntry(allMedicines['ME000001']!, 10),
          MapEntry(allMedicines['ME000018']!, 5),
          MapEntry(allMedicines['ME000004']!, 14),
        ],
        doctorID: 'DT000050',
        patientID: 'DT000050',
      ),
    Appoinment(
      appoinmentID: 'CH000051',
      doctorID: 'DT000051',
      patientID: 'BN000051',
      dateTime: DateTime.now().add(const Duration(days: 12)),
      hasPass: DateTime.now().add(const Duration(days: 12)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000014']!, 4),
          MapEntry(allMedicines['ME000001']!, 5),
          MapEntry(allMedicines['ME000004']!, 4),
          MapEntry(allMedicines['ME000019']!, 2),
          MapEntry(allMedicines['ME000002']!, 3),
          MapEntry(allMedicines['ME000008']!, 11),
        ],
        doctorID: 'DT000051',
        patientID: 'DT000051',
      ),
  ],
  DateTime.now().add(const Duration(days: 14)): [
    Appoinment(
      appoinmentID: 'CH000052',
      doctorID: 'DT000052',
      patientID: 'BN000052',
      dateTime: DateTime.now().add(const Duration(days: 14)),
      hasPass: DateTime.now().add(const Duration(days: 14)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000017']!, 13),
          MapEntry(allMedicines['ME000010']!, 11),
          MapEntry(allMedicines['ME000003']!, 13),
          MapEntry(allMedicines['ME000013']!, 13),
          MapEntry(allMedicines['ME000010']!, 3),
          MapEntry(allMedicines['ME000007']!, 10),
          MapEntry(allMedicines['ME000020']!, 3),
          MapEntry(allMedicines['ME000016']!, 5),
          MapEntry(allMedicines['ME000013']!, 6),
          MapEntry(allMedicines['ME000005']!, 7),
        ],
        doctorID: 'DT000052',
        patientID: 'DT000052',
      ),
    Appoinment(
      appoinmentID: 'CH000053',
      doctorID: 'DT000053',
      patientID: 'BN000053',
      dateTime: DateTime.now().add(const Duration(days: 14)),
      hasPass: DateTime.now().add(const Duration(days: 14)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000004']!, 2),
          MapEntry(allMedicines['ME000011']!, 2),
          MapEntry(allMedicines['ME000020']!, 7),
          MapEntry(allMedicines['ME000019']!, 8),
          MapEntry(allMedicines['ME000013']!, 12),
          MapEntry(allMedicines['ME000013']!, 7),
          MapEntry(allMedicines['ME000019']!, 6),
          MapEntry(allMedicines['ME000016']!, 5),
          MapEntry(allMedicines['ME000009']!, 12),
          MapEntry(allMedicines['ME000009']!, 12),
        ],
        doctorID: 'DT000053',
        patientID: 'DT000053',
      ),
    Appoinment(
      appoinmentID: 'CH000054',
      doctorID: 'DT000054',
      patientID: 'BN000054',
      dateTime: DateTime.now().add(const Duration(days: 14)),
      hasPass: DateTime.now().add(const Duration(days: 14)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000054',
        patientID: 'DT000054',
      ),
  ],
  DateTime.now().add(const Duration(days: 15)): [
    Appoinment(
      appoinmentID: 'CH000055',
      doctorID: 'DT000055',
      patientID: 'BN000055',
      dateTime: DateTime.now().add(const Duration(days: 15)),
      hasPass: DateTime.now().add(const Duration(days: 15)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
        ],
        doctorID: 'DT000055',
        patientID: 'DT000055',
      ),
    Appoinment(
      appoinmentID: 'CH000056',
      doctorID: 'DT000056',
      patientID: 'BN000056',
      dateTime: DateTime.now().add(const Duration(days: 15)),
      hasPass: DateTime.now().add(const Duration(days: 15)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000020']!, 3),
          MapEntry(allMedicines['ME000011']!, 8),
          MapEntry(allMedicines['ME000001']!, 7),
          MapEntry(allMedicines['ME000019']!, 11),
          MapEntry(allMedicines['ME000013']!, 8),
          MapEntry(allMedicines['ME000010']!, 11),
        ],
        doctorID: 'DT000056',
        patientID: 'DT000056',
      ),
    Appoinment(
      appoinmentID: 'CH000057',
      doctorID: 'DT000057',
      patientID: 'BN000057',
      dateTime: DateTime.now().add(const Duration(days: 15)),
      hasPass: DateTime.now().add(const Duration(days: 15)).isBefore(DateTime.now()),
    )..payedBill = Bill(
        medicinePairs: [
          MapEntry(allMedicines['ME000014']!, 9),
          MapEntry(allMedicines['ME000008']!, 6),
          MapEntry(allMedicines['ME000009']!, 3),
          MapEntry(allMedicines['ME000015']!, 6),
          MapEntry(allMedicines['ME000001']!, 7),
          MapEntry(allMedicines['ME000011']!, 13),
        ],
        doctorID: 'DT000057',
        patientID: 'DT000057',
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