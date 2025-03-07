import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/home_provider.dart';
import '../../../helper/db_helper.dart';
import '../../component/imput_box_method.dart';

class ChatsListPage extends StatelessWidget {
  const ChatsListPage({super.key});

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
            onTap: () {
              Uri uri = Uri.parse(
                'mailto: ${providerTrue.contentList[index].email}',
              );
              launchUrl(uri);
            },
            child: Card(
              color: Colors.blue.shade50,
              child: ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder:
                              (context) => SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                  ),
                                  child: SizedBox(
                                    height: 400,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10),
                                                Text(
                                                  "Edit Content",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: .5,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                inputBoxMethod(
                                                  text:
                                                      providerTrue
                                                          .contentList[index]
                                                          .name!,
                                                  controller:
                                                      providerTrue.txtName,
                                                  isMaxLines: false,
                                                  isNumber: false,
                                                ),
                                                inputBoxMethod(
                                                  text:
                                                      providerTrue
                                                          .contentList[index]
                                                          .number
                                                          .toString(),
                                                  controller:
                                                      providerTrue.txtNumber,
                                                  isMaxLines: false,
                                                  isNumber: true,
                                                ),
                                                inputBoxMethod(
                                                  text:
                                                      providerTrue
                                                          .contentList[index]
                                                          .email!,
                                                  controller:
                                                      providerTrue.txtEmail,
                                                  isMaxLines: false,
                                                  isNumber: false,
                                                ),
                                                inputBoxMethod(
                                                  text:
                                                      providerTrue
                                                          .contentList[index]
                                                          .bio!,
                                                  controller:
                                                      providerTrue.txtBio,
                                                  isMaxLines: true,
                                                  isNumber: false,
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            /// todo : enter a data base code
                                            onTap: () {
                                              providerFalse.updateDatabase(
                                                id:
                                                    providerTrue
                                                        .contentList[index]
                                                        .id!,
                                                name: providerTrue.txtName.text,
                                                number: int.parse(
                                                  providerTrue.txtNumber.text,
                                                ),
                                                bio: providerTrue.txtBio.text,
                                                email:
                                                    providerTrue.txtEmail.text,
                                                tebName:
                                                    DbHelper.dbHelper.dbName,
                                              );
                                              providerTrue.txtName.clear();
                                              providerTrue.txtNumber.clear();
                                              providerTrue.txtEmail.clear();
                                              providerTrue.txtBio.clear();
                                            },
                                            child: Container(
                                              height: 65,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Edit Content",
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
                                  ),
                                ),
                              ),
                        );
                      },
                      icon: Icon(Icons.edit_outlined),
                    ),

                    IconButton(
                      onPressed: () {
                        providerFalse.deleteDatabase(
                          id: providerTrue.contentList[index].id!,
                        );
                      },
                      icon: Icon(Icons.delete_outline),
                    ),
                  ],
                ),

                leading: IconButton(
                  /// todo logic URL loch
                  onPressed: () {
                    Uri uri = Uri.parse(
                      'mailto: ${providerTrue.contentList[index].email}',
                    );
                    launchUrl(uri);
                  },
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
            ),
          );
        },
      ),
    );
  }
}
