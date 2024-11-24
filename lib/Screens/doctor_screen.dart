import 'package:beginapp01/OOP_material/doctor.dart';
import 'package:beginapp01/OOP_material/person.dart';
import 'package:beginapp01/Screens/main_screen.dart';
import 'package:beginapp01/const_color.dart';
import 'package:beginapp01/main-Beelzebub.dart';
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

Container _adjustGenderDropdown(GenderEnum selectedGender) {
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
              _genderToString(gender),
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
        underline: const SizedBox(), // Loại bỏ gạch dưới
      ),
    ),
  );
}

String _genderToString(GenderEnum gender) {
  switch (gender) {
    case GenderEnum.male:
      return 'Nam';
    case GenderEnum.female:
      return 'Nữ';
    case GenderEnum.other:
      return 'Khác';
  }
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


class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});
  static String routeName ='DoctorScreen';

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late int listType = 0;
  late bool listTypeReverse = false;
  final TextEditingController findController = TextEditingController();
  //METHOD LÀM VIỆC VỚI MAP LƯU CÁC DOCTOR
  void addADoctor() {
    GenderEnum _selectedGender = GenderEnum.male;
    final TextEditingController firstName = TextEditingController();
    final TextEditingController lastName = TextEditingController();
    final TextEditingController age = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController address = TextEditingController();
    final TextEditingController IDWorker = TextEditingController();
    final TextEditingController salary = TextEditingController();
    final TextEditingController speciality = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: const Text(
                'Thêm một bác sĩ mới',
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
                                      child: Text(_genderToString(gender)),
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
                            _fillblank(IDWorker, 'Mã nhân viên'),
                            const SizedBox(height: 10),
                            _fillblank(salary, 'Lương'),
                            const SizedBox(height: 10),
                            _fillblank(speciality, 'Chuyên ngành'),
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
                    if( allDoctors.containsKey(IDWorker.text) ){
                      showErorrFlushBar(context, 'Đã tồn tại bác sĩ mang ID này');
                    }
                    else{
                      allDoctors[IDWorker.text] = Doctor(
                        firstName: firstName.text,
                        lastName: lastName.text,
                        age: int.parse(age.text),
                        gender: _selectedGender,
                        phone: phone.text,
                        address: address.text,
                        IDWorker: IDWorker.text,
                        salary: double.parse(salary.text),
                        speciality: speciality.text,);
                      showCompleteFlushBar(context, 'Thêm thành công');
                      Future.delayed(const Duration(seconds: 3), () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => DoctorScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ),
                      );
                    });
                    }
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

  void adjustDoctor(Doctor doctor) {
  GenderEnum _selectedGender = doctor.gender; // Giới tính hiện tại
  String latestID = doctor.IDWorker;

  final TextEditingController firstName = TextEditingController(text: doctor.firstName);
  final TextEditingController lastName = TextEditingController(text: doctor.lastName);
  final TextEditingController age = TextEditingController(text: doctor.age.toString());
  final TextEditingController phone = TextEditingController(text: doctor.phone);
  final TextEditingController address = TextEditingController(text: doctor.address);
  final TextEditingController IDWorker = TextEditingController(text: doctor.IDWorker);
  final TextEditingController salary = TextEditingController(text: doctor.salary.toString());
  final TextEditingController speciality = TextEditingController(text: doctor.speciality);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
            title: const Text(
              'Thông tin về bác sĩ này',
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
                          _adjustblank(lastName, 'Họ', doctor.lastName),
                          const SizedBox(height: 10),
                          _adjustblank(age, 'Tuổi', doctor.age.toString()),
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
                                  child: Text(_genderToString(gender)),
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
                          _adjustblank(firstName, 'Tên', doctor.firstName),
                          const SizedBox(height: 10),
                          _adjustblank(phone, 'Số điện thoại', doctor.phone),
                          const SizedBox(height: 10),
                          _adjustblank(address, 'Quê quán', doctor.address),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Cột thứ ba
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 7,
                      child: Column(
                        children: [
                          _adjustblank(IDWorker, 'Mã nhân viên', doctor.IDWorker),
                          const SizedBox(height: 10),
                          _adjustblank(salary, 'Lương', doctor.salary.toString()),
                          const SizedBox(height: 10),
                          _adjustblank(speciality, 'Chuyên ngành', doctor.speciality),
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
                  if (IDWorker.text != latestID && allDoctors.containsKey(IDWorker.text)) {
                    showErorrFlushBar(context, 'Đã có bác sĩ mang ID này');
                  } else if (IDWorker.text != latestID && !allDoctors.containsKey(IDWorker.text)) {
                    try {
                        allDoctors.remove(latestID);
                        allDoctors[IDWorker.text] = Doctor(
                        firstName: firstName.text,
                        lastName: lastName.text,
                        age: int.parse(age.text),
                        gender: _selectedGender,
                        phone: phone.text,
                        address: address.text,
                        IDWorker: IDWorker.text,
                        salary: double.parse(salary.text),
                        speciality: speciality.text,
                      );
                      showCompleteFlushBar(context, 'Lưu thành công');
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => DoctorScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return child;
                            },
                          ),
                        );
                      });

                      
                    } catch (e) {
                      showErorrFlushBar(context, '$e');
                    }
                  } else {
                    try {
                        allDoctors[latestID]?.firstName = firstName.text;
                        allDoctors[latestID]?.lastName = lastName.text;
                        allDoctors[latestID]?.age = int.parse(age.text);
                        allDoctors[latestID]?.gender = _selectedGender;
                        allDoctors[latestID]?.phone = phone.text;
                        allDoctors[latestID]?.address = address.text;
                        allDoctors[latestID]?.IDWorker = IDWorker.text;
                        allDoctors[latestID]?.salary = double.parse(salary.text);
                        allDoctors[latestID]?.speciality = speciality.text;
                        showCompleteFlushBar(context, 'Lưu thành công');
                        Future.delayed(const Duration(seconds: 3), () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => DoctorScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return child;
                            },
                          ),
                        );
                      });

                    } catch (e) {
                      showErorrFlushBar(context, '$e');
                    }
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
                    allDoctors.remove(latestID);
                  });
                  showCompleteFlushBar(context, 'Xóa thành công');
                  Future.delayed(const Duration(seconds: 3), () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => DoctorScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                    ),
                  );
                });
                },
                child: const Text(
                  'Xóa bác sĩ',
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

  void searchDoctor(){
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

   //show 1 hàng doctor
    Container _showAdoctors(int index , int listType, List<MapEntry<String,Doctor>> entries, String key, Doctor doctor) {
    return Container(
                      decoration: BoxDecoration(
                        color: lightGreenBackground,
                        borderRadius: BorderRadius.circular(defaultPadding*3),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                  Image.asset(
                                    'assets/images/doctor.png',
                                    width: MediaQuery.of(context).size.width*0.1,
                                    height: MediaQuery.of(context).size.height * 0.1,
                                  ),
                                  tableText(doctor.IDWorker ),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(doctor.lastName ),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(doctor.firstName ),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(doctor.phone),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(doctor.address),
                                  const SizedBox(width: defaultPadding,),
                                  tableText(doctor.speciality),
                                  IconButton(
                                    onPressed: () => adjustDoctor(doctor), 
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
                  searchDoctor();
                case 2:
                  addADoctor();
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
                        headTableText('MÃ SỐ BÁC SĨ' ,1),
                        const SizedBox(width: defaultPadding,),
                        headTableText('HỌ' ,2),
                        const SizedBox(width: defaultPadding,),
                        headTableText('TÊN' ,3),
                        const SizedBox(width: defaultPadding,),
                        headTableText('SDT' ,4),
                        const SizedBox(width: defaultPadding,),
                        headTableText('QUÊ QUÁN' ,5),
                        const SizedBox(width: defaultPadding,),
                        headTableText('CHUYÊN NGÀNH' ,6),
                        const Icon(Icons.visibility),
                        const SizedBox(width: defaultPadding,),
                ],
                    ),
                  ),
                ),
                Expanded( // Giới hạn ListView.builder trong phần không gian còn lại
                  child: listViewType(_showAdoctors),
                ),
              ],
            )
          ),
          const Spacer(),
        ],
      ),
    );
  }

  ListView listViewType(Container _showAdoctors(int index, int listType, List<MapEntry<String,Doctor>> entries, String key, Doctor doctor)) {
    List<MapEntry<String,Doctor>> entries = allDoctors.entries.toList();
    switch (listType){
      // 0 mặc định
      // 1 sort theo ID
      // 2 sort theo Họ
      // 3 sort theo tên
      // 4 sort theo SDT
      // 5 sort theo quê quán
      // 6 sort theo chuyên ngành
      // 7 sort theo controller searchController
      case 1: setState(() {
        entries = allDoctors.entries.toList();
        entries.sort((a,b){
          int result = a.value.IDWorker.compareTo(b.value.IDWorker);;
          return listTypeReverse ? result : -result;
        });
      });
      case 2: setState(() {
        entries = allDoctors.entries.toList();
        entries.sort((a,b){
          int result = a.value.lastName.compareTo(b.value.lastName);
          return listTypeReverse ? result : -result;
        });
      });
      case 3: setState(() {
        entries = allDoctors.entries.toList();
        entries.sort((a,b){
          int result = a.value.firstName.compareTo(b.value.firstName);
          return listTypeReverse ? result : -result;
        });
      });
      case 4: setState(() {
        entries = allDoctors.entries.toList();
        entries.sort((a,b){
          int result =a.value.phone.compareTo(b.value.phone);
          return listTypeReverse ? result : -result;
        });
      });
      case 5: setState(() {
        entries = allDoctors.entries.toList();
        entries.sort((a,b){
          int result = a.value.address.compareTo(b.value.address);
          return listTypeReverse ? result : -result;
        });
      });
      case 6: setState(() {
        entries = allDoctors.entries.toList();
        entries.sort((a,b){
          int result = a.value.speciality.compareTo(b.value.speciality);
          return listTypeReverse ? result : -result;
        });
      });
      case 7: setState(() {
        entries = allDoctors.entries.toList();
        List<MapEntry<String,Doctor>> findEntries =[] ;
        for (var entry in entries) {
          Doctor tmp = entry.value;
          String needToFind = tmp.IDWorker + tmp.lastName + tmp.firstName 
          + tmp.phone + tmp.address + tmp.speciality;
          if( needToFind.contains(findController.text) ){
            findEntries.add(entry);
          }
        }
        entries = findEntries;
      });
      default: entries = allDoctors.entries.toList();;
    }
    return ListView.separated(
                  padding: const EdgeInsets.all(defaultPadding),
                  itemCount: entries.length, // Tổng số phần tử
                  itemBuilder: (context, index) {
                    String key = entries[index].key;
                    Doctor doctor = allDoctors[key]!;
                    return _showAdoctors(index, listType,entries,key,doctor);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 12.0)
                );
  }
}