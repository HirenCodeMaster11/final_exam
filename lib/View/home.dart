import 'package:final_exam/Provider/provider.dart';
import 'package:final_exam/modal/modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SearchPage.dart';
import 'my text field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<TodoProvider>(context);
    var providerFalse = Provider.of<TodoProvider>(context, listen: false);

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        providerTrue.selectedDate = pickedDate;
        providerTrue.txtDate.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      }
    }

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
              List<TodoModal> todo = [];
              todo = providerTrue.todoList
                  .map(
                    (e) => TodoModal.fromMap(e),
                  )
                  .toList();

              for (int i = 0; i < providerTrue.todoList.length; i++) {
                providerFalse.todoAddInStore(
                  id: todo[i].id,
                  title: todo[i].title,
                  date: todo[i].date,
                  status: todo[i].status,
                  description: todo[i].description,
                );
              }
            },
            child: Text('BackUp'),
          ),
          TextButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/');
              },
              child: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
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
                  List<TodoModal> todo = [];
                  todo = providerTrue.todoList
                      .map(
                        (e) => TodoModal.fromMap(e),
                      )
                      .toList();
                  return ListView.builder(
                    itemCount: todo.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          providerTrue.id = todo[index].id;
                          providerTrue.txtTitle.text = todo[index].title;
                          providerTrue.txtDate.text =
                              todo[index].date.toString();
                          providerTrue.txtStatus.text = todo[index].status;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Update Todo'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    MyTextField(
                                      controller: providerTrue.txtTitle,
                                      name: 'Title',
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                      controller: providerTrue.txtDes,
                                      name: 'Description',
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: providerTrue.txtDate,
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                            onTap: () {
                                              _selectDate(context);
                                            },
                                            child: Icon(Icons.calendar_month)),
                                        labelText: 'Select Date',
                                        border: OutlineInputBorder(),
                                      ),
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
                                        providerFalse.clearAll();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        providerFalse.updateData(
                                          id: providerTrue.id,
                                          title: providerTrue.txtTitle.text,
                                          description: providerTrue.txtDes.text,
                                          date: providerTrue.selectedDate,
                                          status: providerTrue.txtStatus.text,
                                        );
                                        providerFalse.clearAll();
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
                        leading: Text(
                          todo[index].id.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        title: Text(
                          todo[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            providerFalse.deleteData(id: todo[index].id);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
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
              title: const Text('Add Todo'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyTextField(
                      controller: providerTrue.txtTitle,
                      name: 'Title',
                    ),
                    SizedBox(height: 5),
                    MyTextField(
                      controller: providerTrue.txtDes,
                      name: 'Description',
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: providerTrue.txtDate,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Icon(Icons.calendar_month)),
                        labelText: 'Select Date',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 5),
                    MyTextField(
                      controller: providerTrue.txtStatus,
                      name: 'Status',
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        providerFalse.clearAll();
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        providerTrue.id = providerTrue.todoList.length + 1;
                        providerFalse.insertDatabase(
                          id: providerTrue.id,
                          title: providerTrue.txtTitle.text,
                          date: providerTrue.selectedDate,
                          status: providerTrue.txtStatus.text,
                          description: providerTrue.txtDes.text,
                        );
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
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.add,size: 38,),
          Icon(Icons.edit,size: 28),
          Icon(Icons.person,size: 28,),
          Icon(Icons.settings,size: 28,),
        ],
      ),
    );
  }
}
