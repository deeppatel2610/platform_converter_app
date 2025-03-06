import 'package:flutter/material.dart';
import 'package:platform_converter_app/screens/teb%20bar/tebs/calls_list_page.dart';
import 'package:platform_converter_app/screens/teb%20bar/tebs/email_list_page.dart';
import 'package:platform_converter_app/screens/teb%20bar/tebs/settings%20page/content_page.dart';

import '../../controller/home_provider.dart';
import 'tebs/add_content_page.dart';

class BottomNavigationBarPage extends StatelessWidget {
  const BottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Platform Converter",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: .5,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(icon: Icon(Icons.person_add_alt)),
              Tab(
                child: Text(
                  "Email",
                  style: TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .2,
                    fontSize: 15,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Calls",
                  style: TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .2,
                    fontSize: 15,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Settings",
                  style: TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .2,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AddContentPage(),
            ChatsListPage(),
            CallsListPage(),
            ContentPage(),
          ],
        ),
      ),
    );
  }
}
