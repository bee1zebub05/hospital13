// hospital_inventory.dart

import 'package:beginapp01/OOP_material/medicine.dart';

Map<String, Medicine> allMedicines = {}; // Tạo map toàn cục lưu trữ thuốc

// Tạo ID thuốc mới
String generateMedicineID() {
  int idNumber = 1;
  String newID = 'ME${idNumber.toString().padLeft(6, '0')}';

  // Kiểm tra ID thuốc trong map, nếu có thì tăng ID lên
  while (allMedicines.containsKey(newID)) {
    idNumber++;
    newID = 'ME${idNumber.toString().padLeft(6, '0')}';
  }

  return newID;
}

// Hàm thêm thuốc vào map
void addMedicine(Medicine medicine) {
  allMedicines[medicine.medicineID] = medicine;
}

// Hàm xóa thuốc khỏi map
void deleteMedicine(String medicineID) {
  allMedicines.remove(medicineID);
}
