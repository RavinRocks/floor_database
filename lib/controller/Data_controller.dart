import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/database.dart';
import '../floor/dao/PersonDao.dart';
import '../floor/entity/Person.dart';

class DataController extends GetxController {

  TextEditingController idController = TextEditingController();
  TextEditingController perNameController = TextEditingController();
  RxList personData = [].obs;
  RxString mytext="h".obs;

  late PersonDao dao;

  @override
  void onInit() {
    getAllPerson();
  }

  insertPerson() async {
    if(perNameController.text.isNotEmpty)
      {
        final person = Person(null,perNameController.text);
        await dao.insertPerson(person);
        getAllPerson();
        idController.clear();
        perNameController.clear();
      }
    else {

    }

  }

  getAllPerson() async {
    final database =
    await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    dao = database.personDao;
    personData.value = await dao.findAllPerson();
  }

}