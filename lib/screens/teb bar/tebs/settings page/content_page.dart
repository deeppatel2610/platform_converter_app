import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/home_provider.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ProviderController>(context, listen: true);
    var providerFalse = Provider.of<ProviderController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: providerTrue.settingList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (providerTrue.settingList[index] == "Edit Profile") {
                providerFalse.readUserData();

                // providerTrue.txtBio.text =
                //     providerTrue.userList[0].bio.toString();
                //
                // providerTrue.txtName.text =
                //     providerTrue.userList[0].name.toString();

                Navigator.of(context).pushNamed('/editProfilePage');
              }
            },
            child: Card(
              color: Colors.blue.shade50,
              child: ListTile(
                trailing:
                    (providerTrue.settingList[index] == 'iOS')
                        ? Switch(
                          value: providerTrue.isIos,
                          onChanged: (value) {
                            providerFalse.conventApp(value: value);
                          },
                        )
                        : IconButton(
                          onPressed: () {
                            if (providerTrue.settingList[index] ==
                                "Edit Profile") {
                              Navigator.of(
                                context,
                              ).pushNamed('/editProfilePage');
                            }
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                title: Text(
                  providerTrue.settingList[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    letterSpacing: .5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
