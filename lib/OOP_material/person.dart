class EmptyFieldException implements Exception {
  final String message;

  EmptyFieldException(this.message);

  @override
  String toString() => message; // Chỉ trả về thông báo lỗi
}

enum GenderEnum {male,female,other}

class Person {
  String _firstName;
  String _lastName;
  int _age;
  GenderEnum _gender;
  String _address;

  Person( {String firstName = "", String lastName = "", int age = 0, GenderEnum
  gender = GenderEnum.other, String phone = "", String address = "" } ):
  _firstName = firstName, _lastName = lastName, _age = age, _gender = gender,
  _address = address
  ;

  //getter
  String get lastName => _lastName;
  String get firstName => _firstName;
  int get age => _age;
  GenderEnum get gender => _gender;
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
  set address(String value){
    if(value.isEmpty){
      throw EmptyFieldException('Địa chỉ không thể để trống');
    } 
    else {
      _address = value;
    }
  }

}
