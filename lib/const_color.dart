import "package:another_flushbar/flushbar.dart";
import "package:beginapp01/OOP_material/doctor.dart";
import "package:beginapp01/OOP_material/patient.dart";
import "package:beginapp01/OOP_material/person.dart";
import "package:flutter/material.dart";

const daysInVietnamese = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
const monthsInVietnamese = ['Tháng Một','Tháng Hai','Tháng Ba','Tháng Tư','Tháng Năm','Tháng Sáu','Tháng Bảy','Tháng Tám','Tháng Chín','Tháng Mười','Tháng Mười Một','Tháng Mười Hai',];

Map <String,String> loginAccount = {
  'nguyenlekhanh13@gmail.com' : 'nguyendz123',
  '1@2.com' : '1',
};

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false; // Luôn luôn không cho phép focus
}
String newestID = "";
Container showAddingID(String label, int type){
  //TẠO ID MỚI CHO 1 PATIENT
  if( type == 0){
    List<bool> check=List.filled(patientLastestID+1, false);
    for( var patient in allPatient.values ){
      check[int.parse(patient.patientID.substring(2))] = true;
    }
    int latestID = patientLastestID;
    for(int i = 1 ; i < check.length ; i++){
      if( !check[i] ){
        latestID = i;
        break;
      }
    } 
    newestID = 'BN${'$latestID'.padLeft(6,'0')}';
    if( newestID == 'BN${'$patientLastestID'.padLeft(6,'0')}' ){
      newestID = 'BN${'${patientLastestID+1}'.padLeft(6,'0')}';
    }
  }
  //TẠO 1 ID MỚI CHO DOCTOR
  else{
    List<bool> check=List.filled(doctorLastestID+1, false);
    for( var doctor in allDoctors.values ){
      check[int.parse(doctor.IDWorker.substring(2))] = true;
    }
    int latestID = doctorLastestID;
    for(int i = 1 ; i < check.length ; i++){
      if( !check[i] ){
        latestID = i;
        break;
      }
    } 
    newestID = 'DT${'$latestID'.padLeft(6,'0')}';
    if( newestID == 'DT${'$doctorLastestID'.padLeft(6,'0')}' ){
      newestID = 'DT${'${doctorLastestID+1}'.padLeft(6,'0')}';
    }
  }
  return Container(
    decoration: BoxDecoration(
      color: lightGreenBackground,
      borderRadius: BorderRadius.circular(defaultPadding*2)
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        readOnly: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: newestID,
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      )
      ),
  );
}

TextField showAppoinmentInfo(String label, String s){
  return TextField(
        focusNode: AlwaysDisabledFocusNode(),
        readOnly: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: s,
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      );
}

Container showID(String label,String id){
  return Container(
    decoration: BoxDecoration(
      color: lightGreenBackground,
      borderRadius: BorderRadius.circular(defaultPadding*2)
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        readOnly: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: id,
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      )
      ),
    );
}

Container fillblank(final TextEditingController _controller, String s) {
  return Container(
    decoration: BoxDecoration(
      color: lightGreenBackground,
      borderRadius: BorderRadius.circular(defaultPadding*2)
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: s,
          border: const UnderlineInputBorder(),
        ),
      ),
    ),
  );
}

Container adjustGenderDropdown(GenderEnum selectedGender) {
  return Container(
    decoration: BoxDecoration(
      color: lightGreenBackground,
      borderRadius: BorderRadius.circular(defaultPadding * 2),
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: DropdownButton<GenderEnum>(
        value: selectedGender,
        isExpanded: true,
        onChanged: (GenderEnum? value) {
          
        } ,
        items: GenderEnum.values.map((GenderEnum gender) {
          return DropdownMenuItem<GenderEnum>(
            value: gender,
            child: Text(
              genderToString(gender),
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
        underline: const SizedBox(), // Loại bỏ gạch dưới
      ),
    ),
  );
}

String genderToString(GenderEnum gender) {
  switch (gender) {
    case GenderEnum.male:
      return 'Nam';
    case GenderEnum.female:
      return 'Nữ';
    case GenderEnum.other:
      return 'Khác';
  }
}

Container adjustblank(final TextEditingController _controller, String label, String init) {
  _controller.text = init;
  return Container(
    decoration: BoxDecoration(
      color: lightGreenBackground,
      borderRadius: BorderRadius.circular(defaultPadding*2)
    ),
    child: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //hintText: init,
          border: const UnderlineInputBorder(),
        ),
      ),
    ),
  );
}


void showCompleteFlushBar(BuildContext context, String title){
  Flushbar(
    backgroundColor: lightGreenBackground,
    duration: Duration(seconds: 2),
    title: 'Thông báo:',
    titleSize: 24,
    titleColor: textBlackColor,
    messageSize: 24,
    message: title,
    messageColor: textBlackColor,
    icon: const Icon(
      Icons.assignment_turned_in,
      size: 28,
      color: textBlackColor,
    ),
    flushbarPosition: FlushbarPosition.BOTTOM,
  ).show(context);
}

void showErorrFlushBar(BuildContext context, String title){
  Flushbar(
    backgroundColor: selectedColor,
    duration: Duration(seconds: 3),
    title: 'Lỗi',
    titleSize: 24,
    titleColor: textBlackColor,
    messageSize: 24,
    message: title,
    messageColor: textBlackColor,
    icon: const Icon(
      Icons.warning_amber_rounded,
      size: 28,
      color: Colors.yellow,
    ),
    flushbarPosition: FlushbarPosition.BOTTOM,
  ).show(context);
}


const Color selectedColor = Color(0xFFF26D3D);
const Color weekendColor = Color(0xFFFFC8C4);
const Color veryGreenBackground = Color(0xFF023336);
const Color mediumGreenBackground = Color(0xFF4DA674);
const Color lightGreenBackground = Color(0xFFC1E6BA);
const Color whiteGreenBackground = Color(0xFFEAF8E7);

const Color textBlackColor = Color(0xFF313131);
const Color textWhiteColor = Color(0xFFFFFFFF);

const Color errorBorderColor = Color(0xFFE74C3C);

const double defaultPadding = 20.0;

const String mobilePattern = r'^(0[0-9]{9,})$';
const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';