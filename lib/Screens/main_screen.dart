import 'package:beginapp01/Screens/appoinment_screen.dart';
import 'package:beginapp01/Screens/doctor_screen.dart';
import 'package:beginapp01/Screens/patient_screen.dart';
import 'package:beginapp01/Screens/pharmacy_screen.dart';
import 'package:beginapp01/Screens/splash_screen.dart';
import 'package:beginapp01/const_color.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static String routeName ='MainScreen';  

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
                  Navigator.pushNamedAndRemoveUntil(context, PharmacyScreen.routeName, (route) => false); // Chuyển đến PharmacyScreen
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
          Container(
            width: MediaQuery.of(context).size.width*0.93,
            height: MediaQuery.of(context).size.height*0.9,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
