import 'medicine.dart';

class MedicineNotFoundException implements Exception {}

class InsufficientMedicineQuantityException implements Exception {}

class HospitalInventory {
  final List<Medicine> medicines;

  HospitalInventory({required this.medicines});

  Medicine findMedicine(String medicineID) {
    return medicines.firstWhere(
      (medicine) => medicine.medicineID == medicineID,
      orElse: () => throw MedicineNotFoundException(),
    );
  }

  void reduceMedicineQuantity(String medicineID, int quantity) {
    Medicine medicine = findMedicine(medicineID);
    if (medicine.quantity < quantity) {
      throw InsufficientMedicineQuantityException();
    }
    medicine.quantity -= quantity;
  }

  void increaseMedicineQuantity(String medicineID, int quantity) {
    Medicine medicine = findMedicine(medicineID);
    medicine.quantity += quantity;
  }
}

HospitalInventory hospitalInventory = HospitalInventory(
  medicines: [
    Medicine(
      medicineID: 'T001',
      medicineName: 'Paracetamol',
      unit: 1,
      status: true,
      quantity: 100,
      price: 20000,
      description: 'Thuốc giảm đau',
    ),
    Medicine(
      medicineID: 'T002',
      medicineName: 'Aspirin',
      unit: 1,
      status: true,
      quantity: 50,
      price: 30000,
      description: 'Thuốc giảm đau và kháng viêm',
    ),
    Medicine(
      medicineID: 'T003',
      medicineName: 'Vitamin C',
      unit: 1,
      status: true,
      quantity: 200,
      price: 15000,
      description: 'Vitamin bổ sung sức đề kháng',
    ),
  ],
);
