import 'package:beginapp01/OOP_material/doctor.dart';
import 'package:beginapp01/OOP_material/patient.dart';
import 'package:intl/intl.dart';
import 'package:beginapp01/OOP_material/appoinment.dart';
import 'package:beginapp01/Screens/main_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:beginapp01/const_color.dart';
import 'package:flutter/material.dart';
import 'package:beginapp01/ultis.dart';


class AppoinmentScreen extends StatefulWidget {
  static String routeName = 'AppointmentScreen';

  @override
  State<AppoinmentScreen> createState() => _AppoinmentScreenState();
}

class _AppoinmentScreenState extends State<AppoinmentScreen> {
  late final ValueNotifier<List<Appoinment>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  //METHOD CỦA APPOINTMENT
  DateTime choosenTime = DateTime.now();
  

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
  Future<void> _pickDate(DateTime dateTime) async {
    DateTime? pickedDate = await showDatePicker(
      helpText: 'Ngày đã chọn',
      context: context,
      initialDate: dateTime,
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
      dateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        dateTime.hour,
        dateTime.minute,
      );
    }
  }

  Future<void> _pickTime(DateTime dateTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      cancelText: 'Hủy',
      context: context,
      initialTime: TimeOfDay.fromDateTime(dateTime),
    );

    if (pickedTime != null) {
      dateTime = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }
  }
  void adjustAppoinment(Appoinment appoinment) {
    DateTime tempDateTime = appoinment.dateTime;
    final TextEditingController doctorID = TextEditingController(text: appoinment.doctorID);
    final TextEditingController patientID = TextEditingController(text: appoinment.patientID);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: whiteGreenBackground,
              content: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
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
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (states) {
                              if (states.contains(WidgetState.pressed)) {
                                return lightGreenBackground; // Khi nhấn
                              } else if (states.contains(WidgetState.disabled)) {
                                return Colors.grey; // Khi tắt
                              }
                              return lightGreenBackground; // Mặc định
                            },
                          ),
                        ),
                        onPressed: () {
                          _pickDate(tempDateTime);
                          _pickTime(tempDateTime);                          
                        },
                        child:  Text(
                        '${tempDateTime.hour.toString().padLeft(2, '0')} : '
                        '${tempDateTime.minute.toString().padLeft(2, '0')} '
                        '${tempDateTime.day.toString()}/${tempDateTime.month.toString()}/${tempDateTime.year.toString()}',
                          style: const TextStyle(color: textBlackColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  

  void showAppoinment(Appoinment appoinment){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const  Text('Thông tin về cuộc hẹn này'),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
            ),
          ),
        );
      },
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
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  children: [
                    Row(
                      children: [
                        fillblank(doctorID, 'Mã số bác sĩ'),
                        fillblank(patientID, 'Mã số bệnh nhân'),
                      ],
                    ),
                    const SizedBox(height: defaultPadding,),
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
                      kAppointments[choosenTime]?.add(
                        Appoinment(
                        appoinmentID: doctorID.text, 
                        doctorID: doctorID.text, 
                        patientID: patientID.text, 
                        dateTime: choosenTime,
                        )
                      );
                      
                      Navigator.pop(context);
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

  /// Lấy danh sách các cuộc hẹn trong một khoảng ngày
  List<Appoinment> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
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

  /// Xử lý khi một khoảng ngày được chọn
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
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
                  onRangeSelected: _onRangeSelected,
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
                            height: MediaQuery.of(context).size.height*0.1,
                            width: MediaQuery.of(context).size.width*0.1,
                            decoration: BoxDecoration(
                              color: lightGreenBackground,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(defaultPadding),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: defaultPadding,),
                                Expanded(
                                  flex: 2,
                                  child: showAppoinmentInfo(value[index].appoinmentID, '${value[index]}'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text(
                                      '${value[index].dateTime.hour.toString().padLeft(2, '0')} : '
                                      '${value[index].dateTime.minute.toString().padLeft(2, '0')}',
                                    ),
                                  ),
                                ),
                                if (value[index].dateTime.isAfter(DateTime.now()))
                                  IconButton(
                                    //THAY ĐỔI THÔNG TIN
                                    onPressed: () => adjustAppoinment(value[index]),
                                    icon: const Icon(Icons.edit_calendar),
                                  )
                                else
                                  IconButton(
                                    // CHỈ XEM ĐƯỢC THÔNG TIN
                                    onPressed: () => showAppoinment(value[index]), 
                                    icon: const Icon(Icons.visibility),
                                  ),
                              ]

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
