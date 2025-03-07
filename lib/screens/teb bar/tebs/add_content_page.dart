// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../controller/home_provider.dart';
// import '../../../helper/Db_helper.dart';
// import '../../component/imput_box_method.dart';
//
// class AddContentPage extends StatefulWidget {
//   const AddContentPage({super.key});
//
//   @override
//   State<AddContentPage> createState() => _AddContentPageState();
// }
//
// class _AddContentPageState extends State<AddContentPage> {
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<ProviderController>(context, listen: false).readDataBase();
//     });
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
//
//   Future<void> _selectTime(BuildContext context) async {
//     TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (picked != null && picked != selectedTime) {
//       setState(() {
//         selectedTime = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var providerTrue = Provider.of<ProviderController>(context, listen: true);
//     var providerFalse = Provider.of<ProviderController>(context, listen: false);
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   const SizedBox(height: 10),
//                   Center(
//                     child: CircleAvatar(
//                       backgroundColor: Colors.blue.shade50,
//                       radius: 70,
//                       child: const Icon(Icons.add_a_photo_outlined, size: 35),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   inputBoxMethod(
//                     text: "Enter name...",
//                     controller: providerTrue.txtName,
//                     isMaxLines: false,
//                     isNumber: false,
//                   ),
//                   inputBoxMethod(
//                     text: "Enter Number...",
//                     controller: providerTrue.txtNumber,
//                     isMaxLines: false,
//                     isNumber: true,
//                   ),
//                   inputBoxMethod(
//                     text: "Enter Email ID...",
//                     controller: providerTrue.txtEmail,
//                     isMaxLines: false,
//                     isNumber: false,
//                   ),
//                   inputBoxMethod(
//                     text: "Enter Bio...",
//                     controller: providerTrue.txtBio,
//                     isMaxLines: true,
//                     isNumber: false,
//                   ),
//
//                   // Date Picker
//                   Card(
//                     color: Colors.blue.shade50,
//                     child: ListTile(
//                       title: Text(
//                         selectedDate == null
//                             ? "Select Date"
//                             : "Date: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
//                       ),
//                       leading: const Icon(Icons.calendar_today),
//                       onTap: () => _selectDate(context),
//                     ),
//                   ),
//
//                   // Time Picker
//                   Card(
//                     color: Colors.blue.shade50,
//
//                     child: ListTile(
//                       title: Text(
//                         selectedTime == null
//                             ? "Select Time"
//                             : "Time: ${selectedTime!.format(context)}",
//                       ),
//                       leading: const Icon(Icons.access_time),
//                       onTap: () => _selectTime(context),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // Add Button
//           GestureDetector(
//             onTap: () {
//               providerFalse.addDatabase(
//                 name: providerTrue.txtName.text,
//                 number: int.parse(providerTrue.txtNumber.text),
//                 bio: providerTrue.txtBio.text,
//                 email: providerTrue.txtEmail.text,
//                 tebName: DbHelper.dbHelper.dbName,
//               );
//
//               providerTrue.txtName.clear();
//               providerTrue.txtNumber.clear();
//               providerTrue.txtEmail.clear();
//               providerTrue.txtBio.clear();
//
//               setState(() {
//                 selectedDate = null;
//                 selectedTime = null;
//               });
//             },
//             child: Container(
//               height: 65,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               alignment: Alignment.center,
//               child: const Text(
//                 "Add Contact",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../controller/home_provider.dart';
import '../../../helper/Db_helper.dart';
import '../../component/imput_box_method.dart';

class AddContentPage extends StatefulWidget {
  const AddContentPage({super.key});

  @override
  State<AddContentPage> createState() => _AddContentPageState();
}

class _AddContentPageState extends State<AddContentPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderController>(context, listen: false).readDataBase();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Take a photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ProviderController>(context, listen: true);
    var providerFalse = Provider.of<ProviderController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _showImagePickerOptions,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      radius: 70,
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(Icons.add_a_photo_outlined, size: 35)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  inputBoxMethod(
                    text: "Enter name...",
                    controller: providerTrue.txtName,
                    isMaxLines: false,
                    isNumber: false,
                  ),
                  inputBoxMethod(
                    text: "Enter Number...",
                    controller: providerTrue.txtNumber,
                    isMaxLines: false,
                    isNumber: true,
                  ),
                  inputBoxMethod(
                    text: "Enter Email ID...",
                    controller: providerTrue.txtEmail,
                    isMaxLines: false,
                    isNumber: false,
                  ),
                  inputBoxMethod(
                    text: "Enter Bio...",
                    controller: providerTrue.txtBio,
                    isMaxLines: true,
                    isNumber: false,
                  ),

                  // Date Picker
                  Card(
                    color: Colors.blue.shade50,
                    child: ListTile(
                      title: Text(
                        selectedDate == null
                            ? "Select Date"
                            : "Date: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                      ),
                      leading: const Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context),
                    ),
                  ),

                  // Time Picker
                  Card(
                    color: Colors.blue.shade50,
                    child: ListTile(
                      title: Text(
                        selectedTime == null
                            ? "Select Time"
                            : "Time: ${selectedTime!.format(context)}",
                      ),
                      leading: const Icon(Icons.access_time),
                      onTap: () => _selectTime(context),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add Button
          GestureDetector(
            onTap: () {
              providerFalse.addDatabase(
                name: providerTrue.txtName.text,
                number: int.parse(providerTrue.txtNumber.text),
                bio: providerTrue.txtBio.text,
                email: providerTrue.txtEmail.text,
                tebName: DbHelper.dbHelper.dbName,
              );

              providerTrue.txtName.clear();
              providerTrue.txtNumber.clear();
              providerTrue.txtEmail.clear();
              providerTrue.txtBio.clear();

              setState(() {
                selectedDate = null;
                selectedTime = null;
                _imageFile = null;
              });
            },
            child: Container(
              height: 65,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Add Contact",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

