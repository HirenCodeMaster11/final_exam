import 'package:final_exam/modal/contactModal.dart';
import 'package:final_exam/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ContactProvider>(context);
    var providerFalse = Provider.of<ContactProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Contact'),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text('backUp'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
        child: Column(
          children: [
            TextField(
              controller: providerTrue.txtSearch,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            FutureBuilder(future: providerFalse.readContact(), builder: (context, snapshot) {
              if(snapshot.hasData)
                {
                  List<ContactModal> contactModal = [];

                  contactModal = providerTrue.contactList.map((e) => ContactModal.fromMap).cast<ContactModal>().toList();
                }
              List contactList = [];

              return ListView.builder(itemBuilder: (context, index) =>
                  ListTile(
                    title: Text(),
                  ),
              );
            },),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add Contact',
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: providerTrue.txtName,
                      decoration: InputDecoration(
                        label: Text('name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: providerTrue.txtPhone,
                      decoration: InputDecoration(
                        label: Text('phone'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: providerTrue.txtEmail,
                      decoration: InputDecoration(
                        label: Text('email'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancle'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Ok'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
