import 'package:beginapp01/OOP_material/appoinment.dart';
import 'person.dart';

class Patient extends Person {
  //Mỗi một bệnh nhân có thể đã hoặc chưa có 1 hồ sơ bệnh án
  List <Appoinment>? medicalRecord;
  String _patientID;
  Patient({
    super.firstName,
    super.lastName,
    super.age,
    super.gender,
    super.phone,
    super.address,
    String patientID = "",
  }) : _patientID = patientID;
  String get patientID => _patientID;
  set patientID(String value) => _patientID = value;
}

Map<String,Patient> allPatient = {
  'BN000000' : Patient(
    firstName: 'Văn Thành',
    lastName: 'Biện',
    age: 20,
    gender: GenderEnum.male,
    phone: '0906629159',
    address: 'Tây Ninh',
    patientID: 'BN000000',
),
  'BN000001' : Patient(
    firstName: 'Em',
    lastName: 'Đậu',
    age: 43,
    gender: GenderEnum.other,
    phone: '0739878155',
    address: 'Thành phố Hồ Chí Minh',
    patientID: 'BN000001',
),
  'BN000002' : Patient(
    firstName: 'Thị Mai',
    lastName: 'Sơn',
    age: 55,
    gender: GenderEnum.other,
    phone: '0720193390',
    address: 'Hải Dương',
    patientID: 'BN000002',
),
  'BN000003' : Patient(
    firstName: 'Hạnh',
    lastName: 'Lý Quốc',
    age: 23,
    gender: GenderEnum.male,
    phone: '0855128997',
    address: 'Hà Nội',
    patientID: 'BN000003',
),
  'BN000004' : Patient(
    firstName: 'Bình',
    lastName: 'Vũ Trọng',
    age: 23,
    gender: GenderEnum.other,
    phone: '0702421890',
    address: 'Bạc Liêu',
    patientID: 'BN000004',
),
  'BN000005' : Patient(
    firstName: 'Hà',
    lastName: 'Ung',
    age: 55,
    gender: GenderEnum.male,
    phone: '0851109732',
    address: 'Thủ Dầu Một',
    patientID: 'BN000005',
),
  'BN000006' : Patient(
    firstName: 'Thúy Nga',
    lastName: 'Tăng Nhật',
    age: 60,
    gender: GenderEnum.female,
    phone: '0776391778',
    address: 'Quảng Ngãi',
    patientID: 'BN000006',
),
  'BN000007' : Patient(
    firstName: 'Thành',
    lastName: 'Khuất',
    age: 62,
    gender: GenderEnum.male,
    phone: '0761849714',
    address: 'Điện Biên Phủ',
    patientID: 'BN000007',
),
  'BN000008' : Patient(
    firstName: 'Tuấn Anh',
    lastName: 'Đỗ Hữu',
    age: 22,
    gender: GenderEnum.female,
    phone: '0950773818',
    address: 'Đà Nẵng',
    patientID: 'BN000008',
),
  'BN000009' : Patient(
    firstName: 'An',
    lastName: 'Giáp',
    age: 34,
    gender: GenderEnum.female,
    phone: '0891597700',
    address: 'Bà Rịa',
    patientID: 'BN000009',
),
  'BN000010' : Patient(
    firstName: 'Thúy Nga',
    lastName: 'Bùi Xuân',
    age: 22,
    gender: GenderEnum.other,
    phone: '0809849080',
    address: 'Cà Mau',
    patientID: 'BN000010',
),
};