import 'package:flutter/material.dart';
import 'package:platform_converter_app/helper/db_helper.dart';
import 'package:provider/provider.dart';

import '../../../../controller/home_provider.dart';
import '../../../component/imput_box_method.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ProviderController>(context, listen: true);
    var providerFalse = Provider.of<ProviderController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: .5,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      radius: 70,
                      // foregroundImage: NetworkImage(
                      //   'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
                      // ),
                      child: Icon(Icons.add_a_photo_outlined, size: 35),
                    ),
                  ),
                  SizedBox(height: 10),
                  inputBoxMethod(
                    isNumber: false,
                    text: "Enter name...",
                    controller: providerTrue.txtName,
                    isMaxLines: false,
                  ),
                  inputBoxMethod(
                    isNumber: false,
                    text: "Enter Bio...",
                    controller: providerTrue.txtBio,
                    isMaxLines: true,
                  ),
                ],
              ),
            ),
            GestureDetector(
              /// todo : enter a data base code
              onTap: () {
                providerFalse.updateDatabase(
                  id: int.parse(providerTrue.userList[0].id.toString()),
                  name: providerTrue.txtName.text,
                  number: int.parse(providerTrue.userList[0].number.toString()),
                  bio: providerTrue.txtBio.toString(),
                  email: providerTrue.userList[0].email.toString(),
                  tebName: DbHelper.dbHelper.dbUser,
                );
              },
              child: Container(
                height: 65,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
