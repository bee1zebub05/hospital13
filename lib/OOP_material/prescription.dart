import 'medicine.dart';

class Prescription {
  String _prescriptionID;
  DateTime _dateTime;
  String _doctorID;
  double _totalCost;
  List<Medicine> _medicines;

  // Constructor
  Prescription({
    String prescriptionID = "",
    DateTime? dateTime, 
    String doctorID = "",
    double totalCost = 0.0,
    List<Medicine>? medicines, 
  })  : _prescriptionID = prescriptionID,
        _dateTime = dateTime ?? DateTime.now(), 
        _doctorID = doctorID,
        _totalCost = totalCost,
        _medicines = medicines ?? [];

  DateTime get dateTime => _dateTime;
  set dateTime(DateTime value) => _dateTime = value;

  String get prescriptionID => _prescriptionID;
  set prescriptionID(String value) => _prescriptionID = value;

  String get doctorID => _doctorID;
  set doctorID(String value) => _doctorID = value;

  double get totalCost => _totalCost;
  set totalCost(double value) {
    if (value >= 0) {
      _totalCost = value;
    } else {
      throw ArgumentError('Total cost must be non-negative');
    }
  }

  List<Medicine> get medicines => _medicines;
  set medicines(List<Medicine> value) => _medicines = value;
}
