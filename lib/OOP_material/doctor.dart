import 'package:beginapp01/OOP_material/person.dart';
import 'package:beginapp01/const_color.dart';

import 'worker.dart';

bool _checkPhone(String phone,String id){
  for( var doctor in allDoctors.values ){
    if( doctor.phone == phone && doctor.IDWorker != id ){
      return false;
    }
  }
  return true;
}

class Doctor extends Worker {
  String _speciality;
  String _phone;
  Doctor({
    super.firstName,
    super.lastName,
    super.age,
    super.gender,
    super.address,
    super.IDWorker,
    super.salary,
    String phone = "",
    String speciality = "",
  }) : _speciality = speciality, _phone =phone;
  String get speciality => _speciality;
  set speciality(String value) => _speciality = value;
  String get phone => _phone;
  set phone(String value){
    RegExp regExp = RegExp(mobilePattern);
    if(value.isEmpty){
      throw EmptyFieldException('SĐT không thể để trống');
    }
    else if( !regExp.hasMatch(value)){
      throw EmptyFieldException('SĐT nhập vào không hợp lệ');
    }
    else if(!_checkPhone(value, IDWorker )){
      throw EmptyFieldException('Đã tồn tại bác sĩ mang SDT này');
    }
    else{
      _phone = value;
    }
  }
}

int doctorLastestID =10;

Map<String,Doctor> allDoctors ={
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
'DT000010' : Doctor(
    firstName: 'Quân',
    lastName: 'Bùi Xuân',
    age: 25,
    gender: GenderEnum.female,
    phone: '0836327583',
    address: 'Buôn Ma Thuột',
    IDWorker: 'DT000010',
    salary: 31,
    speciality: 'Tiêu hóa',
),
};