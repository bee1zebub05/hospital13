import 'package:beginapp01/OOP_material/doctor.dart';
import 'package:beginapp01/OOP_material/patient.dart';
import 'package:intl/intl.dart';
import 'package:beginapp01/OOP_material/appoinment.dart';
import 'package:beginapp01/Screens/main_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:beginapp01/const_color.dart';
import 'package:flutter/material.dart';


class AppoinmentScreen extends StatefulWidget {
  static String routeName = 'AppointmentScreen';

  const AppoinmentScreen({super.key});

  @override
  State<AppoinmentScreen> createState() => _AppoinmentScreenState();
}

class _AppoinmentScreenState extends State<AppoinmentScreen> {
  late final ValueNotifier<List<Appoinment>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  //METHOD CỦA APPOINTMENT
  DateTime choosenTime = DateTime.now();
  DateTime adjustTime = DateTime.now();
  

  Future<void> _pickDateToAdd() async {
    DateTime? pickedDate = await showDatePicker(
      helpText: 'Ngày đã chọn',
      context: context,
      initialDate: choosenTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      cancelText: 'Hủy',
      builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          dialogTheme: DialogTheme(
            backgroundColor: Colors.green.shade50, // Màu nền
          ),
        ),
        child: child!,
      );
    },    );
    if (pickedDate != null) {
      setState(() {
        choosenTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          choosenTime.hour,
          choosenTime.minute,
        );
      });
    }
  }
  Future<void> _pickTimeToAdd() async {
    TimeOfDay? pickedTime = await showTimePicker(
      cancelText: 'Hủy',  
      context: context,
      initialTime: TimeOfDay.fromDateTime(choosenTime),
    );

    if (pickedTime != null) {
      setState(() {
        choosenTime = DateTime(
          choosenTime.year,
          choosenTime.month,
          choosenTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }
  void adjustAppoinment(Appoinment appoinment){
    final TextEditingController doctorID = TextEditingController(text: appoinment.doctorID);
    final TextEditingController patientID = TextEditingController(text: appoinment.patientID);
    choosenTime = appoinment.dateTime;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteGreenBackground,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.25,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setDialogState){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: adjustblank(doctorID, 'Mã số bác sĩ phụ trách', appoinment.doctorID)),
                        const SizedBox(width: defaultPadding,),
                        Expanded(child: adjustblank(patientID, 'Mã số bệnh nhân', appoinment.patientID))
                      ],
                    ),
                    Expanded(child: 
                      Text(
                        DateFormat('HH:mm dd/MM/yyyy').format(choosenTime),
                        style: const TextStyle( fontSize: 25 ),
                      )
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return lightGreenBackground; // Khi nhấn
                                } else if (states.contains(WidgetState.disabled)) {
                                  return Colors.grey; // Khi tắt
                                }
                                return lightGreenBackground; // Mặc định
                              }),
                            ),
                            onPressed: () async {
                              await _pickDateToAdd(); // Cập nhật ngày
                              await _pickTimeToAdd(); // Cập nhật giờ
                              // Gọi setDialogState để cập nhật UI trong AlertDialog
                              setDialogState(() {});
                            },
                            child: const Text("Chỉnh sửa thời gian", style: TextStyle(color: textBlackColor),),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  try{
                    setState(() {
                      kAppointments[choosenTime] = [];
                      kAppointments[choosenTime]?.add(
                        Appoinment(
                          appoinmentID: appoinment.appoinmentID, 
                          doctorID: doctorID.text, 
                          patientID: patientID.text, 
                          dateTime: choosenTime,
                          hasPass: false,
                        )
                      );
                      kAppointments[appoinment.dateTime]?.removeWhere((value) => value.appoinmentID == appoinment.appoinmentID);
                      Navigator.of(context).pop();
                      showCompleteFlushBar(context, 'Lưu thành công');
                    });
                  }
                  catch(e){
                    showErorrFlushBar(context, '$e');
                  }
                },
                child: const Text(
                  'Lưu',
                  style: TextStyle(color: textBlackColor, fontSize: 18),
                ),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    kAppointments[appoinment.dateTime]?.removeWhere((value) => value.appoinmentID == appoinment.appoinmentID);
                  });
                  Navigator.of(context).pop();
                  showCompleteFlushBar(context, 'Xóa thành công');
                },
                child: const Text(
                  'Xóa',
                  style: TextStyle(color: textBlackColor, fontSize: 18),
                ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng dialog
                },
                child: const Text(
                  'Hủy',
                  style: TextStyle(color: textBlackColor, fontSize: 18),
                ),
            ),
          ],
        );
      }
    );
  }
  
  void showFitDoctorsList(TextEditingController doctorID,BuildContext context, List<String> fitDoctor) {
    if (fitDoctor.isEmpty) {
      // Nếu không có bác sĩ phù hợp, chỉ cần hiển thị thông báo
      showErorrFlushBar(context, 'Không có bác sĩ phù hợp');
      return;
    }

    // Hiển thị danh sách bác sĩ bằng BottomSheet
    showModalBottomSheet(
      backgroundColor: whiteGreenBackground,
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: fitDoctor.length, // Số lượng item trong danh sách
          itemBuilder: (context, index) {
            return Card(
              color: lightGreenBackground,
              margin: const EdgeInsets.symmetric(vertical: defaultPadding/2, horizontal: defaultPadding),
              child: ListTile(
                title: Text('${allDoctors[fitDoctor[index]]?.lastName} ${allDoctors[fitDoctor[index]]?.firstName}'),
                subtitle: Text('${fitDoctor[index]} ${allDoctors[fitDoctor[index]]?.speciality} '),
                onTap: () {
                  setState(() {
                    doctorID.text = fitDoctor[index];
                    Navigator.of(context).pop();
                  });
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<void> findFitDoctor(TextEditingController doctorID, String description, DateTime choosenTime) async {
    List<String> keywords = description.split(',').map((e) => e.trim()).toList();
    List<String> fitDoctor = [];

    // Kiểm tra bác sĩ phù hợp
    for (var doctor in allDoctors.values) {
      bool tempCheck = false;

      // Kiểm tra ngành bác sĩ có phù hợp với bệnh không
      if (specialityKeyWord.containsKey(doctor.speciality)) {
        for (var keyword in keywords) {
          if (specialityKeyWord[doctor.speciality]!.any((word) => word == keyword)) {
            tempCheck = true;
            break;
          }
        }
      }

      if (!tempCheck) continue;

      // Kiểm tra bác sĩ có bận không (Lịch hẹn trùng với thời gian chọn)
      if (kAppointments.containsKey(choosenTime) &&
          kAppointments[choosenTime]!.any((appoinment) => appoinment.doctorID == doctor.IDWorker)) {
        continue;
      }

      // Thêm bác sĩ vào danh sách phù hợp
      fitDoctor.add(doctor.IDWorker);
    }

    // Nếu có bác sĩ phù hợp, hiển thị danh sách bác sĩ
    showFitDoctorsList(doctorID,context, fitDoctor);
  }


  void addAnAppointment() {
    final TextEditingController doctorID = TextEditingController();
    final TextEditingController patientID = TextEditingController();
    final TextEditingController description = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: const Text('Thêm một cuộc hẹn mới'),
              backgroundColor: whiteGreenBackground,
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    Expanded(
                      child: 
                          Row(
                            children: [
                              Expanded(child: showAddingID('Mã số cuộc họp ', 2)),
                              Expanded(child: fillblank(patientID, 'Mã số bệnh nhân', )),
                            ],
                          ),
                        
                      ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color>((states) {
                            if (states.contains(WidgetState.pressed)) {
                              return lightGreenBackground; // Khi nhấn
                            } else if (states.contains(WidgetState.disabled)) {
                              return Colors.grey; // Khi tắt
                            }
                            return lightGreenBackground; // Mặc định
                          }),
                        ),
                        onPressed: () async {
                          await _pickDateToAdd(); // Cập nhật ngày
                          await _pickTimeToAdd(); // Cập nhật giờ
                          // Gọi setDialogState để cập nhật UI trong AlertDialog
                          setDialogState(() {});
                        },
                        child: Text(
                         'Ngày và giờ:  ${DateFormat('HH:mm dd/MM/yyyy').format(choosenTime)}',
                          style: const TextStyle(color: textBlackColor),
                        ),
                      ),
                    ),   
                    Expanded(child: fillblank(description, 'Mô tả thông tin bệnh hoặc vấn đề', )),   
                    Expanded(child: fillblank(doctorID, 'Mã số bác sĩ', )),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    try{
                      findFitDoctor(doctorID,description.text,choosenTime);
                    } // Đóng dialog
                    catch(e){
                      showErorrFlushBar(context, '$e');
                    }
                  },
                  child: const Text(
                    'Tìm bác sĩ phù hợp',
                    style: TextStyle(color: textBlackColor, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    kAppointments[choosenTime] ??= [];
                    if( !allDoctors.containsKey(doctorID.text) ){
                      showErorrFlushBar(context, 'Không có bác sĩ mang ID này');
                    }
                    else if( !allPatient.containsKey(patientID.text)){
                      showErorrFlushBar(context, 'Không có bệnh nhân mang ID này');
                    }
                    else{
                      try{
                        setState(() {
                          kAppointments[choosenTime]?.add(
                            Appoinment(
                              appoinmentID: newestID, 
                              doctorID: doctorID.text, 
                              patientID: patientID.text, 
                              dateTime: choosenTime,
                              hasPass: false,
                            )
                          );
                          if( newestID == 'CH${'${appoinmentLastestID+1}'.padLeft(6,'0')}' ){
                            appoinmentLastestID++;
                          }
                          Navigator.pop(context); 
                          showCompleteFlushBar(context, 'Thêm cuộc hẹn thành công');
                        });
                      }
                      catch(e){
                        showErorrFlushBar(context, '$e');
                      }
                    }
                  },
                  child: const Text(
                    'Lưu',
                    style: TextStyle(color: textBlackColor, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Đóng dialog
                  },
                  child: const Text(
                    'Hủy',
                    style: TextStyle(color: textBlackColor, fontSize: 18),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void viewAppoinment(Appoinment appoinment){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Thông tin về cuộc hẹn này'),
          backgroundColor: whiteGreenBackground,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: showNoChangeInfoContainer('Mã số bác sĩ', appoinment.doctorID)),
                      const SizedBox(width: defaultPadding,),
                      Expanded(child: showNoChangeInfoContainer('Mã số bệnh nhân', appoinment.patientID))
                    ],
                  ),
                  Expanded(child: 
                    Text(
                      DateFormat('HH:mm dd/MM/yyyy').format(appoinment.dateTime),
                      style: const TextStyle( fontSize: 25 ),
                    )
                  ),
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
                        ...appoinment.payedBill!.medicinePairs
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
                    Text('Tổng đã thanh toán ${appoinment.payedBill!.getTotalPrice()}',
                    style: const TextStyle(fontSize: 30),)
                ]
              )
                  ,
          ),
          actions: [
            TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Đóng dialog
                  },
                  child: const Text(
                    'Thoát',
                    style: TextStyle(color: textBlackColor, fontSize: 18),
                  ),
                ),
          ],
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  /// Lấy danh sách các cuộc hẹn cho một ngày cụ thể
  List<Appoinment> _getEventsForDay(DateTime day) {
    return kAppointments[day] ?? [];
  }
  /// Xử lý khi một ngày được chọn 
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  late int _selectedIndex = 0;

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
              if (index == 0) {
                Navigator.pushNamed(context, MainScreen.routeName);
              }
              if(index == 1){
                addAnAppointment();
              }
            },
            backgroundColor: lightGreenBackground,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.arrow_circle_left_outlined),
                selectedIcon: Icon(Icons.arrow_circle_left_outlined),
                label: Text('Quay lại'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_circle),
                selectedIcon: Icon(Icons.add_circle),
                label: Text('Thêm'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings),
                label: Text('Cài đặt'),
              ),
            ],
          ),
          const SizedBox(width: defaultPadding),
          Expanded(
            child: Column(
              children: [
                TableCalendar<Appoinment>(
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    weekendStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    dowTextFormatter: (date, locale) {
                      return daysInVietnamese[date.weekday - 1];
                    },
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    decoration: BoxDecoration(
                      color: lightGreenBackground,
                      borderRadius: BorderRadius.circular(defaultPadding * 3),
                    ),
                    titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    titleTextFormatter: (date, locale) {
                      return monthsInVietnamese[date.month - 1];
                    },
                    formatButtonVisible: false,
                  ),
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: selectedColor,
                      shape: BoxShape.circle,
                    ),
                    defaultDecoration: BoxDecoration(
                      color: lightGreenBackground,
                      shape: BoxShape.circle,
                    ),
                    weekendDecoration: BoxDecoration(
                      color: weekendColor,
                      shape: BoxShape.circle,
                    ),
                    outsideDaysVisible: false,
                  ),
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: _onDaySelected,
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                Expanded(
                  child: ValueListenableBuilder<List<Appoinment>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: lightGreenBackground,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    subtitle: Text(value[index].appoinmentID),
                                    title: Text('${value[index]}'),
                                  ),
                                ),
                                //const Spacer(),
                                Expanded(
                                  child: ListTile( 
                                    title: Text('${'${value[index].dateTime.hour}'.padLeft(2,'0')} : ${'${value[index].dateTime.minute}'.padLeft(2,'0')}'),
                                   )
                                ),
                                //const Spacer(),
                                if( value[index].dateTime.isAfter(DateTime.now()) ) 
                                IconButton(
                                  onPressed: () => adjustAppoinment(value[index]), 
                                  icon: const Icon(Icons.edit_calendar)
                                )
                                else 
                                IconButton(
                                  onPressed: () => viewAppoinment(value[index]), 
                                  icon: const Icon(Icons.visibility)
                                )
                              ],
                            )
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: defaultPadding),
        ],
      ),
    );
  }
}