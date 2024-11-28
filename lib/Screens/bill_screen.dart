import 'package:flutter/material.dart';
import 'package:beginapp01/OOP_material/patient.dart';
import 'package:beginapp01/OOP_material/medicine.dart';
import 'package:beginapp01/OOP_material/hospital_inventory.dart';
import 'package:beginapp01/const_color.dart';

class BillScreen extends StatefulWidget {
  static const String routeName = '/billScreen';

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final TextEditingController _medicineIDController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  List<Medicine> selectedMedicines = [];

  void addMedicineToBill() {
    String medicineID = _medicineIDController.text.trim();
    int quantity = int.tryParse(_quantityController.text) ?? 0;

    try {
      hospitalInventory.reduceMedicineQuantity(medicineID, quantity);

      Medicine medicine = hospitalInventory.findMedicine(medicineID);
      setState(() {
        selectedMedicines.add(Medicine(
          medicineID: medicine.medicineID,
          medicineName: medicine.medicineName,
          unit: medicine.unit,
          status: medicine.status,
          quantity: quantity,
          price: medicine.price,
          description: medicine.description,
        ));
      });

      _medicineIDController.clear();
      _quantityController.clear();
    } on MedicineNotFoundException {
      showErorrFlushBar(context, 'Thuốc không tồn tại');
    } on InsufficientMedicineQuantityException {
      showErorrFlushBar(context, 'Thiếu thuốc');
    }
  }

  void removeMedicineFromBill(int index) {
    setState(() {
      Medicine medicine = selectedMedicines[index];
      hospitalInventory.increaseMedicineQuantity(medicine.medicineID, medicine.quantity);
      selectedMedicines.removeAt(index);
    });
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (var med in selectedMedicines) {
      total += med.price * med.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final String patientID = ModalRoute.of(context)!.settings.arguments as String;
    final patient = allPatient[patientID];

    if (patient == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Hóa đơn')),
        body: const Center(
          child: Text(
            'Không tìm thấy bệnh nhân',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Hóa đơn của ${patient.firstName} ${patient.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mã bệnh nhân: ${patient.patientID}', style: const TextStyle(fontSize: 18)),
            Text('Họ: ${patient.lastName}', style: const TextStyle(fontSize: 18)),
            Text('Tên: ${patient.firstName}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _medicineIDController,
                    decoration: const InputDecoration(labelText: 'Mã thuốc'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Số lượng'),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addMedicineToBill,
                  child: const Text('Thêm thuốc'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Danh sách thuốc:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectedMedicines.length,
                itemBuilder: (context, index) {
                  final med = selectedMedicines[index];
                  return ListTile(
                    title: Text('${med.medicineName} (x${med.quantity})'),
                    subtitle: Text(
                        'Đơn giá: ${med.price.toStringAsFixed(0)} VND | Thành tiền: ${(med.price * med.quantity).toStringAsFixed(0)} VND'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removeMedicineFromBill(index),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Tổng tiền: ${calculateTotalPrice().toStringAsFixed(0)} VND',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}