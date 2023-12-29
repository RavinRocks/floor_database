import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../floor/dao/PersonDao.dart';
import '../floor/entity/Person.dart';

class Data_controller extends GetxController
{
  final TextEditingController id_controller = TextEditingController();
  final TextEditingController person_name_controller = TextEditingController();
  final controller = StreamController<Person>();
  late Future<List<Person>> mydata=[].obs as Future<List<Person>>;
  Rx<RxList> personname=RxList().obs;

  insertPerson(int id,String personName, PersonDao personDao)
  async {
      final person = Person(id,personName);
      await personDao.insertPerson(person);
  }
}