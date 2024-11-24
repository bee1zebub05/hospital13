import 'package:beginapp01/OOP_material/person.dart';

import 'worker.dart';

class Doctor extends Worker {
  String _speciality;
  Doctor({
    super.firstName,
    super.lastName,
    super.age,
    super.gender,
    super.phone,
    super.address,
    super.IDWorker,
    super.salary,
    String speciality = "",
  }) : _speciality = speciality;
  String get speciality => _speciality;
  set speciality(String value) => _speciality = value;
}

Map<String,Doctor> allDoctors ={
'HSCC0001' : Doctor(
    firstName: 'Nguyên',
    lastName: 'Lê',
    age: 18,
    gender: GenderEnum.male,
    phone: '0935927732',
    address: 'Đà Nẵng',
    IDWorker: 'HSCC0001',
    salary: 100.0,
    speciality: 'Hồi sức cấp cứu',
  ),
  'DT000000' : Doctor(
    firstName: 'Quân',
    lastName: 'Bùi Xuân',
    age: 25,
    gender: GenderEnum.female,
    phone: '0836327583',
    address: 'Buôn Ma Thuột',
    IDWorker: 'DT000000',
    salary: 31,
    speciality: 'Tiêu hóa',
),
  'DT000001' : Doctor(
    firstName: 'Thúy Vân',
    lastName: 'Võ',
    age: 24,
    gender: GenderEnum.male,
    phone: '0752238049',
    address: 'Tây Ninh',
    IDWorker: 'DT000001',
    salary: 18,
    speciality: 'Tâm thần',
),
  'DT000002' : Doctor(
    firstName: 'Văn Cường',
    lastName: 'Cung',
    age: 48,
    gender: GenderEnum.other,
    phone: '0831461498',
    address: 'Hòa Bình',
    IDWorker: 'DT000002',
    salary: 17,
    speciality: 'Nội tổng quát',
),
  'DT000003' : Doctor(
    firstName: 'Em',
    lastName: 'Lạc',
    age: 56,
    gender: GenderEnum.other,
    phone: '0903991895',
    address: 'Hà Giang',
    IDWorker: 'DT000003',
    salary: 18,
    speciality: 'Tâm thần',
),
  'DT000004' : Doctor(
    firstName: 'Trọng Tín',
    lastName: 'Chung',
    age: 42,
    gender: GenderEnum.female,
    phone: '0754074544',
    address: 'Bến Tre',
    IDWorker: 'DT000004',
    salary: 20,
    speciality: 'Nội soi phẫu thuật thẩm mỹ',
),
  'DT000005' : Doctor(
    firstName: 'Trường Sơn',
    lastName: 'Thạch',
    age: 52,
    gender: GenderEnum.female,
    phone: '0940430825',
    address: 'Tam Điệp',
    IDWorker: 'DT000005',
    salary: 19,
    speciality: 'Y học lao động',
),
  'DT000006' : Doctor(
    firstName: 'Tuấn Minh',
    lastName: 'Hàn',
    age: 36,
    gender: GenderEnum.male,
    phone: '0983846473',
    address: 'Kon Tum',
    IDWorker: 'DT000006',
    salary: 27,
    speciality: 'Nội tiết',
),
  'DT000007' : Doctor(
    firstName: 'Hiền',
    lastName: 'Kiều',
    age: 36,
    gender: GenderEnum.other,
    phone: '0883348586',
    address: 'Vũng Tàu',
    IDWorker: 'DT000007',
    salary: 28,
    speciality: 'Chẩn đoán hình ảnh',
),
  'DT000008' : Doctor(
    firstName: 'Văn Cường',
    lastName: 'Bảo',
    age: 45,
    gender: GenderEnum.male,
    phone: '0867223366',
    address: 'Sơn La',
    IDWorker: 'DT000008',
    salary: 18,
    speciality: 'Nội soi phụ khoa',
),
  'DT000009' : Doctor(
    firstName: 'Châu',
    lastName: 'Mã',
    age: 19,
    gender: GenderEnum.other,
    phone: '0866035255',
    address: 'Tam Kỳ',
    IDWorker: 'DT000009',
    salary: 12,
    speciality: 'Huyết học',
),
};