enum GenderEnum {male,female,other}
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
  set firstName(String value) => _firstName = value;
  set lastName(String value) => _lastName = value;
  set age(int value) {
    if (value >= 0) {
      _age = value;
    } else {
      throw ArgumentError('Age must be non-negative');
    }
  }
  set gender(GenderEnum value) => _gender = value;
  set phone(String value) => _phone = value;
  set address(String value) => _address = value;

}
