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
