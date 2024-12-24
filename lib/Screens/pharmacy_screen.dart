import 'package:flutter/material.dart';
import 'package:beginapp01/OOP_material/medicine.dart';
import 'package:beginapp01/Screens/main_screen.dart';
import 'package:beginapp01/const_color.dart';
import 'package:beginapp01/OOP_material/hospital_inventory.dart';

class PharmacyScreen extends StatefulWidget {
  static String routeName = 'PharmacyScreen';

  const PharmacyScreen({super.key});

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  int listType = 0; // Loại sắp xếp
  bool listTypeReverse = false; // Thứ tự sắp xếp
  late int selectedIndex = 0; // Chỉ mục của NavigationRail

  final TextEditingController searchController = TextEditingController();

  // Generate a unique medicine ID
  String generateMedicineID() {
    int idNumber = 1;
    String newID = 'ME${idNumber.toString().padLeft(6, '0')}';

    while (allMedicines.containsKey(newID)) {
      idNumber++;
      newID = 'ME${idNumber.toString().padLeft(6, '0')}';
    }
    return newID;
  }

  // Add a new medicine
  void addMedicine() {
  showDialog(
    context: context,
    builder: (context) {
      TextEditingController medicineNameController = TextEditingController();
      TextEditingController quantityController = TextEditingController();
      TextEditingController priceController = TextEditingController();
      TextEditingController descriptionController = TextEditingController();
      bool status = false;
      int unit = 0;

      String medicineID = generateMedicineID();

      return AlertDialog(
        title: const Text('Thêm thuốc mới', style: TextStyle(fontSize: 24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ID thuốc: $medicineID',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: medicineNameController,
              decoration: const InputDecoration(labelText: 'Tên thuốc'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Số lượng'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Giá'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Mô tả'),
            ),
            Row(
              children: [
                const Text('Đơn vị:'),
                Radio(
                  value: 0,
                  groupValue: unit,
                  onChanged: (int? value) {
                    setState(() {
                      unit = value!;
                    });
                  },
                ),
                const Text('Lỏng'),
                Radio(
                  value: 1,
                  groupValue: unit,
                  onChanged: (int? value) {
                    setState(() {
                      unit = value!;
                    });
                  },
                ),
                const Text('Rắn'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              try {
                // Kiểm tra các trường bị bỏ trống
                if (medicineNameController.text.isEmpty) {
                  throw 'Tên thuốc không được bỏ trống';
                }
                if (quantityController.text.isEmpty) {
                  throw 'Số lượng không được bỏ trống';
                }
                if (priceController.text.isEmpty) {
                  throw 'Giá không được bỏ trống';
                }
                if (descriptionController.text.isEmpty) {
                  throw 'Mô tả không được bỏ trống';
                }

                // Kiểm tra định dạng ID thuốc (đã tự động tạo đúng)
                if (!RegExp(r'^ME\d{6}$').hasMatch(medicineID)) {
                  throw 'ID thuốc phải có định dạng MExxxxxx (ME + 6 chữ số)';
                }

                // Kiểm tra giá trị nhập liệu
                int quantity = int.tryParse(quantityController.text) ?? -1;
                double price = double.tryParse(priceController.text) ?? -1;

                if (quantity < 0) {
                  throw 'Số lượng phải là số nguyên không âm';
                }
                if (price < 0) {
                  throw 'Giá phải là số thực không âm';
                }

                // Thêm thuốc nếu hợp lệ
                setState(() {
                  allMedicines[medicineID] = Medicine(
                    medicineID: medicineID,
                    medicineName: medicineNameController.text,
                    quantity: quantity,
                    price: price,
                    description: descriptionController.text,
                    unit: unit,
                    status: status,
                  );
                });
                Navigator.pop(context); // Đóng hộp thoại
              } catch (e) {
                // Hiển thị lỗi nếu có ngoại lệ
                showErorrFlushBar(context, '$e');
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      );
    },
  );
}


  void showEditMedicineDialog(String key, Medicine medicine) {
  TextEditingController medicineNameController =
      TextEditingController(text: medicine.medicineName);
  TextEditingController quantityController =
      TextEditingController(text: medicine.quantity.toString());
  TextEditingController priceController =
      TextEditingController(text: medicine.price.toString());
  TextEditingController descriptionController =
      TextEditingController(text: medicine.description);
  TextEditingController medicineIDController =
      TextEditingController(text: medicine.medicineID);
      
  int unit = medicine.unit;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
            title: const Text(
              'Chỉnh sửa thông tin thuốc',
              style: TextStyle(fontSize: 24),
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Cột thứ nhất
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        children: [
                          TextField(
                            controller: medicineNameController,
                            decoration:
                                const InputDecoration(labelText: 'Tên thuốc'),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: quantityController,
                            decoration:
                                const InputDecoration(labelText: 'Số lượng'),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: priceController,
                            decoration: const InputDecoration(labelText: 'Giá'),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Cột thứ hai
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        children: [
                          TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(labelText: 'Mô tả'),
                          ),
                          const SizedBox(height: 10),
                          // Hiển thị ID thuốc, không chỉnh sửa
                          TextFormField(
                            controller: medicineIDController,
                            decoration: const InputDecoration(labelText: 'ID thuốc'),
                            enabled: false, // Không thể chỉnh sửa
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text('Đơn vị:'),
                              Radio(
                                value: 0,
                                groupValue: unit,
                                onChanged: (int? value) {
                                  setState(() {
                                    unit = value!;
                                  });
                                },
                              ),
                              const Text('Lỏng'),
                              Radio(
                                value: 1,
                                groupValue: unit,
                                onChanged: (int? value) {
                                  setState(() {
                                    unit = value!;
                                  });
                                },
                              ),
                              const Text('Rắn'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            actions: [
              // Xóa thuốc
              TextButton(
                onPressed: () {
                  setState(() {
                    allMedicines.remove(key); // Xóa thuốc khỏi danh sách
                  });
                  Navigator.of(context).pop(); // Đóng hộp thoại
                  showCompleteFlushBar(context, 'Xóa thuốc thành công');
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const PharmacyScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return child;
                        },
                      ),
                    );
                  });
                },
                child: const Text('Xóa', style: TextStyle(color: Colors.red)),
              ),
              // Lưu thay đổi
              TextButton(
                onPressed: () {
                  try {
                    // Kiểm tra ô bị bỏ trống
                    if (medicineNameController.text.isEmpty) {
                      throw 'Tên thuốc không được bỏ trống';
                    }
                    if (quantityController.text.isEmpty) {
                      throw 'Số lượng không được bỏ trống';
                    }
                    if (priceController.text.isEmpty) {
                      throw 'Giá không được bỏ trống';
                    }
                    if (descriptionController.text.isEmpty) {
                      throw 'Mô tả không được bỏ trống';
                    }

                    // Kiểm tra giá trị nhập liệu
                    int quantity = int.tryParse(quantityController.text) ?? -1;
                    double price = double.tryParse(priceController.text) ?? -1;

                    if (quantity < 0) {
                      throw 'Số lượng phải là số nguyên không âm';
                    }
                    if (price < 0) {
                      throw 'Giá phải là số thực không âm';
                    }

                    // Lưu dữ liệu nếu hợp lệ
                    setState(() {
                      allMedicines[key]?.medicineName =
                          medicineNameController.text;
                      allMedicines[key]?.quantity = quantity;
                      allMedicines[key]?.price = price;
                      allMedicines[key]?.description =
                          descriptionController.text;
                      allMedicines[key]?.unit = unit;
                    });

                    Navigator.of(context).pop(); // Đóng hộp thoại
                    showCompleteFlushBar(context, 'Chỉnh sửa thành công');
                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const PharmacyScreen(),
                          transitionsBuilder: (context, animation,
                              secondaryAnimation, child) {
                            return child;
                          },
                        ),
                      );
                    });
                  } catch (e) {
                    // Hiển thị thông báo lỗi khi xảy ra ngoại lệ
                    showErorrFlushBar(context, '$e');
                  }
                },
                child: const Text('Lưu'),
              ),
              // Hủy
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng hộp thoại
                },
                child: const Text('Hủy'),
              ),
            ],
          );
        },
      );
    },
  );
}


  // Sort medicines
  List<MapEntry<String, Medicine>> sortMedicines() {
    List<MapEntry<String, Medicine>> entries = allMedicines.entries.toList();

    switch (listType) {
      case 1: // Sort by ID
        entries.sort( 
            (a, b) => a.key.compareTo(b.key) * (listTypeReverse ? -1 : 1));
        break;
      case 2: // Sort by Name
        entries.sort((a, b) =>
            a.value.medicineName.compareTo(b.value.medicineName) *
            (listTypeReverse ? -1 : 1));
        break;
      case 3: // Sort by Quantity
        entries.sort((a, b) =>
            a.value.quantity.compareTo(b.value.quantity) *
            (listTypeReverse ? -1 : 1));
        break;
      case 4: // Sort by Price
        entries.sort((a, b) =>
            a.value.price.compareTo(b.value.price) *
            (listTypeReverse ? -1 : 1));
        break;
      case 5: // Sort by Unit
        entries.sort((a, b) =>
            a.value.unit.compareTo(b.value.unit) * (listTypeReverse ? -1 : 1));
        break;
      default:
        break;
    }

    return entries;
  }

  Widget headTableText(String label, int type) {
    return InkWell(
      onTap: () {
        setState(() {
          if (listType == type) {
            listTypeReverse = !listTypeReverse;
          } else {
            listType = type;
            listTypeReverse = false;
          }
        });
      },
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
          Icon(
            listType == type
                ? (listTypeReverse ? Icons.arrow_downward : Icons.arrow_upward)
                : Icons.swap_vert,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, Medicine>> displayMedicines = sortMedicines();

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, MainScreen.routeName);
                  break;
                case 2:
                  addMedicine();
                  break;
              }
            },
            backgroundColor: lightGreenBackground,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.arrow_circle_left_outlined),
                selectedIcon: Icon(Icons.arrow_circle_left_outlined),
                label: Text('Trở về'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.delete),
                selectedIcon: Icon(Icons.delete),
                label: Text('Xóa'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_circle),
                selectedIcon: Icon(Icons.add_circle),
                label: Text('Thêm'),
              ),
            ],
          ),
          const Spacer(),
          Container(
            color: whiteGreenBackground,
            width: MediaQuery.of(context).size.width * 0.93,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: lightGreenBackground,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              listType = 0;
                            });
                          },
                          child: Image.asset(
                            'assets/images/reset.png',
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                        headTableText('ID Thuốc', 1),
                        const SizedBox(width: 170),
                        headTableText('Tên Thuốc', 2),
                        const SizedBox(width: 170),
                        headTableText('Số Lượng', 3),
                        const SizedBox(width: 220),
                        headTableText('Giá', 4),
                        const SizedBox(width: 160),
                        headTableText('Lỏng/Rắn', 5),
                        const SizedBox(width: 160),
                        const Icon(Icons.visibility),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: displayMedicines.length,
                    itemBuilder: (context, index) {
                      String key = displayMedicines[index].key;
                      Medicine medicine = displayMedicines[index].value;

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4.0), // Khoảng cách giữa các hàng
                        padding: const EdgeInsets.all(
                            8.0), // Padding bên trong từng hàng
                        decoration: BoxDecoration(
                          color: lightGreenBackground,
                          borderRadius:
                              BorderRadius.circular(100), // Bo góc cho Container
                        ),
                        child: Row(
                          children: [
                            // Icon thuốc
                            Image.asset(
                              'assets/images/drug.png',
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(
                                width: 100), // Khoảng cách giữa icon và ID thuốc

                            // ID Thuốc
                            Expanded(
                              flex: 1,
                              child: Text(
                                medicine.medicineID,
                                style: const TextStyle(
                                  fontSize: 20, // Tăng cỡ chữ cho ID thuốc
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(
                                width: 0), // Khoảng cách giữa các cột

                            // Tên Thuốc
                            Expanded(
                              flex: 1,
                              child: Text(
                                medicine.medicineName,
                                style: const TextStyle(
                                  fontSize: 20, // Tăng cỡ chữ cho Tên thuốc
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Số Lượng
                            Expanded(
                              flex: 1,
                              child: Text(
                                medicine.quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 20, // Tăng cỡ chữ cho Số lượng
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Giá
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${medicine.price} VND',
                                style: const TextStyle(
                                  fontSize: 20, // Tăng cỡ chữ cho Giá
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Lỏng/Rắn
                            Expanded(
                              flex: 1,
                              child: Text(
                                medicine.unit == 0 ? 'Lỏng' : 'Rắn',
                                style: const TextStyle(
                                  fontSize: 20, // Tăng cỡ chữ cho Lỏng/Rắn
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Edit button
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                showEditMedicineDialog(key, medicine);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
