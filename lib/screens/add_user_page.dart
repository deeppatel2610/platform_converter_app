import 'package:flutter/material.dart';
import 'package:platform_converter_app/helper/db_helper.dart';
import 'package:provider/provider.dart';

import '../controller/home_provider.dart';
import 'component/imput_box_method.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ProviderController>(context, listen: true);
    var providerFalse = Provider.of<ProviderController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Add Your Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: .5,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
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
                      isNumber: true,
                      text: "Enter Number...",
                      controller: providerTrue.txtNumber,
                      isMaxLines: false,
                    ),
                    inputBoxMethod(
                      isNumber: false,
                      text: "Enter Email...",
                      controller: providerTrue.txtEmail,
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
            ),
            GestureDetector(
              /// todo : enter a data base code
              onTap: () {
                providerFalse.addDatabase(
                  name: providerTrue.txtName.text,
                  number: int.parse(providerTrue.txtNumber.text),
                  bio: providerTrue.txtBio.text,
                  email: providerTrue.txtEmail.text,
                  tebName: DbHelper.dbHelper.dbUser,
                );
                providerTrue.txtName.clear();
                providerTrue.txtBio.clear();
                providerTrue.txtEmail.clear();
                providerTrue.txtNumber.clear();
                Navigator.of(
                  context,
                ).pushReplacementNamed("/bottomNavigationBarPage");
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
                  "Add Profile",
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
