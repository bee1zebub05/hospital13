import 'package:beginapp01/Screens/main_screen.dart';
import 'package:beginapp01/const_color.dart';
import 'package:flutter/material.dart';

late bool _passwordVisible;

class LoginScreen extends StatefulWidget {
  static String routeName ='LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState(){
    super.initState();
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/login.png',
                    width: 150,
                    height: 150,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Xin chào,',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w100,
                          color: textBlackColor,
                        ),
                      ),
                      Text(
                        'Ngài Quản Lí',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: textBlackColor,
                        ),
                      ),
                    ],
                  ),
                  const Text('Đăng nhập để tiếp tục', style: TextStyle(
                    fontSize: 20,
                  ), ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5, // Chiếm 50% màn hình
                decoration: BoxDecoration(
                  color: lightGreenBackground,
                  borderRadius: BorderRadius.circular(defaultPadding*2)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Form(
                        child: Column(
                          children: [
                            buildEmailField(),
                            const SizedBox(height: defaultPadding),
                            buildPasswordField(),
                            const SizedBox(height: defaultPadding),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding,),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.25,
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration:  BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          //whiteGreenBackground,
                          lightGreenBackground,
                          mediumGreenBackground,
                          //veryGreenBackground,
                        ],
                        begin: Alignment.bottomLeft, 
                        end: Alignment.topRight, 
                        stops: [0, 1],
                        tileMode: TileMode.clamp, 
                      ),
                      borderRadius: BorderRadius.circular(defaultPadding*3)
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        Text('ĐĂNG NHẬP',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: (){
                            Navigator.pushNamed(context, MainScreen.routeName);
                          }, 
                          icon: Icon(Icons.arrow_circle_right),
                          iconSize: 35,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
                          obscureText: !_passwordVisible,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(
                            color: textBlackColor, fontSize: 28,
                            fontWeight: FontWeight.w300,
                          ) ,
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  _passwordVisible = !_passwordVisible;                                    
                                });
                              }, 
                              icon: Icon(
                                _passwordVisible ? Icons.visibility_off_outlined :
                                Icons.visibility
                              ),
                              iconSize: defaultPadding,
                            )
                          ),
                        );
  }

  TextFormField buildEmailField() {
    return TextFormField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            color: textBlackColor, fontSize: 28,
                            fontWeight: FontWeight.w300,
                          ) ,
                          decoration: const InputDecoration(
                            labelText: 'Gmail hoặc số điện thoại',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                          ),
                          //kiểm tra gmail đăng nhập hợp lệ
                          validator: (value){
                            RegExp regExp = new RegExp(emailPattern);
                            if( value == null || value.isEmpty ){
                              return 'Hãy nhập Gmail';
                            }
                            else if( !regExp.hasMatch(value) ){
                              return 'Hãy nhập một Gmail hợp lệ';
                            }
                            return null;
                          },
                        );
  }
}