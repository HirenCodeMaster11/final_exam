import 'package:final_exam/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modal/modal.dart';
import 'my text field.dart';



class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<TodoProvider>(context);
    var providerFalse = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyTextField(name: 'Search Title', controller: providerTrue.txtSearch,onChanged: (value) {
                    providerFalse.searchByTitle(value);
                  },
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: providerFalse.getTitle(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                providerTrue.searchName = providerTrue.searchList
                    .map(
                      (e) => TodoModal.fromMap(e),
                )
                    .toList();
                return Expanded(
                  child: ListView.builder(
                      itemCount: providerTrue.searchName.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Text(providerTrue.searchName[index].id.toString()),
                          title: Text(providerTrue.searchName[index].name.toString()),
                          // tileColor: ("present" == providerTrue.searchName[index].status)?Colors.green : Colors.red,
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(providerTrue.searchName[index].id.toString()),
                              Text(providerTrue.searchName[index].name)
                            ],
                          ),
                        ),
                      )
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
