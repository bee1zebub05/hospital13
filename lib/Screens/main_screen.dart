import 'package:beginapp01/OOP_material/appoinment.dart';
import 'package:beginapp01/OOP_material/doctor.dart';
import 'package:beginapp01/OOP_material/patient.dart';
import 'package:beginapp01/Screens/appoinment_screen.dart';
import 'package:beginapp01/Screens/doctor_screen.dart';
import 'package:beginapp01/Screens/patient_screen.dart';
import 'package:beginapp01/Screens/pharmacy_screen.dart';
import 'package:beginapp01/Screens/splash_screen.dart';
import 'package:beginapp01/const_color.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MainScreen extends StatefulWidget {
  static String routeName ='MainScreen';

  const MainScreen({super.key});  

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex = 0; // Lưu chỉ mục được chọn
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index; // Cập nhật chỉ mục được chọn
              });
              switch(index){
                case 0:
                  Navigator.pushNamed(context, MainScreen.routeName);
                  break;
                case 1:
                  Navigator.pushNamedAndRemoveUntil(context, SplashScreen.routeName, (route) => false);
                  break;
                case 2:
                  Navigator.pushNamedAndRemoveUntil(context, DoctorScreen.routeName, (route) => false);
                  break;
                case 3:
                  Navigator.pushNamedAndRemoveUntil(context, PatientScreen.routeName, (route) => false);
                  break;
                case 4:
                  Navigator.pushNamedAndRemoveUntil(context, AppoinmentScreen.routeName, (route) => false);
                  break;
                case 5:
                  Navigator.pushNamedAndRemoveUntil(context, PharmacyScreen.routeName, (route) => false); 
                  break;
                default: return;
              }
            },
            backgroundColor: const Color(0xFFC1E6BA), 
            destinations: const  [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_filled),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout),
                selectedIcon: Icon(Icons.logout), 
                label: Text('Profile'),
              ),
              NavigationRailDestination(
                icon: ImageIcon(AssetImage('assets/images/doctor.png'), size: 35,),
                selectedIcon: ImageIcon(AssetImage('assets/images/doctor.png')),
                label: Text('Doctors'),
              ),
              NavigationRailDestination(
                icon: ImageIcon(AssetImage('assets/images/patient.png'), size: 35,),
                selectedIcon: ImageIcon(AssetImage('assets/images/patient.png')),
                label: Text('Patients'),
              ),
              NavigationRailDestination(
                icon: ImageIcon(AssetImage('assets/images/appoinment.png'), size: 35,),
                selectedIcon: ImageIcon(AssetImage('assets/images/appoinment.png')),
                label: Text('Appoinment'),
              ),
              NavigationRailDestination(
                icon: ImageIcon(AssetImage('assets/images/pharmacy.png'), size: 35,), // Thêm icon Pharmacy
                selectedIcon: ImageIcon(AssetImage('assets/images/pharmacy.png')),
                label: Text('Pharmacy'),
              ),
            ],
          ),
          const Spacer(),
          analyzePart(context),
          const Spacer(),
        ],
      ),
    );
  }
}

SizedBox analyzePart(BuildContext context){  
  return SizedBox(
    width: MediaQuery.of(context).size.width*0.93,
    height: MediaQuery.of(context).size.width*0.9,
    child: const Column(
      children: [
         Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(defaultPadding/2),
            child: Row(
              children: [
                 ViewPatient(),
                 SizedBox(width: defaultPadding/2,),
                 ViewDoctor(),
                 SizedBox(width: defaultPadding/2,),
                 ViewAppoinment()
              ],
            ),
          )
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding/2),
            child: Row(
              children: [
                 PieChartExample(),
              ],
            ),
          ),
        ),
        
      ],
    )
  );
}

class PieChartExample extends StatefulWidget {
  const PieChartExample({super.key});

  @override
  State<PieChartExample> createState() => _PieChartExampleState();
}

