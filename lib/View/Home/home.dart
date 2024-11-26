import 'package:final_exam/Provider/provider.dart';
import 'package:final_exam/View/Home/search%20screen.dart';
import 'package:final_exam/modal/modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Services/auth.dart';
import '../MyTextField.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<AttendanceProvider>(context);
    var providerFalse = Provider.of<AttendanceProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton(
              onPressed: () {
                providerFalse.cloudToLocally();
              },
              child: Text('Save Local')),
          TextButton(
            onPressed: () {
              List<AttendanceModal> attendance = [];
              attendance = providerTrue.attendanceList
                  .map(
                    (e) => AttendanceModal.fromMap(e),
                  )
                  .toList();

              for (int i = 0; i < providerTrue.attendanceList.length; i++) {
                providerFalse.attendanceAddInStore(
                    id: attendance[i].id,
                    name: attendance[i].name,
                    room: attendance[i].room,
                    date: attendance[i].date,
                    status: attendance[i].status);
              }
            },
            child: Text('BackUp'),
          ),
          TextButton(onPressed: () async {
            await AuthService.authService.signOut();
            Navigator.of(context).pushNamed('/');
          }, child: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage(),));
            },
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Search'),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: providerFalse.readData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<AttendanceModal> attendance = [];
                  attendance = providerTrue.attendanceList
                      .map(
                        (e) => AttendanceModal.fromMap(e),
                      )
                      .toList();
                  return ListView.builder(
                    itemCount: attendance.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          providerTrue.id = attendance[index].id;
                          providerTrue.txtName.text = attendance[index].name;
                          providerTrue.txtRoom.text = attendance[index].room;
                          providerTrue.txtDate.text = attendance[index].date;
                          providerTrue.txtStatus.text = attendance[index].status;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Update Attendance'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    MyTextField(
                                      controller: providerTrue.txtName,
                                      name: 'Name',
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                      controller: providerTrue.txtRoom,
                                      name: 'Class Room',
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                      controller: providerTrue.txtDate,
                                      name: 'Date',
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                      controller: providerTrue.txtStatus,
                                      name: 'Status',
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        providerFalse.updateData(
                                            id: providerTrue.id,
                                            name: providerTrue.txtName.text,
                                            room: providerTrue.txtRoom.text,
                                            date: providerTrue.txtDate.text,
                                            status: providerTrue.txtStatus.text);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        tileColor: ("present" == attendance[index].status)?Colors.green : Colors.red,
                        leading: Text(attendance[index].id.toString(),style: TextStyle(color: Colors.white)),
                        title: Text(
                          attendance[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(attendance[index].room,style: TextStyle(color: Colors.white),),
                            Text(attendance[index].status,style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        trailing: GestureDetector(
                            onTap: () {
                              providerFalse.deleteData(id: attendance[index].id);
                            },
                            child: Icon(Icons.delete,color: Colors.white,)),
                      ),
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
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          providerFalse.clearAll();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Attendances'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyTextField(
                      controller: providerTrue.txtName,
                      name: 'Name',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyTextField(
                      controller: providerTrue.txtRoom,
                      name: 'Class Room',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyTextField(
                      controller: providerTrue.txtDate,
                      name: 'Date',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyTextField(
                      controller: providerTrue.txtStatus,
                      name: 'Status',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        providerTrue.id =
                            providerTrue.attendanceList.length + 1;
                        providerFalse.insertDatabase(
                            id: providerTrue.id,
                            name: providerTrue.txtName.text,
                            room: providerTrue.txtRoom.text,
                            date: providerTrue.txtDate.text,
                            status: providerTrue.txtStatus.text);
                        Navigator.pop(context);
                        providerFalse.clearAll();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
