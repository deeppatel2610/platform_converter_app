import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/db_helper.dart';
import '../model/content_model.dart';

class ProviderController extends ChangeNotifier {
  //
  //// todo : ----------------------- ui logic --------------------------

  bool isIos = false;
  var txtName = TextEditingController();
  var txtBio = TextEditingController();
  var txtEmail = TextEditingController();
  var txtNumber = TextEditingController();

  void conventApp({required bool value}) {
    isIos = value;
    notifyListeners();
  }

  List settingList = [
    "iOS",
    "Edit Profile",
    "Caller Id & spam",
    "Accessibility",
    "Assisted dialing",
    "Blocked numbers",
    "Calling account",
    "Call recoding",
    "Display options",
    "Quick responses",
    "Sounds and vibration",
    "Voicemail",
    "Contact ringtones",
    "caller Id Announcement",
    "Flip to Silence",
  ];

  DateTime? selectedDate; // for DA
  DateTime? selectedCupertinoTime; // for DA
  String? contactDate; // TE
  String? contactTime; // TE
  TimeOfDay? selectedTime; //FO

  Future<void> datePickerCupertino(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder:
          (context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              showDayOfWeek: true,
              onDateTimeChanged: (value) {
                selectedDate = value;
              },
            ),
          ),
    );
    contactDate =
        "${selectedDate!.month} / ${selectedDate!.day} / ${selectedDate!.year}";

    notifyListeners();
  }

  Future<void> timePickerCupertino(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder:
          (context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) {
                selectedCupertinoTime = value;
              },
            ),
          ),
    );
    contactTime =
        '${selectedCupertinoTime!.hour}:${selectedCupertinoTime!.minute}';
  }

  //// todo : -------------------------- db logic ---------------------------

  //// todo : all content logic
  List<ContentModel> contentList = [];
  List<ContentModel> userList = [];

  void addDatabase({
    required String name,
    required int number,
    required String bio,
    required String email,
    required String tebName,
  }) {
    DbHelper.dbHelper.insertData(
      name: name,
      number: number,
      bio: bio,
      email: email,
      tebName: tebName,
    );
    readDataBase();
    notifyListeners();
  }

  Future<void> readDataBase() async {
    List data = await DbHelper.dbHelper.readDate(
      tebName: DbHelper.dbHelper.dbName,
    );
    contentList = data.map((e) => ContentModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> readUserData() async {
    List data = await DbHelper.dbHelper.readDate(
      tebName: DbHelper.dbHelper.dbUser,
    );
    userList = data.map((e) => ContentModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> updateDatabase({
    required int id,
    required String name,
    required int number,
    required String bio,
    required String email,
    required String tebName,
  }) async {
    ContentModel model = ContentModel(
      number: number,
      name: name,
      email: email,
      bio: bio,
      id: id,
    );
    await DbHelper.dbHelper.update(model: model, tebName: tebName);
    readDataBase();
    notifyListeners();
  }

  void deleteDatabase({required int id}) {
    DbHelper.dbHelper.delete(id: id);
  }
}
