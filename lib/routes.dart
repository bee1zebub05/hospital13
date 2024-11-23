import 'package:beginapp01/Screens/appoinment_screen.dart';
import 'package:beginapp01/Screens/doctor_screen.dart';
import 'package:beginapp01/Screens/login_screen.dart';
import 'package:beginapp01/Screens/main_screen.dart';
import 'package:beginapp01/Screens/patient_screen.dart';
import 'package:beginapp01/Screens/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName : (context) => SplashScreen(),
  LoginScreen.routeName : (context) => LoginScreen(),
  MainScreen.routeName : (context) => MainScreen(),
  DoctorScreen.routeName : (context) => DoctorScreen(),
  PatientScreen.routeName : (context) => PatientScreen(),
  AppoinmentScreen.routeName : (context) => AppoinmentScreen(),
};