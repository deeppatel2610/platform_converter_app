import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/home_provider.dart';

class CallsListPage extends StatelessWidget {
  const CallsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ProviderController>(context, listen: true);
    var providerFalse = Provider.of<ProviderController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: providerTrue.contentList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              final url = Uri(
                scheme: 'tel',
                path: providerTrue.contentList[index].number.toString(),
              );
              if (await canLaunchUrl(url)) {
                launchUrl(url);
              }
            },
            child: Card(
              color: Colors.blue.shade50,
              child: ListTile(
                leading: IconButton(
                  /// todo logic URL loch
                  onPressed: () {},
                  icon: Icon(Icons.call),
                ),
                title: Text(
                  providerTrue.contentList[index].name.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                  ),
                ),
                subtitle: Text(
                  providerTrue.contentList[index].number.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
