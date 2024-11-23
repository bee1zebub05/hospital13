import 'package:beginapp01/OOP_material/patient.dart';
import 'package:beginapp01/OOP_material/person.dart';
import 'package:beginapp01/Screens/main_screen.dart';
import 'package:beginapp01/const_color.dart';
import 'package:flutter/material.dart';

Container _fillblank(final TextEditingController _controller, String s) {
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

Container _adjustblank(final TextEditingController _controller, String label, String init) {
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
  //METHOD LÀM VIỆC VỚI MAP LƯU CÁC DOCTOR
  void addAPatient() {
    final TextEditingController firstName = TextEditingController();
    final TextEditingController lastName = TextEditingController();
    final TextEditingController age = TextEditingController();
    final TextEditingController gender = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController address = TextEditingController();
    final TextEditingController patientID = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                        _fillblank(lastName, 'Họ'),
                        const SizedBox(height: 10),
                        _fillblank(age, 'Tuổi'),
                        const SizedBox(height: 10),
                        _fillblank(gender, 'Giới Tính'),
                      ],
                    ),
                  ),
                  Spacer(),
                  // Cột thứ hai
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Column(
                      children: [
                        _fillblank(firstName, 'Tên'),
                        const SizedBox(height: 10),
                        _fillblank(phone, 'Số điện thoại'),
                        const SizedBox(height: 10),
                        _fillblank(address, 'Quê quán'),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Cột thứ ba
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Column(
                      children: [
                        _fillblank(patientID, 'Mã bệnh nhân'),
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
                setState(() {
                  allPatient[patientID.text] = Patient(
                    firstName: firstName.text,
                    lastName: lastName.text,
                    age: int.parse(age.text),
                    gender: GenderEnum.male,
                    phone: phone.text,
                    address: address.text,
                    patientID: patientID.text,
                  );
                });
                Navigator.of(context).pop(); // Đóng dialog
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
  }
  void adjustPatient(Patient patient) {
    String latestID = patient.patientID;
    final TextEditingController firstName = TextEditingController();
    final TextEditingController lastName = TextEditingController();
    final TextEditingController age = TextEditingController();
    final TextEditingController gender = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController address = TextEditingController();
    final TextEditingController patientID = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                        _adjustblank(lastName, 'Họ', patient.getLastName()),
                        const SizedBox(height: 10),
                        _adjustblank(age, 'Tuổi', patient.getAge().toString()),
                        const SizedBox(height: 10),
                        _adjustblank(gender, 'Giới Tính' ,patient.getGender().toString()),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Cột thứ hai
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Column(
                      children: [
                        _adjustblank(firstName, 'Tên',patient.getFirstName()),
                        const SizedBox(height: 10),
                        _adjustblank(phone, 'Số điện thoại',patient.getPhone()),
                        const SizedBox(height: 10),
                        _adjustblank(address, 'Quê quán',patient.getAddress()),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Cột thứ ba
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Column(
                      children: [
                        _adjustblank(patientID, 'Mã nhân viên',patient.patientID),
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
                setState(() {
                  if (patientID.text != latestID){
                    allPatient.remove(latestID);
                    allPatient[patientID.text] = Patient(
                      firstName: firstName.text,
                      lastName: lastName.text,
                      age: int.parse(age.text),
                      gender: GenderEnum.male,
                      phone: phone.text,
                      address: address.text,
                      patientID: patientID.text,
                    );
                  }
                  else{
                    allPatient[patientID.text] = Patient(
                      firstName: firstName.text,
                      lastName: lastName.text,
                      age: int.parse(age.text),
                      gender: GenderEnum.male,
                      phone: phone.text,
                      address: address.text,
                      patientID: patientID.text,
                    );
                  }
                });
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text(
                'Lưu',
                style: TextStyle(color: textBlackColor, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: (){
                setState(() {
                  allPatient.remove(latestID);
                });
                Navigator.of(context).pop(); // Đóng dialog
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
                //print(findController.text);
                setState(() {
                  if( findController.text == "" ){
                  Navigator.of(context).pop();
                }
                else{
                  listType = 6;
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

   //show 1 hàng doctor
    Container _showApatients(int index , int listType, List<MapEntry<String,Patient>> entries, String key, Patient patient) {
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
                                  tableText(patient.getLastName() ),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(patient.getFirstName() ),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(patient.getPhone()),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(patient.getAddress()),
                                  const SizedBox(width: defaultPadding,),
                                  IconButton(
                                    onPressed: () => adjustPatient(patient), 
                                    icon: const Icon(Icons.edit)
                                  ),
                                  const SizedBox(width: defaultPadding,),
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
                label: Text('Back'),
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
                  child: listViewType(_showApatients),
                ),
              ],
            )
          ),
          const Spacer(),
        ],
      ),
    );
  }

  ListView listViewType(Container _showApatients(int index, int listType, List<MapEntry<String,Patient>> entries, String key, Patient patient)) {
    List<MapEntry<String,Patient>> entries = allPatient.entries.toList();
    switch (listType){
      // 0 mặc định
      // 1 sort theo ID
      // 2 sort theo Họ
      // 3 sort theo tên
      // 4 sort theo SDT
      // 5 sort theo quê quán
      // 6 sort theo controller searchController
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
          int result = a.value.getLastName().compareTo(b.value.getLastName());
          return listTypeReverse ? result : -result;
        });
      });
      case 3: setState(() {
        entries = allPatient.entries.toList();
        entries.sort((a,b){
          int result = a.value.getFirstName().compareTo(b.value.getFirstName());
          return listTypeReverse ? result : -result;
        });
      });
      case 4: setState(() {
        entries = allPatient.entries.toList();
        entries.sort((a,b){
          int result =a.value.getPhone().compareTo(b.value.getPhone());
          return listTypeReverse ? result : -result;
        });
      });
      case 5: setState(() {
        entries = allPatient.entries.toList();
        entries.sort((a,b){
          int result = a.value.getAddress().compareTo(b.value.getAddress());
          return listTypeReverse ? result : -result;
        });
      });
      case 6: setState(() {
        entries = allPatient.entries.toList();
        List<MapEntry<String,Patient>> findEntries =[] ;
        for (var entry in entries) {
          Patient tmp = entry.value;
          String needToFind = tmp.patientID + tmp.getLastName() + tmp.getFirstName() 
          + tmp.getPhone() + tmp.getAddress() ;
          if( needToFind.contains(findController.text) ){
            findEntries.add(entry);
          }
        }
        entries = findEntries;
      });
      default: entries = allPatient.entries.toList();
    }
    return ListView.separated(
                  padding: const EdgeInsets.all(defaultPadding),
                  itemCount: entries.length, // Tổng số phần tử
                  itemBuilder: (context, index) {
                    String key = entries[index].key;
                    Patient patient = allPatient[key]!;
                    return _showApatients(index, listType,entries,key,patient);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 12.0)
                );
  }
}