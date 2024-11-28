import 'package:beginapp01/OOP_material/patient.dart';
import 'package:beginapp01/OOP_material/person.dart';
import 'package:beginapp01/Screens/main_screen.dart';
//import 'package:beginapp01/Screens/bill_screen.dart';

import 'package:beginapp01/Screens/appointment_popup.dart';
import 'package:beginapp01/const_color.dart';
import 'package:flutter/material.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});
  static String routeName ='PatientScreen';

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  late int listType = 0;
  late bool listTypeReverse = false;
  final TextEditingController findController = TextEditingController();
  
  //METHOD LÀM VIỆC VỚI MAP LƯU CÁC Patient
  void addAPatient() {
    GenderEnum _selectedGender = GenderEnum.male;
    final TextEditingController firstName = TextEditingController();
    final TextEditingController lastName = TextEditingController();
    final TextEditingController age = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController address = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: const Text(
                'Thêm một bệnh nhân mới',
                style: TextStyle(color: textBlackColor),
              ),
              content: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      // Cột thứ nhất
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 7,
                        child: Column(
                          children: [
                            fillblank(lastName, 'Họ'),
                            const SizedBox(height: 10),
                            fillblank(age, 'Tuổi'),
                            const SizedBox(height: 10),
                            Container(
                                padding: const EdgeInsets.all(defaultPadding),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(defaultPadding*2),
                                ),
                                child: DropdownButton<GenderEnum>(
                                  dropdownColor: lightGreenBackground,
                                  borderRadius: BorderRadius.circular(defaultPadding*2),
                                  underline: Container(
                                    color: textBlackColor,
                                  ),
                                  value: _selectedGender,
                                  hint: const Text('Chọn giới tính'),
                                  isExpanded: true,
                                  items: GenderEnum.values.map((GenderEnum gender) {
                                    return DropdownMenuItem<GenderEnum>(
                                      value: gender,
                                      child: Text(genderToString(gender)),
                                    );
                                  }).toList(),
                                  onChanged: (GenderEnum? newValue) {
                                    setState(() {
                                      _selectedGender = newValue!; // Cập nhật giới tính
                                    });
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Cột thứ hai
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 7,
                        child: Column(
                          children: [
                            fillblank(firstName, 'Tên'),
                            const SizedBox(height: 10),
                            fillblank(phone, 'Số điện thoại'),
                            const SizedBox(height: 10),
                            fillblank(address, 'Quê quán'),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Cột thứ ba
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 7,
                        child: Column(
                          children: [
                            showAddingID('ID bệnh nhân', 0)
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    
                      allPatient[newestID] = Patient(
                        firstName: firstName.text,
                        lastName: lastName.text,
                        age: int.parse(age.text),
                        gender: _selectedGender,
                        phone: phone.text,
                        address: address.text,
                        patientID: newestID,);
                      if( newestID == 'BN${'${patientLastestID+1}'.padLeft(6,'0')}' ){
                        patientLastestID++;
                      }
                      showCompleteFlushBar(context, 'Thêm thành công');
                      Future.delayed(const Duration(seconds: 3), () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => PatientScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ),
                      );
                    });
                    
                  },
                  child: const Text(
                    'Lưu',
                    style: TextStyle(color: textBlackColor, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng dialog
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

  void adjustPatient(Patient patient) {
  GenderEnum _selectedGender = patient.gender; // Giới tính hiện tại
  String latestID = patient.patientID;

  final TextEditingController firstName = TextEditingController(text: patient.firstName);
  final TextEditingController lastName = TextEditingController(text: patient.lastName);
  final TextEditingController age = TextEditingController(text: patient.age.toString());
  final TextEditingController phone = TextEditingController(text: patient.phone);
  final TextEditingController address = TextEditingController(text: patient.address);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
            title: const Text(
              'Thông tin về bệnh nhân này',
              style: TextStyle(color: textBlackColor),
            ),
            content: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Cột thứ nhất
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 7,
                      child: Column(
                        children: [
                          adjustblank(lastName, 'Họ', patient.lastName),
                          const SizedBox(height: 10),
                          adjustblank(age, 'Tuổi', patient.age.toString()),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(defaultPadding*2),
                            ),
                            child: DropdownButton<GenderEnum>(
                              dropdownColor: lightGreenBackground,
                              borderRadius: BorderRadius.circular(defaultPadding*2),
                              underline: Container(
                                color: textBlackColor,
                              ),
                              value: _selectedGender,
                              hint: const Text('Chọn giới tính'),
                              isExpanded: true,
                              items: GenderEnum.values.map((GenderEnum gender) {
                                return DropdownMenuItem<GenderEnum>(
                                  value: gender,
                                  child: Text(genderToString(gender)),
                                );
                              }).toList(),
                              onChanged: (GenderEnum? newValue) {
                                setState(() {
                                  _selectedGender = newValue!; // Cập nhật giới tính
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Cột thứ hai
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 7,
                      child: Column(
                        children: [
                          adjustblank(firstName, 'Tên', patient.firstName),
                          const SizedBox(height: 10),
                          adjustblank(phone, 'Số điện thoại', patient.phone),
                          const SizedBox(height: 10),
                          adjustblank(address, 'Quê quán', patient.address),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Cột thứ ba
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 7,
                      child: Column(
                        children: [
                          showID('ID bệnh nhân', patient.patientID),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                    try {
                        allPatient[latestID]?.firstName = firstName.text;
                        allPatient[latestID]?.lastName = lastName.text;
                        allPatient[latestID]?.age = int.parse(age.text);
                        allPatient[latestID]?.gender = _selectedGender;
                        allPatient[latestID]?.phone = phone.text;
                        allPatient[latestID]?.address = address.text;
                        showCompleteFlushBar(context, 'Lưu thành công');
                        Future.delayed(const Duration(seconds: 3), () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => PatientScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return child;
                            },
                          ),
                        );
                      });

                    } catch (e) {
                      showErorrFlushBar(context, '$e');
                    }
                },
                child: const Text(
                  'Lưu',
                  style: TextStyle(color: textBlackColor, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    allPatient.remove(latestID);
                  });
                  showCompleteFlushBar(context, 'Xóa thành công');
                  Future.delayed(const Duration(seconds: 3), () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => PatientScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                    ),
                  );
                });
                },
                child: const Text(
                  'Xóa bệnh nhân',
                  style: TextStyle(color: textBlackColor, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng dialog
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

  void searchPatient(){
    findController.text = "";
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height*0.25,
            width: MediaQuery.of(context).size.width*0.25,
            child: Container(
              decoration: BoxDecoration(
                color: lightGreenBackground,
                borderRadius: BorderRadius.circular(defaultPadding*2)
              ),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: TextField(
                  controller: findController,
                  decoration: const InputDecoration(
                    labelText: 'Nội dung cần tìm',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if( findController.text == "" ){
                  Navigator.of(context).pop();
                }
                else{
                  listType = 7;
                  Navigator.of(context).pop();
                }
                });
              },
              child: const Text(
                'Tìm',
                style: TextStyle(color: textBlackColor, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text(
                'Hủy',
                style: TextStyle(color: textBlackColor, fontSize: 18),
              ),
            ),
          ],
        );
      });
  }
  @override
  
  Widget build(BuildContext context) {
    //Định dạng các text trong một hàng
    Container headTableText(String s, int newType){
      return Container(
        width: MediaQuery.of(context).size.width*0.11,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              //color: veryGreenBackground,
              width: MediaQuery.of(context).size.width*0.08,
              child: Text(
                s,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              //color: veryGreenBackground,
              width: MediaQuery.of(context).size.width*0.03,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if(listType == newType) listTypeReverse = !listTypeReverse;
                    listType = newType;
                  });
                },
                icon: const Icon(Icons.arrow_downward_sharp),
              ),
            ),
            //Spacer(),
          ],
        ),
      );
    }
    Container tableText(String s){
      return Container(
        width: MediaQuery.of(context).size.width*0.08,
        child: Text(
          s,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

   //show 1 hàng Patient
    Container _showAPatients(int index , int listType, List<MapEntry<String,Patient>> entries, String key, Patient patient) {
    return Container(
                      decoration: BoxDecoration(
                        color: lightGreenBackground,
                        borderRadius: BorderRadius.circular(defaultPadding*3),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                  Image.asset(
                                    'assets/images/patient.png',
                                    width: MediaQuery.of(context).size.width*0.1,
                                    height: MediaQuery.of(context).size.height * 0.1,
                                  ),
                                  tableText(patient.patientID ),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(patient.lastName ),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(patient.firstName ),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(patient.phone),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(patient.address),
                                  const SizedBox(width: defaultPadding,),IconButton(
                onPressed: () => adjustPatient(patient),
                icon: const Icon(Icons.edit)),
           IconButton(
  onPressed: () {
    // Mở popup hiển thị danh sách cuộc hẹn và nút Hóa đơn
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppointmentPopup(patientID: patient.patientID);
      },
    );
  },
  icon: Icon(Icons.calendar_today),
)
,
            const SizedBox(
              width: defaultPadding,
            ),
                          ],
                      ),
                    );
  }

    late int _selectedIndex = 0;
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
                case 1:
                  searchPatient();
                case 2:
                  addAPatient();
              }
            },
            backgroundColor: lightGreenBackground, 
            destinations: const  [
              NavigationRailDestination(
                icon: Icon(Icons.arrow_circle_left_outlined),
                selectedIcon: Icon(Icons.arrow_circle_left_outlined),
                label: Text('arrow_circle_left_outlined'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search_sharp),
                selectedIcon: Icon(Icons.search_sharp), 
                label: Text('Profile'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_circle),
                selectedIcon: Icon(Icons.add_circle),
                label: Text('Add'),
              ),
            ],
          ),
          const Spacer(),
          Container(
            color: whiteGreenBackground,
            width: MediaQuery.of(context).size.width*0.93,
            height: MediaQuery.of(context).size.height*0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: lightGreenBackground,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              listType = 0;
                            });
                          },
                          child: Image.asset(
                            'assets/images/reset.png',
                            width: MediaQuery.of(context).size.width*0.1,
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                        ),
                        headTableText('MÃ SỐ BỆNH NHÂN' ,1),
                        const SizedBox(width: defaultPadding,),
                        headTableText('HỌ' ,2),
                        const SizedBox(width: defaultPadding,),
                        headTableText('TÊN' ,3),
                        const SizedBox(width: defaultPadding,),
                        headTableText('SDT' ,4),
                        const SizedBox(width: defaultPadding,),
                        headTableText('QUÊ QUÁN' ,5),
                        const SizedBox(width: defaultPadding,),
                        const Icon(Icons.visibility),
                        const SizedBox(width: defaultPadding,),
                ],
                    ),
                  ),
                ),
                Expanded( // Giới hạn ListView.builder trong phần không gian còn lại
                  child: listViewType(_showAPatients),
                ),
              ],
            )
          ),
          const Spacer(),
        ],
      ),
    );
  }

  ListView listViewType(Container _showAPatients(int index, int listType, List<MapEntry<String,Patient>> entries, String key, Patient patient)) {
    List<MapEntry<String,Patient>> entries = allPatient.entries.toList();
    switch (listType){
      // 0 mặc định
      // 1 sort theo ID
      // 2 sort theo Họ
      // 3 sort theo tên
      // 4 sort theo SDT
      // 5 sort theo quê quán
      // 7 sort theo controller searchController
      case 1: setState(() {
        entries = allPatient.entries.toList();
        entries.sort((a,b){
          int result = a.value.patientID.compareTo(b.value.patientID);;
          return listTypeReverse ? result : -result;
        });
      });
      case 2: setState(() {
        entries = allPatient.entries.toList();
        entries.sort((a,b){
          int result = a.value.lastName.compareTo(b.value.lastName);
          return listTypeReverse ? result : -result;
        });
      });
      case 3: setState(() {
        entries = allPatient.entries.toList();
        entries.sort((a,b){
          int result = a.value.firstName.compareTo(b.value.firstName);
          return listTypeReverse ? result : -result;
        });
      });
      case 4: setState(() {
        entries = allPatient.entries.toList();
        entries.sort((a,b){
          int result =a.value.phone.compareTo(b.value.phone);
          return listTypeReverse ? result : -result;
        });
      });
      case 5: setState(() {
        entries = allPatient.entries.toList();
        entries.sort((a,b){
          int result = a.value.address.compareTo(b.value.address);
          return listTypeReverse ? result : -result;
        });
      });
      case 7: setState(() {
        entries = allPatient.entries.toList();
        List<MapEntry<String,Patient>> findEntries =[] ;
        for (var entry in entries) {
          Patient tmp = entry.value;
          String needToFind = tmp.patientID + tmp.lastName + tmp.firstName 
          + tmp.phone + tmp.address ;
          if( needToFind.contains(findController.text) ){
            findEntries.add(entry);
          }
        }
        entries = findEntries;
      });
      default: entries = allPatient.entries.toList();;
    }
    return ListView.separated(
                  padding: const EdgeInsets.all(defaultPadding),
                  itemCount: entries.length, // Tổng số phần tử
                  itemBuilder: (context, index) {
                    String key = entries[index].key;
                    Patient patient = allPatient[key]!;
                    return _showAPatients(index, listType,entries,key,patient);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 12.0)
                );
  }
}