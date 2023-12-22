import 'package:floor_database/floor/dao/PersonDao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Data_controller.dart';
import '../floor/entity/Person.dart';

class HomePage extends StatefulWidget {
  PersonDao personDao;
  HomePage({super.key, required this.personDao});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  final datacontroller = Get.put(Data_controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(5),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              const Text('Person List',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),

              Expanded(
                child: StreamBuilder<List<String>>(
                  stream: widget.personDao.findAllPersonName(),
                  builder: (_, snapshot) {

                    if (!snapshot.hasData) return Container();
                    final allRecords = snapshot.requireData.obs;

                    return ListView.builder(
                      itemCount: allRecords.length,
                      itemBuilder: (_, index) {
                        return Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).highlightColor,
                            ),
                            child: Obx(() =>  Text(
                              allRecords[index],
                              style: const TextStyle(color: Colors.black),
                            )));
                      },
                    );
                  },
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
                          controller: datacontroller.id_controller,
                          decoration: const InputDecoration(
                            hintText: " Enter id:",
                            hintStyle:
                            TextStyle(color: Colors.black, fontSize: 15),
                            border: InputBorder.none,
                          ),
                        ),
                        TextField(
                          controller: datacontroller.person_name_controller,
                          decoration: const InputDecoration(
                            hintText: " Person Name:",
                            hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                            border: InputBorder.none,
                          ),
                        ),
                        InkWell(
                            onTap: ()  {
                              datacontroller.insertPerson(int.parse(datacontroller.id_controller.text),
                                    datacontroller.person_name_controller.text,widget.personDao);
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
        child: const Icon(Icons.add),
      ),
    );
  }
}