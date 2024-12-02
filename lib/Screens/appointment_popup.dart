import 'package:flutter/material.dart';
import 'package:beginapp01/OOP_material/appoinment.dart';
import 'package:beginapp01/OOP_material/doctor.dart';

class AppointmentPopup extends StatelessWidget {
  final String patientID;
  AppointmentPopup({required this.patientID});

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
        content: Text('Bệnh nhân này chưa có cuộc hẹn nào.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Đóng popup
            },
            child: Text('Đóng'),
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
              
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xFFC1E6BA), // Màu khung xanh
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Ngày: ${app.dateTime}',
                        ),
                        Text(
                          'Bác sĩ: ${app.toString()}',
                        ),
                        // Nếu có hóa đơn, hiển thị tổng tiền
                        if (app.payedBill != null)
                          Text(
                            'Tổng tiền: ${app.payedBill!.getTotalPrice()} VND',
                            style: TextStyle(color: Colors.red),
                          ),
                        // Nếu không có hóa đơn, hiển thị thông báo
                        if (app.payedBill == null)
                          Text(
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
                      if (app.payedBill != null) {
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
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text:
                                          'Bác sĩ phụ trách ${allDoctors[app.doctorID]?.firstName ?? 'Không tìm thấy bác sĩ'}\n',
                                      style: TextStyle(
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
                                        children: [
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
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  pair.key.medicineName,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  pair.key.medicineID,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  pair.value.toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  pair.key.price.toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  // Hiển thị tổng tiền
                                  Text(
                                    'Tổng tiền cần thanh toán: ${totalAmount.toStringAsFixed(2)} VND',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Đóng popup
                                  },
                                  child: Text('Đóng'),
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
                              content: Text('Vui lòng đợi đến khi có hóa đơn.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Đóng popup
                                  },
                                  child: Text('Đóng'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('Chi tiết hóa đơn'),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Đóng popup
          },
          child: Text('Đóng'),
        ),
      ],
    );
  }
}