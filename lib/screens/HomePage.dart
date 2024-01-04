import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Data_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    DataController controller=Get.put(DataController());

        return Scaffold(
          appBar: AppBar(title: const Text("Todo List"),),
          body: SafeArea(
            child: Container(
            margin: const EdgeInsets.all(5),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                const Text('Person Data',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

                Expanded(
                  child: Obx(() =>  ListView.builder(
                      itemCount: controller.personData.length,
                      itemBuilder: (_, index) {
                        return
                            Card(
                                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                elevation:10 , color: Colors.white,
                                shadowColor: Colors.black,
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                   "ID : ${controller.personData[index].id}",
                                    style: const TextStyle(color: Colors.black,),),
                                  Text(
                                   "Name : ${controller.personData[index].name}",
                                    style: const TextStyle(color: Colors.black,),),
                                ],
                              )),
                        );
                      }
                  ),),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showMyDialog(context, controller);
          },
          child: Container(
            width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.add,color: Colors.white,)),
        ),
      );

  }
}

showMyDialog(BuildContext context,DataController controller)
{

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
              height: 140,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),

              child: Column(children: [

                TextField(
                  controller: controller.perNameController,
                  decoration: const InputDecoration(
                    hintText: " Person Name:",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                InkWell(
                    onTap: ()  {
                      controller.insertPerson();
                      Get.back();
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
}