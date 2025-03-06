import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/controller/home_provider.dart';
import 'package:platform_converter_app/helper/db_helper.dart';
import 'package:platform_converter_app/screens/add_user_page.dart';
import 'package:platform_converter_app/screens/teb%20bar/teb_bar.dart';
import 'package:platform_converter_app/screens/teb%20bar/tebs/settings%20page/content_page.dart';
import 'package:platform_converter_app/screens/teb%20bar/tebs/settings%20page/edit_profile_page.dart';
import 'package:platform_converter_app/screens/temp.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DbHelper.dbHelper.database;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderController(),
      builder: (context, child) {
        Provider.of<ProviderController>(context, listen: false).readUserData();

        return (Provider.of<ProviderController>(context, listen: true).isIos)
            ? CupertinoApp(home: Temp())
            : MaterialApp(
              routes: {
                '/':
                    (context) =>
                        (Provider.of<ProviderController>(
                              context,
                              listen: true,
                            ).userList.isEmpty)
                            ? AddUserPage()
                            : BottomNavigationBarPage(),
                '/bottomNavigationBarPage':
                    (context) => BottomNavigationBarPage(),
                '/content': (context) => ContentPage(),
                '/editProfilePage': (context) => EditProfilePage(),
              },
              debugShowCheckedModeBanner: false,
            );
      },
    );
  }
}
