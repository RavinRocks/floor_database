import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../floor/dao/PersonDao.dart';
import '../floor/entity/Person.dart';

class DataController extends GetxController
{
  final TextEditingController idController = TextEditingController();
  final TextEditingController perNameController = TextEditingController();

  late var personData=[].obs;

  insertPerson(int id,String personName, PersonDao personDao)
  async {
    final person = Person(id,personName);
    await personDao.insertPerson(person);
  }

  Future<List<Person>> getAllPerson(PersonDao personDao) async{
    var response =await personDao.findAllPerson();
    personData.value=response;
    update();
    return response;
  }
}