class _PieChartExampleState extends State<PieChartExample> {
  double totalMoney(){
    double sum = 0;
    for(var name in specialityKeyWord.keys){
      for (var listAppoinment in kAppointments.entries){
        if(listAppoinment.key.isBefore(DateTime.now())){
          for(var appoinment in listAppoinment.value){
            if(allDoctors[appoinment.doctorID]!.speciality == name) {
              sum+=appoinment.payedBill!.getTotalPrice();
            }
          }
        }
      }
    }
    return sum;
  }
  /// Hàm cung cấp dữ liệu cho Pie Chart
  List<PieChartSectionData> _getSections() {
    int tmp = 0;
    List<PieChartSectionData> finalSection =[];
    for(var name in specialityKeyWord.keys){
      double sum = 0;
      for (var listAppoinment in kAppointments.entries){
        if(listAppoinment.key.isBefore(DateTime.now())){
          for(var appoinment in listAppoinment.value){
            if(allDoctors[appoinment.doctorID]!.speciality == name) {
              sum+=appoinment.payedBill!.getTotalPrice();
            }
          }
        }
      }
      finalSection.add(PieChartSectionData(
        color: pieColor[tmp%pieColor.length],
        value: sum,
        title: sum.toString(),
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ));
      tmp++;
    }
    return finalSection;
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: lightGreenBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(defaultPadding),
                        bottomLeft: Radius.circular(defaultPadding),
                      ), // Tùy chỉnh góc bo tròn
                    ),
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // ở giữa
                        Text(totalMoney().toString(), style:const TextStyle(color: textBlackColor, fontSize: 20,fontWeight: FontWeight.bold),),
                        /// pie chảrt..
                        PieChart(
                          duration: const Duration(milliseconds: 750),
                          PieChartData(
                            sections: _getSections(), // Dữ liệu cho Pie Chart
                            centerSpaceRadius: 80, // Khoảng trống ở giữa
                            borderData: FlBorderData(show: false), // Ẩn viền
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ]
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                      color: lightGreenBackground,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(defaultPadding),
                        bottomRight: Radius.circular(defaultPadding),
                      ), // Tùy chỉnh góc bo tròn
                    ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widgets,
              ),
            ),
          )
        ],
      ),
    );
  }
  
}

class ViewAppoinment extends StatefulWidget {
   const ViewAppoinment({
    super.key,
  });

  @override
  State<ViewAppoinment> createState() => _ViewAppoinmentState();
}

class _ViewAppoinmentState extends State<ViewAppoinment> {
  int passedBill=0;
  int totalBill= 0;
  
  @override
  Widget build(BuildContext context) {
    passedBill = 0; // Reset passedBill trước khi tính toán
    totalBill =0;
    for (var dateTime in kAppointments.keys) {
      totalBill+=kAppointments[dateTime]!.length;
      if (dateTime.isBefore(DateTime.now())) {
        passedBill+=kAppointments[dateTime]!.length;
      }
    }
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultPadding),
          color: lightGreenBackground,
        ),
        
        child: InkWell(
          onTap: () {
            setState(() {
              // Tính toán số lượng cuộc hẹn đã diễn ra
              passedBill = 0; // Reset passedBill trước khi tính toán
              totalBill =0;
              for (var dateTime in kAppointments.keys) {
                totalBill+=kAppointments[dateTime]!.length;
                if (dateTime.isBefore(DateTime.now())) {
                  passedBill+=kAppointments[dateTime]!.length;
                }
              }
            });
          },
          child: ListTile(
              leading: Image.asset('assets/images/appoinment.png',),
              title: Text('$passedBill/$totalBill'),
              titleTextStyle: const TextStyle(
                color: textBlackColor,
                fontSize: 60,
              ),
              subtitle: const Text('Số cuộc hẹn đã diễn ra'),
              subtitleTextStyle: const TextStyle(
                color: textBlackColor,
                fontSize: 15,
              ),
            ),
        ),
        
      )
    );
  }
}

class ViewDoctor extends StatefulWidget {
  const ViewDoctor({
    super.key,
  });

  @override
  State<ViewDoctor> createState() => _ViewDoctorState();
}

class _ViewDoctorState extends State<ViewDoctor> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultPadding),
          color: lightGreenBackground,
        ),
        child: ListTile(
            leading: Image.asset('assets/images/doctor.png',),
            title: Text('$doctorLastestID'),
            titleTextStyle: const TextStyle(
              color: textBlackColor,
              fontSize: 60,
            ),
            subtitle: const Text('Tổng số bác sĩ đang làm việc'),
            subtitleTextStyle: const TextStyle(
              color: textBlackColor,
              fontSize: 15,
            ),
          ),
        
      )
    );
  }
}

class ViewPatient extends StatefulWidget {
  const ViewPatient({
    super.key,
  });

  @override
  State<ViewPatient> createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatient> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultPadding),
          color: lightGreenBackground,
        ),
        child: ListTile(
            leading: Image.asset('assets/images/patient.png',),
            title: Text('$patientLastestID'),
            titleTextStyle: const TextStyle(
              color: textBlackColor,
              fontSize: 60,
            ),
            subtitle: const Text('Tổng số bệnh nhân đang quản lí'),
            subtitleTextStyle: const TextStyle(
              color: textBlackColor,
              fontSize: 15,
            ),
          ),
        
      )
    );
  }
}



