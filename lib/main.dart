import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = 'RDQDCu0ff0g37A1K2oxesX9X3O5HwiZpwwCvFFii';
  final keyClientKey = 'e9dgIrOG4a5fYrQprnKCvhXdUa8abgu9Qujt7Oyk';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final taskController = TextEditingController();
  final descController = TextEditingController();
  final objIdController = TextEditingController();
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
              //padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Column(children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 7.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              autocorrect: true,
                              textCapitalization: TextCapitalization.sentences,
                              controller: taskController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Title",
                                  labelStyle: TextStyle(color: Colors.blueAccent)),

                            ),
                          )
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 7.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              autocorrect: true,
                              textCapitalization: TextCapitalization.sentences,
                              controller: descController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Description",
                                  labelStyle: TextStyle(color: Colors.blueAccent)),
                            ),
                          ),
                        ],
                      )),
                Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      // padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.white,
                                  primary: Colors.black38,
                                  padding: EdgeInsets.fromLTRB(10, 20, 10, 18),
                                ),
                                onPressed: clearTask,
                                child: Wrap(
                                    children: <Widget>[
                                      Icon( Icons.clear_rounded,
                                        // color: Colors.pink,
                                        size: 18.0,
                                      ),
                                      SizedBox( width:10 ),
                                      Text("CLEAR", style:TextStyle(fontSize:16)),
                                    ]
                                )
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: isUpdate? Colors.orangeAccent : Colors.green,
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              ),
                              onPressed: addTask,
                              child: Wrap(
                                  children: <Widget>[
                                    Icon( isUpdate? Icons.check : Icons.add,
                                          // color: Colors.pink,
                                          size: 18.0,
                                    ),
                                    SizedBox( width:10 ),
                                    Text(isUpdate? "UPDATE" : "ADD", style:TextStyle(fontSize:16)),
                                  ]
                          )
                          )
                          )
                        ],
                      )),
                  Expanded(
                      child: FutureBuilder<List<ParseObject>>(
                          future: getTasks(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                  child: Container(
                                      width: 100,
                                      height: 100,
                                      child: CircularProgressIndicator()),
                                );
                              default:
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error..."),
                                  );
                                }
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Text("No Data..."),
                                  );
                                } else {
                                  return ListView.builder(
                                      // separatorBuilder: (BuildContext context, int index) => const Divider(),
                                      // shrinkWrap: true,
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        //*************************************
                                        //Get Parse Object Values
                                        final varTask = snapshot.data![index];
                                        final varTitle = varTask.get<String>('title')!;
                                        final varDescription = varTask.get<String>('description')!;
                                        final _varDesc = (varDescription.length > 30 ? varDescription.substring(0,30)+'.....' : varDescription);
                                        final task = Task(varTitle, varDescription);
                                        final varDone =  varTask.get<bool>('done')!;
                                        //*************************************

                                        return Container(
                                            // height: ,
                                            // color: Color.,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              // color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(color: Colors.blue, spreadRadius: 0.3),
                                              ],
                                              color: Colors.blue[50],
                                              // gradient: LinearGradient(
                                              //   begin: Alignment.bottomLeft,
                                              //   end: Alignment.topRight,
                                              //   colors: [
                                              //     Color(0xffFFCE00),
                                              //     Color(0xffE86F1C),
                                              //   ],
                                              // ),
                                            ),
                                            // height: 60,
                                            margin: EdgeInsets.only(top: 10.0),
                                            child: ListTile(
                                              title: Text(varTitle),
                                              titleTextStyle: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                              subtitle: Text(_varDesc),
                                              leading: CircleAvatar(
                                                child: Icon( varDone ? Icons.list : Icons.error),
                                                backgroundColor: varDone ? Colors.blueAccent : Colors.blue,
                                                foregroundColor: Colors.white,
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Colors.blueAccent,
                                                    ),
                                                    onPressed: () async {
                                                      editTask(varTask.objectId!, varTitle, varDescription);
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () async {
                                                      await deleteTask(varTask.objectId!);
                                                      setState(() {
                                                        final snackBar = SnackBar(
                                                          content: Text("Task deleted!"),
                                                          duration: Duration(seconds: 2),
                                                        );
                                                        ScaffoldMessenger.of(context)
                                                          ..removeCurrentSnackBar()
                                                          ..showSnackBar(snackBar);
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const DetailScreen(),
                                                    // Pass the arguments as part of the RouteSettings. The
                                                    // DetailScreen reads the arguments from these settings.
                                                    settings: RouteSettings(
                                                      arguments: task,
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                        );
                                      });
                                }
                            }
                          }))
                ],
              ),
      )
            );
  }

  void addTask() async {
    if (taskController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please provide Title"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    if (descController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please provide Description"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    if( objIdController.text!='' ){
      await updateTask(objIdController.text, taskController.text, descController.text);
      setState(() {
        taskController.clear();
        descController.clear();
        objIdController.clear();
        setState(() => isUpdate=false);
        final snackBar = SnackBar(
          content: Text("Task updated!"),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(snackBar);
      });
    }else {
      await saveTask(taskController.text, descController.text);
      setState(() {
        taskController.clear();
        descController.clear();
        final snackBar = SnackBar(
          content: Text("Task added!"),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(snackBar);
      });
    }
  }


  Future<void> saveTask(String title, String description) async {
    final task = ParseObject('Task')..set('title', title)..set('description', description)..set('done', true);
    await task.save();
  }

  Future<List<ParseObject>> getTasks() async {
    QueryBuilder<ParseObject> queryTask = QueryBuilder<ParseObject>(ParseObject('Task'));
    final ParseResponse apiResponse = await queryTask.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  void editTask(String id, String title, String description)  {
    taskController.text=title;
    descController.text=description;
    objIdController.text=id;
      setState(() => isUpdate=true);
  }

  Future<void> updateTask(String id, String title, String description) async {
    var task = ParseObject('Task')
      ..set('objectId', id)
      ..set('title', title)
      ..set('description', description)
      ..set('done', true);
    await task.update();
  }

  Future<void> deleteTask(String id) async {
    var task = ParseObject('Task')..objectId = id;
    await task.delete();
  }

  void clearTask(){
    taskController.clear();
    descController.clear();
    objIdController.clear();
    setState(() => isUpdate=false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Cleared !"),
      duration: Duration(seconds: 1),
    ));
  }

}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as Task;

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      // color: Colors.white,
                      /*boxShadow: [
                        BoxShadow(color: Colors.blue, spreadRadius: 0.3),
                      ],*/
                      color: Colors.blue[50],
                      ),
                      // margin: EdgeInsets.only(top: 10.0),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          Expanded(
                              child: Text(task.description)
                          )
                          ]
    )
    )
            ]
        )
        )
      ),
    );
  }
}

class Task {
  final String title;
  final String description;

  const Task(this.title, this.description);
}