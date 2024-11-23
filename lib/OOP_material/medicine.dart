class Medicine {
  String _medicineID;
  String _medicineName;
  int _unit; // 0 = liquid , 1 = solid
  bool _status; // false = unavailable, true = available
  int _quantity;
  double _price;
  String _description;

  // Constructor
  Medicine({
    String medicineID = "",
    String medicineName = "",
    int unit = 0,
    bool status = false,
    int quantity = 0,
    double price = 0,
    String description = "",
  })  : _medicineID = medicineID,
        _medicineName = medicineName,
        _unit = unit,
        _status = status,
        _quantity = quantity,
        _price = price,
        _description = description;

  // Getter and setter for _medicineID
  String get medicineID => _medicineID;
  set medicineID(String value) => _medicineID = value;

  // Getter and setter for _medicineName
  String get medicineName => _medicineName;
  set medicineName(String value) => _medicineName = value;

  // Getter and setter for _unit
  int get unit => _unit;
  set unit(int value) {
    if (value == 0 || value == 1) {
      _unit = value;
    } else {
      throw ArgumentError('Unit must be 0 (liquid) or 1 (solid)');
    }
  }

  // Getter and setter for _status
  bool get status => _status;
  set status(bool value) => _status = value;

  // Getter and setter for _quantity
  int get quantity => _quantity;
  set quantity(int value) {
    if (value >= 0) {
      _quantity = value;
    } else {
      throw ArgumentError('Quantity must be non-negative');
    }
  }

  // Getter and setter for _price
  double get price => _price;
  set price(double value) {
    if (value >= 0) {
      _price = value;
    } else {
      throw ArgumentError('Price must be non-negative');
    }
  }

  // Getter and setter for _description
  String get description => _description;
  set description(String value) => _description = value;
}
