import 'package:beginapp01/OOP_material/doctor.dart';
import 'package:beginapp01/OOP_material/patient.dart';
import 'package:beginapp01/const_color.dart';
class EmptyFieldException implements Exception {
  final String message;

  EmptyFieldException(this.message);

  @override
  String toString() => message; // Chỉ trả về thông báo lỗi
}

enum GenderEnum {male,female,other}

bool checkPhone(String phone){
  for(var doctor in allDoctors.values){
    if (doctor.phone == phone) return false;
  }
  for(var patient in allPatient.values){
    if(patient.phone == phone) return false;
  }
  return true;
}
class Person {
  String _firstName;
  String _lastName;
  int _age;
  GenderEnum _gender;
  String _phone;
  String _address;

  Person( {String firstName = "", String lastName = "", int age = 0, GenderEnum
  gender = GenderEnum.other, String phone = "", String address = "" } ):
  _firstName = firstName, _lastName = lastName, _age = age, _gender = gender,
  _phone = phone, _address = address
  ;

  //getter
  String get lastName => _lastName;
  String get firstName => _firstName;
  int get age => _age;
  GenderEnum get gender => _gender;
  String get phone => _phone;
  String get address => _address;

  //setter
  set firstName(String value){
    if(value.isEmpty){
      throw EmptyFieldException('Tên không thể để trống');
    } 
    else {
      _firstName = value;
    }
  }
  set lastName(String value){
    if(value.isEmpty){
      throw EmptyFieldException('Họ không thể để trống');
    } 
    else {
      _lastName = value;
    }
  }
  set age(int value) {
    if (value >= 0) {
      _age = value;
    } else {
      throw EmptyFieldException('Tuổi phải nhận giá trị dương');
    }
  }
  set gender(GenderEnum value) => _gender = value;
  set phone(String value){
    RegExp regExp = new RegExp(mobilePattern);
    if(value.isEmpty){
      throw EmptyFieldException('SĐT không thể để trống');
    }
    else if( !regExp.hasMatch(value)){
      throw EmptyFieldException('SĐT nhập vào không hợp lệ');
    }
    else if(!checkPhone(value)){
      throw EmptyFieldException('Đã tồn tại bác sĩ hoặc bệnh nhân mang SDT này');
    }
    else{
      _phone = value;
    }
  }
  set address(String value){
    if(value.isEmpty){
      throw EmptyFieldException('Địa chỉ không thể để trống');
    } 
    else {
      _address = value;
    }
  }

}
