import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:beginapp01/Screens/splash_screen.dart';
import 'package:beginapp01/const_color.dart';
import 'package:beginapp01/routes.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const HospitalApp());
}


class HospitalApp extends StatelessWidget {
  const HospitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', 'US'), // Tiếng Anh
        Locale('vi', 'VN'), // Tiếng Việt
      ],
      locale: const Locale('vi', 'VN'), // Đặt ngôn ngữ mặc định là tiếng Việt
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
         // Thêm localizations tùy chỉnh
      ],
      theme: ThemeData.light().copyWith(
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: selectedColor,
          contentTextStyle:TextStyle(
            color: textBlackColor,
            fontSize: 17,
            height: 0.5,
          ), 
        ),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: lightGreenBackground,
        ),
        timePickerTheme: const TimePickerThemeData(
          backgroundColor: lightGreenBackground,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          
          labelStyle: TextStyle(
            //fontFamily: 'ComicsSan',
            color: textBlackColor,
            fontSize: 15,
            height: 0.5,
          ),
          hintStyle: TextStyle(
            color: textBlackColor,
            fontSize: 17,
            height: 0.5,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: textBlackColor,
              width: 2,
            )
          ),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
              color: errorBorderColor,
              width: 2,
            )
          ),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
              color: errorBorderColor,
              width: 2,
            )
          ),
        ),
        scaffoldBackgroundColor: whiteGreenBackground,
        primaryColor: mediumGreenBackground,
        
      ),

      //first screen ever
      initialRoute: SplashScreen.routeName,
      
      //define routes to access anywhere over the app
      routes: routes,

    );
  }
}

