// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'package:beginapp01/OOP_material/appoinment.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example appointments map.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kAppointments = LinkedHashMap<DateTime, List<Appoinment>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll({
  DateTime(2024,11,29) : [
    Appoinment(
      appoinmentID: 'CH000000',
      doctorID: 'DT000000',
      patientID: 'BN000000',
      dateTime: DateTime(2024,11,29),
    ),
    Appoinment(
      appoinmentID: 'CH000001',
      doctorID: 'DT000001',
      patientID: 'BN000001',
      dateTime: DateTime(2024,11,29),
    ),
    Appoinment(
      appoinmentID: 'CH000002',
      doctorID: 'DT000002',
      patientID: 'BN000002',
      dateTime: DateTime(2024,11,29),
    ),
    Appoinment(
      appoinmentID: 'CH000003',
      doctorID: 'DT000003',
      patientID: 'BN000003',
      dateTime: DateTime(2024,11,29),
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
