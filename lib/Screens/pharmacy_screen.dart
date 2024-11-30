import 'package:flutter/material.dart';
import 'package:beginapp01/OOP_material/medicine.dart';
import 'package:beginapp01/Screens/main_screen.dart';
import 'package:beginapp01/const_color.dart';
import 'package:beginapp01/OOP_material/hospital_inventory.dart';

class PharmacyScreen extends StatefulWidget {
  static String routeName = 'PharmacyScreen';

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  late int _selectedIndex = 0;

  // Phương thức tạo ID thuốc mới (kiểm tra ID trống)
  String generateMedicineID() {
    // Tìm ID đầu tiên còn trống
    int idNumber = 1;
    String newID = 'ME${idNumber.toString().padLeft(6, '0')}';

    // Kiểm tra xem ID này có được sử dụng chưa
    while (allMedicines.containsKey(newID)) {
      idNumber++;
      newID = 'ME${idNumber.toString().padLeft(6, '0')}';
    }

    return newID;
  }

  // Thêm thuốc mới
  void addmedicine() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController medicineNameController = TextEditingController();
        TextEditingController quantityController = TextEditingController();
        TextEditingController priceController = TextEditingController();
        TextEditingController descriptionController = TextEditingController();
        bool status = false;
        int unit = 0;

        String medicineID = generateMedicineID(); // Tạo ID thuốc mới

        return AlertDialog(
          title: Text('Thêm thuốc mới', style: TextStyle(fontSize: 38)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Hiển thị ID thuốc
              Text(
                'ID thuốc: $medicineID',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
              ),
              TextField(
                controller: medicineNameController,
                decoration: InputDecoration(labelText: 'Tên thuốc'),
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Số lượng'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Giá'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Mô tả'),
              ),
              Row(
                children: [
                  Text("Đơn vị: "),
                  Radio(
                    value: 0,
                    groupValue: unit,
                    onChanged: (int? value) {
                      setState(() {
                        unit = value!;
                      });
                    },
                  ),
                  Text("Lỏng"),
                  Radio(
                    value: 1,
                    groupValue: unit,
                    onChanged: (int? value) {
                      setState(() {
                        unit = value!;
                      });
                    },
                  ),
                  Text("Rắn"),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  allMedicines[medicineID] = Medicine(
                    medicineID: medicineID,
                    medicineName: medicineNameController.text,
                    quantity: int.parse(quantityController.text),
                    price: double.parse(priceController.text),
                    description: descriptionController.text,
                    unit: unit,
                    status: status, // Không cần sử dụng status
                  );
                });
                Navigator.pop(context);
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  // Xóa thuốc theo ID nhập vào
  void deletemedicine() {
    TextEditingController idToDeleteController = TextEditingController(); // Controller nhập ID thuốc cần xóa

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nhập ID thuốc cần xóa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: idToDeleteController,
                decoration: InputDecoration(labelText: 'Nhập ID thuốc'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                String idToDelete = idToDeleteController.text;

                // Kiểm tra ID thuốc có tồn tại không
                try {
                  if (allMedicines.containsKey(idToDelete)) {
                    setState(() {
                      allMedicines.remove(idToDelete); // Xóa thuốc khỏi map
                    });
                    Navigator.pop(context);
                    showCompleteFlushBar(context, 'Xóa thuốc thành công');
                  } else {
                    showErorrFlushBar(context, 'Thuốc không tồn tại');
                  }
                } catch (e) {
                  // Hiển thị lỗi nếu ID không tồn tại
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lỗi: $e')),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, MainScreen.routeName);
                  break;
                case 1:
                  addmedicine(); // Thêm thuốc
                  break;
                case 2:
                  deletemedicine(); // Xóa thuốc theo ID
                  break;
                default:
                  break;
              }
            },
            backgroundColor: Color(0xFFC1E6BA),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.arrow_back),
                selectedIcon: Icon(Icons.arrow_back),
                label: Text('Trở về'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_circle),
                selectedIcon: Icon(Icons.add_circle),
                label: Text('Thêm'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.delete),
                selectedIcon: Icon(Icons.delete),
                label: Text('Xóa'),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.93,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                // Tiêu đề
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Danh sách thuốc', style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono')), // Phóng to tiêu đề và thay kiểu chữ
                    ],
                  ),
                ),
                Divider(color: Colors.black, thickness: 2), // Dấu gạch ngang
                // Danh sách thuốc
                Expanded(
                  child: SingleChildScrollView( // Cuộn dọc
                    scrollDirection: Axis.vertical, 
                    child: SingleChildScrollView( // Cuộn ngang
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 10.0, // Khoảng cách giữa các cột
                        columns: [
                          DataColumn(label: Text('ID Thuốc', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38, fontFamily: 'RobotoMono'))), 
                          DataColumn(label: Container(width: 1, color: Colors.black)),  // Dấu gạch đứng
                          DataColumn(label: Text('Tên Thuốc', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38, fontFamily: 'RobotoMono'))),
                          DataColumn(label: Container(width: 1, color: Colors.black)),  // Dấu gạch đứng
                          DataColumn(label: Text('Số Lượng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42, fontFamily: 'RobotoMono'))),
                          DataColumn(label: Container(width: 1, color: Colors.black)),  // Dấu gạch đứng
                          DataColumn(label: Text('Giá', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38, fontFamily: 'RobotoMono'))),
                          DataColumn(label: Container(width: 1, color: Colors.black)),  // Dấu gạch đứng
                          DataColumn(label: Text('Đơn Vị', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38, fontFamily: 'RobotoMono'))),
                          DataColumn(label: Container(width: 1, color: Colors.black)),  // Dấu gạch đứng
                          DataColumn(label: Text('Hành Động', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38, fontFamily: 'RobotoMono'))),
                        ],
                        rows: allMedicines.entries.map((entry) {
                          return DataRow(
                            cells: [
                              DataCell(Text(entry.value.medicineID, style: TextStyle(fontSize: 38))),
                              DataCell(Container(width: 1, color: Colors.black)),  // Dấu gạch đứng
                              DataCell(Text(entry.value.medicineName, style: TextStyle(fontSize: 38))),
                              DataCell(Container(width: 1, color: Colors.black)),  // Dấu gạch đứng
                              DataCell(Text(entry.value.quantity.toString(), style: TextStyle(fontSize: 38))),
                              DataCell(Container(width: 1, color: Colors.black)),  // Dấu gạch đứng
                              DataCell(Text(entry.value.price.toString(), style: TextStyle(fontSize: 38))),
                              DataCell(Container(width: 1, color: Colors.black)),  // Dấu gạch đứng
                              DataCell(Text(entry.value.unit == 0 ? 'Lỏng' : 'Rắn', style: TextStyle(fontSize: 38))),
                              DataCell(Container(width: 1, color: Colors.black)),  // Dấu gạch đứng
                              DataCell(
                                IconButton(
                                  onPressed: () {
                                    deletemedicine();
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red, size: 38),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}