import 'package:beginapp01/Screens/login_screen.dart';
import 'package:beginapp01/const_color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  
  static String routeName ='SplashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this
    );
    //move to login screen after 5s 
    Future.delayed(const Duration(seconds: 4), (){
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, LoginScreen.routeName);
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
                  'assets/lottie/splash_animation.json',
                  width: 500,
                  height: 500,
                  fit: BoxFit.cover,
                  controller: _controller,
                  onLoaded: (composition){
                    _controller.forward();
                  }
            ),
            const Text(
              'BỆNH VIỆN BEELZEBUB',
              style: (
                TextStyle(
                  fontFamily: 'UTM',
                  fontSize: 84,
                  letterSpacing: 15,
                  fontWeight: FontWeight.w200,
                  color: mediumGreenBackground,
                )
              ),
            )
          ],
        )
      ),
    );
  }
}