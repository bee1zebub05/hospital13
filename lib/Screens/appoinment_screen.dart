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
          content: Container(
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
  
  void addAnAppointment() {
    final TextEditingController doctorID = TextEditingController();
    final TextEditingController patientID = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: const Text('Thêm một cuộc hẹn mới'),
              backgroundColor: whiteGreenBackground,
              content: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: fillblank(doctorID, 'Mã số bác sĩ' )),
                        Expanded(child: fillblank(patientID, 'Mã số bệnh nhân', )),
                        Expanded(child: showAddingID('Mã số cuộc họp ', 2)),
                      ],
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
                  ],
                ),
              ),
              actions: [
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
                                    onTap: () => print('${value[index]}'),
                                    title: Text('${value[index]}'),
                                  ),
                                ),
                                //const Spacer(),
                                Expanded(
                                  child: ListTile( 
                                    title: Text('${value[index].dateTime.hour}'.padLeft(2,'0') + ' : ' +
                                    '${value[index].dateTime.minute}'.padLeft(2,'0')),
                                   )
                                ),
                                //const Spacer(),
                                IconButton(
                                  onPressed: () => adjustAppoinment(value[index]), 
                                  icon: const Icon(Icons.edit_calendar)
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