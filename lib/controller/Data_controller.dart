import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../floor/dao/PersonDao.dart';
import '../floor/entity/Person.dart';

class Data_controller extends GetxController
{
  final TextEditingController id_controller = TextEditingController();
  final TextEditingController person_name_controller = TextEditingController();

  insertPerson(int id,String person_name, PersonDao personDao)
  async {
      final person = Person(id,person_name);
      await personDao.insertPerson(person);
  }
}