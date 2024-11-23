import 'doctor.dart';
import 'patient.dart';
import 'prescription.dart';

class MedicalRecord {
  Doctor _doctor;
  Patient _patient;
  List<Prescription> _listOfPrescriptions;

  // Constructor
  MedicalRecord({
    Doctor? doctor, 
    Patient? patient, 
    List<Prescription>? listOfPrescriptions,
  })  : _doctor = doctor ?? Doctor(), 
        _patient = patient ?? Patient(), 
        _listOfPrescriptions = listOfPrescriptions ?? [];

  Doctor get doctor => _doctor;
  set doctor(Doctor value) => _doctor = value;

  Patient get patient => _patient;
  set patient(Patient value) => _patient = value;

  List<Prescription> get listOfPrescriptions => _listOfPrescriptions;
  set listOfPrescriptions(List<Prescription> value) => _listOfPrescriptions = value;

  void addPrescription(Prescription prescription) {
    _listOfPrescriptions.add(prescription);
  }

}
