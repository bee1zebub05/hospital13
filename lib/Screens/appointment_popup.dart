import 'package:beginapp01/const_color.dart';
import 'package:flutter/material.dart';
import 'package:beginapp01/OOP_material/appoinment.dart';
import 'package:beginapp01/OOP_material/doctor.dart';

class AppointmentPopup extends StatelessWidget {
  final String patientID;
  const AppointmentPopup({super.key, required this.patientID});

  @override
  Widget build(BuildContext context) {
    // Lấy danh sách cuộc hẹn của bệnh nhân từ kAppointments
    List<Appoinment> appointments = kAppointments.entries
        .where((entry) => entry.value.any((app) => app.patientID == patientID))
        .expand((entry) => entry.value)
        .toList();

    if (appointments.isEmpty) {
      // Nếu bệnh nhân chưa có cuộc hẹn nào, hiển thị thông báo
      return AlertDialog(
        title: Text('Danh sách cuộc hẹn của bệnh nhân $patientID'),
        content: const Text('Bệnh nhân này chưa có cuộc hẹn nào.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Đóng popup
            },
            child: const Text('Đóng'),
          ),
        ],
      );
    }

    return AlertDialog(
      title: Text('Danh sách cuộc hẹn của bệnh nhân $patientID'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Hiển thị danh sách cuộc hẹn
          ...appointments.map((app) {
            return Container(
              
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: whiteGreenBackground, // Màu khung xanh
                borderRadius: BorderRadius.circular(20), // Khung tròn hơn
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Thông tin cuộc hẹn
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cuộc hẹn ID: ${app.appoinmentID}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Ngày: ${app.dateTime}',
                        ),
                        Text(
                          'Bác sĩ: ${app.toString()}',
                        ),
                        // Nếu có hóa đơn, hiển thị tổng tiền
                        if (app.payedBill != null&&app.payedBill!.getTotalPrice()!=0)
                          Text(
                            'Tổng tiền: ${app.payedBill!.getTotalPrice()} VND',
                            style: const TextStyle(color: Colors.red),
                          ),
                        // Nếu không có hóa đơn, hiển thị thông báo
                        if (app.payedBill!.getTotalPrice()==0)
                          const Text(
                            'Chưa có hóa đơn',
                            style: TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                  // Nút tính tiền bên phải
                  ElevatedButton(
                    onPressed: () {
                      // Nếu có hóa đơn, hiển thị thông tin chi tiết thuốc và tổng tiền cho từng cuộc hẹn
                      if (app.payedBill != null&&app.payedBill!.getTotalPrice()!=0) {
                        double totalAmount = app.payedBill!.getTotalPrice();
                        // Hiển thị thông báo tổng tiền và các thuốc cho từng cuộc hẹn
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: RichText(
                                text: TextSpan(
                                  text:
                                      'Chi tiết hóa đơn cho cuộc hẹn ${app.appoinmentID}\n',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text:
                                          'Bác sĩ phụ trách ${allDoctors[app.doctorID]?.firstName ?? 'Không tìm thấy bác sĩ'}\n',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Table hiển thị thông tin thuốc
                                  Table(
                                    border: TableBorder.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    children: [
                                      // Header row
                                      TableRow(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                        ),
                                        children: const [
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Tên thuốc',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'ID thuốc',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Số lượng',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Đơn giá (VND)',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Dữ liệu thuốc
                                      ...app.payedBill!.medicinePairs
                                          .map((pair) {
                                        return TableRow(
                                          children: [
                                            TableCell(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  pair.key.medicineName,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  pair.key.medicineID,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  pair.value.toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  pair.key.price.toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Hiển thị tổng tiền
                                  Text(
                                    'Tổng tiền cần thanh toán: ${totalAmount.toStringAsFixed(2)} VND',
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Đóng popup
                                  },
                                  child: const Text('Đóng'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Nếu không có hóa đơn, hiển thị thông báo
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  'Chưa có hóa đơn cho cuộc hẹn ${app.appoinmentID}'),
                              content: const Text('Vui lòng đợi đến khi có hóa đơn.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Đóng popup
                                  },
                                  child: const Text('Đóng'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Chi tiết hóa đơn'),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Đóng popup
          },
          child: const Text('Đóng'),
        ),
      ],
    );
  }
}