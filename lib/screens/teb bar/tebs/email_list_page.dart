import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_provider.dart';

class ChatsListPage extends StatelessWidget {
  const ChatsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ProviderController>(context, listen: true);
    var providerFalse = Provider.of<ProviderController>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        /// todo logic URL loch
        onTap: () {},
        child: ListView.builder(
          itemCount: providerTrue.contentList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.blue.shade50,
              child: ListTile(
                leading: IconButton(
                  /// todo logic URL loch
                  onPressed: () {},
                  icon: Icon(Icons.email_outlined),
                ),
                title: Text(
                  providerTrue.contentList[index].name.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                  ),
                ),
                subtitle: Text(
                  providerTrue.contentList[index].email.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
