import "person.dart";
class Worker extends Person {
  String _idWorker;
  double _salary;

  Worker({
    super.firstName,
    super.lastName,
    super.age,
    super.gender,
    super.address,
    String idWorker ="",
    double salary = 0,
  })  : _idWorker = idWorker,
        _salary = salary;
  String get idWorker => _idWorker;
  set idWorker(String value) => _idWorker = value;
  double get salary => _salary;
  set salary(double value) {
    if (value >= 0) {
      _salary = value;
    } else {
      throw EmptyFieldException('Lương không thể nhận giá trị âm');
    }
  }
}
