import 'package:beginapp01/Screens/appoinment_screen.dart';
import 'package:beginapp01/Screens/doctor_screen.dart';
import 'package:beginapp01/Screens/patient_screen.dart';
import 'package:beginapp01/const_color.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  static String routeName ='MainScreen';  

  @override
  State<MainScreen> createState() => _MainScreenState();
}

String _getImageName(int index){
  switch (index){
    case 0: return 'Dashboard';
    case 1: return 'Doctors';
    case 2: return 'Appoinments';
    case 3: return 'Patients';
    case 4: return 'Diagnosis';
    case 5: return 'Prescription';
    case 6: return 'Medical Store';
    case 7: return 'Accounts';
  }
  return 'Reports';
}

Image _getImage(int index){
  switch (index){
    case 0: return Image.asset('assets/images/dashboard.png' , width: 150, height: 150,);
    case 1: return Image.asset('assets/images/doctor.png', width: 150, height: 150,);
    case 2: return Image.asset('assets/images/appoinment.png', width: 150, height: 150,);
    case 3: return Image.asset('assets/images/patient.png', width: 150, height: 150,);
    case 4: return Image.asset('assets/images/diagnosis.png', width: 150, height: 150,);
    case 5: return Image.asset('assets/images/prescription.png', width: 150, height: 150,);
    case 6: return Image.asset('assets/images/pharmacy.png', width: 150, height: 150,);
    case 7: return Image.asset('assets/images/money-bag.png', width: 150, height: 150,);
  }
  return Image.asset('assets/images/report.png', width: 150, height: 150,);
}

class _MainScreenState extends State<MainScreen> {
  void _getNewScreen(int index){
    switch (index){
    //case 0: return 'Dashboard';
    case 1: Navigator.pushNamed(context, DoctorScreen.routeName);
    case 2: Navigator.pushNamed(context, AppoinmentScreen.routeName);
    case 3: Navigator.pushNamed(context, PatientScreen.routeName);
    //case 4: return 'Diagnosis';
    //case 5: return 'Prescription';
    //case 6: return 'Medical Store';
    //case 7: return 'Accounts';
    default : return null;
    }
  }   
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
              }
            },
            backgroundColor: lightGreenBackground, 
            destinations: const  [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_filled),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person), 
                label: Text('Profile'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width*0.93,
            height: MediaQuery.of(context).size.height*0.9,
            child: GridView.builder(
              padding: EdgeInsets.all(defaultPadding*2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: defaultPadding*4,
                mainAxisSpacing: defaultPadding*4,
                childAspectRatio: 1,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: lightGreenBackground,
                    borderRadius: BorderRadius.circular(defaultPadding*3),
                  ),
                  child: InkWell(
                    hoverColor: Colors.black.withOpacity(0) ,
                    onTap: (){
                      _getNewScreen(index);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: _getImage(index)
                          ),
                        Text(
                          _getImageName(index),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Spacer(),
          
        ],
      ),
    );
  }
}