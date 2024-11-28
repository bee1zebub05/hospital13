import 'package:beginapp01/Screens/appoinment_screen.dart';
//import 'package:beginapp01/Screens/bill_screen.dart';
import 'package:beginapp01/Screens/doctor_screen.dart';
import 'package:beginapp01/Screens/login_screen.dart';
import 'package:beginapp01/Screens/pharmacy_screen.dart';
import 'package:beginapp01/Screens/main_screen.dart';
import 'package:beginapp01/Screens/patient_screen.dart';
import 'package:beginapp01/Screens/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName : (context) => SplashScreen(),
  MainScreen.routeName : (context) => MainScreen(),
  DoctorScreen.routeName : (context) => const DoctorScreen(),
  PatientScreen.routeName : (context) => const PatientScreen(),
  AppoinmentScreen.routeName : (context) => const AppoinmentScreen(),
  //BillScreen.routeName : (context) => BillScreen(),
  PharmacyScreen.routeName : (context) => PharmacyScreen(),
  LoginScreen.routeName : (context) => LoginScreen(),
};