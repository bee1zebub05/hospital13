// hospital_inventory.dart

import 'package:beginapp01/OOP_material/medicine.dart';

Map<String, Medicine> allMedicines = {
  'ME000001': Medicine(
    medicineID: 'ME000001',
    medicineName: 'Paracetamol',
    unit: 1, // solid
    status: true,
    quantity: 10000,
    price: 1500,
    description: 'Thuốc giảm đau, hạ sốt.',
  ),
  'ME000002': Medicine(
    medicineID: 'ME000002',
    medicineName: 'Ibuprofen',
    unit: 1, // solid
    status: true,
    quantity: 20000,
    price: 2000,
    description: 'Thuốc giảm đau, chống viêm.',
  ),
  'ME000003': Medicine(
    medicineID: 'ME000003',
    medicineName: 'Aspirin',
    unit: 1, // solid
    status: true,
    quantity: 123200,
    price: 1800,
    description: 'Thuốc giảm đau, chống viêm.',
  ),
  'ME000004': Medicine(
    medicineID: 'ME000004',
    medicineName: 'Amoxicillin',
    unit: 1, // solid
    status: true,
    quantity: 300000,
    price: 2500,
    description: 'Kháng sinh điều trị nhiễm trùng.',
  ),
  'ME000005': Medicine(
    medicineID: 'ME000005',
    medicineName: 'Cetirizine',
    unit: 1, // solid
    status: true,
    quantity: 100000,
    price: 1200,
    description: 'Thuốc dị ứng, chống ngứa.',
  ),
  'ME000006': Medicine(
    medicineID: 'ME000006',
    medicineName: 'Naproxen',
    unit: 1, // solid
    status: true,
    quantity: 100000,
    price: 2200,
    description: 'Thuốc giảm đau, chống viêm.',
  ),
  'ME000007': Medicine(
    medicineID: 'ME000007',
    medicineName: 'Salbutamol',
    unit: 0, // liquid
    status: true,
    quantity: 30000,
    price: 5000,
    description: 'Thuốc chữa bệnh hen suyễn.',
  ),
  'ME000008': Medicine(
    medicineID: 'ME000008',
    medicineName: 'Diphenhydramine',
    unit: 0, // liquid
    status: true,
    quantity: 100000,
    price: 1400,
    description: 'Thuốc chống dị ứng, an thần.',
  ),
  'ME000009': Medicine(
    medicineID: 'ME000009',
    medicineName: 'Loratadine',
    unit: 0, // liquid
    status: true,
    quantity: 932000,
    price: 1600,
    description: 'Thuốc trị dị ứng, hắt hơi, sổ mũi.',
  ),
  'ME000010': Medicine(
    medicineID: 'ME000010',
    medicineName: 'Hydrocodone',
    unit: 1, // solid
    status: true,
    quantity: 1230000,
    price: 8000,
    description: 'Thuốc giảm đau mạnh.',
  ),
  'ME000011': Medicine(
    medicineID: 'ME000011',
    medicineName: 'Codeine',
    unit: 1, // solid
    status: true,
    quantity: 120000,
    price: 4000,
    description: 'Thuốc giảm ho, giảm đau.',
  ),
  'ME000012': Medicine(
    medicineID: 'ME000012',
    medicineName: 'Metformin',
    unit: 1, // solid
    status: true,
    quantity: 100000,
    price: 3000,
    description: 'Thuốc điều trị tiểu đường type 2.',
  ),
  'ME000013': Medicine(
    medicineID: 'ME000013',
    medicineName: 'Insulin',
    unit: 0, // liquid
    status: true,
    quantity: 912000,
    price: 5000,
    description: 'Thuốc điều trị tiểu đường type 1.',
  ),
  'ME000014': Medicine(
    medicineID: 'ME000014',
    medicineName: 'Omeprazole',
    unit: 1, // solid
    status: true,
    quantity: 12000,
    price: 2500,
    description: 'Thuốc giảm axit dạ dày.',
  ),
  'ME000015': Medicine(
    medicineID: 'ME000015',
    medicineName: 'Levothyroxine',
    unit: 1, // solid
    status: true,
    quantity: 1003000,
    price: 2200,
    description: 'Thuốc điều trị suy giáp.',
  ),
  'ME000016': Medicine(
    medicineID: 'ME000016',
    medicineName: 'Diazepam',
    unit: 1, // solid
    status: true,
    quantity: 100000,
    price: 2800,
    description: 'Thuốc an thần, trị lo âu.',
  ),
  'ME000017': Medicine(
    medicineID: 'ME000017',
    medicineName: 'Ciprofloxacin',
    unit: 1, // solid
    status: true,
    quantity: 600000,
    price: 2700,
    description: 'Kháng sinh, điều trị nhiễm trùng.',
  ),
  'ME000018': Medicine(
    medicineID: 'ME000018',
    medicineName: 'Furosemide',
    unit: 0, // liquid
    status: true,
    quantity: 290000,
    price: 3000,
    description: 'Thuốc lợi tiểu, trị huyết áp cao.',
  ),
  'ME000019': Medicine(
    medicineID: 'ME000019',
    medicineName: 'Captopril',
    unit: 1, // solid
    status: true,
    quantity: 100000,
    price: 2500,
    description: 'Thuốc hạ huyết áp.',
  ),
  'ME000020': Medicine(
    medicineID: 'ME000020',
    medicineName: 'Losartan',
    unit: 1, // solid
    status: true,
    quantity: 100000,
    price: 3300,
    description: 'Thuốc điều trị huyết áp cao.',
  ),
};
 // Tạo map toàn cục lưu trữ thuốc

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