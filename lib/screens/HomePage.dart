import 'package:floor_database/floor/dao/PersonDao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Data_controller.dart';

class HomePage extends StatefulWidget {
  PersonDao personDao;
  HomePage({super.key, required this.personDao});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  final dataController = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    dataController.getAllPerson(widget.personDao);
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
        init: dataController,
        builder: (dashboardController){
        return Scaffold(
          body: SafeArea(
            child: Container(
            margin: const EdgeInsets.all(5),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                const Text('Person List',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

                Expanded(
                  child: ListView.builder(
                      itemCount: dataController.personData.length!=null?dataController.personData.length:0,
                      itemBuilder: (_, index) {
                        return
                            Card(
                                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                elevation:10 , color: Colors.white,
                                shadowColor: Colors.black,
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(10),
                              child: Text(
                               "ID : ${dataController.personData[index].id} \nNAME: "+dataController.personData[index].name,
                                style: const TextStyle(color: Colors.black,),)),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showGeneralDialog(
                context: context,
                barrierLabel: "showGeneralDialog",
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Align(
                    alignment: Alignment.center,

                    child: Material(
                      color: Colors.transparent,

                      child: Container(
                        margin: const EdgeInsets.all(10),
                        height: 180,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),

                        child: Column(children: [

                          TextField(
                            controller: dataController.idController,
                            decoration: const InputDecoration(
                              hintText: " Enter id:",
                              hintStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                              border: InputBorder.none,
                            ),
                          ),
                          TextField(
                            controller: dataController.perNameController,
                            decoration: const InputDecoration(
                              hintText: " Person Name:",
                              hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                              border: InputBorder.none,
                            ),
                          ),
                          InkWell(
                              onTap: ()  {
                                dataController.insertPerson(int.parse(dataController.idController.text),
                                    dataController.perNameController.text,widget.personDao);
                                dataController.getAllPerson(widget.personDao);
                                Navigator.pop(context);
                              },
                              child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  child: const Text("Add",
                                      style: TextStyle(color: Colors.white)))),
                        ]),
                      ),
                    ),
                  );
                }
            );
          },
          child: Container(
            width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.add,color: Colors.white,)),
        ),
      );
     }
    );
  }
}