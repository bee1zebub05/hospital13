import "person.dart";
class Worker extends Person {
  String _IDWorker;
  double _salary;

  Worker({
    super.firstName,
    super.lastName,
    super.age,
    super.gender,
    super.address,
    String IDWorker ="",
    double salary = 0,
  })  : _IDWorker = IDWorker,
        _salary = salary;
  String get IDWorker => _IDWorker;
  set IDWorker(String value) => _IDWorker = value;
  double get salary => _salary;
  set salary(double value) {
    if (value >= 0) {
      _salary = value;
    } else {
      throw EmptyFieldException('Lương không thể nhận giá trị âm');
    }
  }
}
