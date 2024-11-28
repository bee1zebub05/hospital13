import 'package:flutter/material.dart';
import 'package:beginapp01/OOP_material/bill.dart';
import 'package:beginapp01/OOP_material/appoinment.dart';
import 'package:beginapp01/OOP_material/medicine.dart';

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
                      // Nếu có hóa đơn, tính tổng tiền cho từng cuộc hẹn
                      if (app.payedBill != null) {
                        double totalAmount = app.payedBill!.getTotalPrice();
                        // Hiển thị thông báo tổng tiền cho từng cuộc hẹn
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Tổng tiền hóa đơn cho cuộc hẹn ${app.appoinmentID}'),
                              content: Text('Tổng số tiền cần thanh toán: \$${totalAmount.toStringAsFixed(2)}'),
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
                              title: Text('Chưa có hóa đơn cho cuộc hẹn ${app.appoinmentID}'),
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
                    child: Text('Tính Hóa Đơn'),
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
